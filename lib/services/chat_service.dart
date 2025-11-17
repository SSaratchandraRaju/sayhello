import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/chat_message_model.dart';
import '../models/user_model.dart';
import 'agora_rtm_service.dart';

/// Service to manage chat conversations and messages
///
/// Features:
/// - Send and receive messages
/// - Store messages locally
/// - Track unread counts per conversation
/// - Provide real-time message streams
/// - Handle typing indicators
class ChatService {
  // ===== SINGLETON PATTERN =====
  ChatService._internal();
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;

  // ===== DEPENDENCIES =====
  final AgoraRtmService _rtmService = AgoraRtmService();

  // ===== STORAGE =====
  SharedPreferences? _prefs;
  static const String _messagesKey = 'chat_messages';
  static const String _unreadCountsKey = 'unread_counts';

  // ===== STATE =====
  final Map<String, List<ChatMessage>> _conversations = {};
  final Map<String, int> _unreadCounts = {};
  final Map<String, bool> _typingIndicators = {};

  // ===== STREAMS =====
  final StreamController<ChatMessage> _newMessageController =
      StreamController<ChatMessage>.broadcast();
  final StreamController<String> _conversationsUpdateController =
      StreamController<String>.broadcast();
  final StreamController<Map<String, int>> _unreadCountsController =
      StreamController<Map<String, int>>.broadcast();
  final StreamController<Map<String, bool>> _typingController =
      StreamController<Map<String, bool>>.broadcast();

  Stream<ChatMessage> get newMessageStream => _newMessageController.stream;
  Stream<String> get conversationsUpdateStream =>
      _conversationsUpdateController.stream;
  Stream<Map<String, int>> get unreadCountsStream =>
      _unreadCountsController.stream;
  Stream<Map<String, bool>> get typingStream => _typingController.stream;

  // ===== CURRENT USER =====
  UserModel? _currentUser;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  // ===== INITIALIZATION =====

  Future<void> initialize(UserModel user) async {
    if (_isInitialized) {
      debugPrint('[CHAT] Already initialized');
      return;
    }

    _currentUser = user;

    try {
      debugPrint('[CHAT] 🚀 Initializing for user: ${user.name}');

      // Initialize SharedPreferences
      _prefs = await SharedPreferences.getInstance();

      // Load stored messages
      await _loadMessages();

      // Load unread counts
      await _loadUnreadCounts();

      // Note: RTM message listener will be setup by OnlineUsersService
      // after both RTM and Chat services are initialized
      // This prevents callbacks from being overwritten

      _isInitialized = true;
      debugPrint('[CHAT] ✨ Initialization complete');
      debugPrint('[CHAT] Loaded ${_conversations.length} conversations');
    } catch (e, stack) {
      debugPrint('[CHAT] ❌ Initialization failed: $e');
      debugPrint('[CHAT] Stack: $stack');
      _isInitialized = false;
    }
  }

  /// Setup RTM message listener for incoming chat messages
  /// This should be called AFTER RTM service is fully initialized
  void setupRTMMessageListener() {
    debugPrint('[CHAT] 📡 Setting up RTM message listener');
    _setupMessageListener();
  }

  /// Setup RTM message listener for incoming chat messages
  void _setupMessageListener() {
    _rtmService.onChatMessage = (messageData) {
      try {
        debugPrint('[CHAT] 📨 Processing incoming message');

        final metadata = messageData['metadata'] as Map<String, dynamic>?;
        final messageType = _getMessageTypeFromMetadata(metadata);

        final message = ChatMessage(
          id: messageData['messageId'] as String,
          senderId: messageData['senderId'] as String,
          senderName: messageData['senderName'] as String,
          receiverId: messageData['receiverId'] as String,
          receiverName: _currentUser?.name ?? 'Me',
          message: messageData['message'] as String,
          timestamp: DateTime.fromMillisecondsSinceEpoch(
            messageData['timestamp'] as int,
          ),
          isRead: false,
          messageType: messageType,
          metadata: metadata,
          mediaUrl: metadata?['imageUrl'] as String? ??
              metadata?['fileUrl'] as String?,
          fileName: metadata?['fileName'] as String?,
          fileSize: metadata?['fileSize'] as int?,
        );

        // Add to conversations
        _addMessage(message);

        // Increment unread count
        _incrementUnreadCount(message.conversationId);

        // Notify listeners
        debugPrint(
          '[CHAT] 📢 Broadcasting message to ${_newMessageController.hasListener ? "active" : "NO"} listeners',
        );
        _newMessageController.add(message);
        _conversationsUpdateController.add(message.conversationId);

        debugPrint('[CHAT] ✅ Message processed and stored');
        debugPrint('[CHAT] 💬 Message: ${message.message}');
        debugPrint(
          '[CHAT] 📊 Conversation has ${_conversations[message.conversationId]?.length ?? 0} messages',
        );
      } catch (e) {
        debugPrint('[CHAT] ❌ Error processing message: $e');
      }
    };

    // Setup typing indicator listener
    _rtmService.onTypingIndicator = (typingData) {
      try {
        final senderId = typingData['senderId'] as String;
        final isTyping = typingData['isTyping'] as bool;

        debugPrint('[CHAT] ⌨️  Typing indicator from $senderId: $isTyping');

        // Update typing indicators map
        if (isTyping) {
          _typingIndicators[senderId] = true;
        } else {
          _typingIndicators.remove(senderId);
        }

        // Notify listeners
        _typingController.add(Map.from(_typingIndicators));

        debugPrint('[CHAT] ✅ Typing indicator updated: $_typingIndicators');
      } catch (e) {
        debugPrint('[CHAT] ❌ Error processing typing indicator: $e');
      }
    };

    // Setup read receipt listener
    _rtmService.onReadReceipt = (receiptData) {
      try {
        final messageId = receiptData['messageId'] as String;
        final senderId = receiptData['senderId'] as String;

        debugPrint(
          '[CHAT] ✓✓ Read receipt for message $messageId from $senderId',
        );

        // Update message read status
        _markMessageAsRead(messageId);

        debugPrint('[CHAT] ✅ Message marked as read');
      } catch (e) {
        debugPrint('[CHAT] ❌ Error processing read receipt: $e');
      }
    };

    // Setup message deletion listener
    _rtmService.onMessageDeleted = (deletionData) {
      try {
        final messageId = deletionData['messageId'] as String;
        final senderId = deletionData['senderId'] as String;

        debugPrint(
          '[CHAT] 🗑️  Message deletion notification: $messageId from $senderId',
        );

        // Delete the message locally
        _deleteMessageLocally(messageId, senderId);

        debugPrint('[CHAT] ✅ Message deleted remotely');
      } catch (e) {
        debugPrint('[CHAT] ❌ Error processing message deletion: $e');
      }
    };

    // Setup message edit listener
    _rtmService.onMessageEdited = (editData) {
      try {
        final messageId = editData['messageId'] as String;
        final senderId = editData['senderId'] as String;
        final newMessage = editData['newMessage'] as String;

        debugPrint(
          '[CHAT] ✏️  Message edit notification: $messageId from $senderId',
        );

        // Edit the message locally
        _editMessageLocally(messageId, senderId, newMessage);

        debugPrint('[CHAT] ✅ Message edited remotely');
      } catch (e) {
        debugPrint('[CHAT] ❌ Error processing message edit: $e');
      }
    };
  }

  // ===== MESSAGE MANAGEMENT =====

  /// Send a text message
  Future<bool> sendMessage({
    required String receiverId,
    required String receiverName,
    required String message,
    Map<String, dynamic>? metadata,
    String? replyToMessageId,
    String? replyToMessage,
    String? replyToSenderName,
  }) async {
    if (!_isInitialized || _currentUser == null) {
      debugPrint('[CHAT] ❌ Not initialized');
      return false;
    }

    if (message.trim().isEmpty) {
      debugPrint('[CHAT] ❌ Cannot send empty message');
      return false;
    }

    try {
      // Create message object
      final chatMessage = ChatMessage(
        id: '${_currentUser!.id}_${DateTime.now().millisecondsSinceEpoch}',
        senderId: _currentUser!.id,
        senderName: _currentUser!.name,
        receiverId: receiverId,
        receiverName: receiverName,
        message: message,
        timestamp: DateTime.now(),
        isRead: false,
        messageType: MessageType.text,
        metadata: metadata,
        replyToMessageId: replyToMessageId,
        replyToMessage: replyToMessage,
        replyToSenderName: replyToSenderName,
      );

      // Send via RTM
      final sent = await _rtmService.sendChatMessage(
        receiverId: receiverId,
        message: message,
        metadata: metadata,
      );

      if (!sent) {
        debugPrint('[CHAT] ❌ Failed to send message via RTM');
        return false;
      }

      // Add to local storage
      _addMessage(chatMessage);

      // Notify listeners
      _conversationsUpdateController.add(chatMessage.conversationId);

      debugPrint('[CHAT] ✅ Message sent successfully');
      return true;
    } catch (e) {
      debugPrint('[CHAT] ❌ Error sending message: $e');
      return false;
    }
  }

  /// Send an emoji message (displayed larger like stickers)
  Future<bool> sendEmojiMessage({
    required String receiverId,
    required String receiverName,
    required String emoji,
  }) async {
    if (!_isInitialized || _currentUser == null) {
      debugPrint('[CHAT] ❌ Not initialized');
      return false;
    }

    try {
      // Create emoji message object
      final chatMessage = ChatMessage(
        id: '${_currentUser!.id}_${DateTime.now().millisecondsSinceEpoch}',
        senderId: _currentUser!.id,
        senderName: _currentUser!.name,
        receiverId: receiverId,
        receiverName: receiverName,
        message: emoji,
        timestamp: DateTime.now(),
        isRead: false,
        messageType: MessageType.emoji,
      );

      // Send via RTM with metadata indicating it's an emoji
      final sent = await _rtmService.sendChatMessage(
        receiverId: receiverId,
        message: emoji,
        metadata: {'type': 'emoji'},
      );

      if (!sent) {
        debugPrint('[CHAT] ❌ Failed to send emoji via RTM');
        return false;
      }

      // Add to local storage
      _addMessage(chatMessage);

      // Notify listeners
      _conversationsUpdateController.add(chatMessage.conversationId);

      debugPrint('[CHAT] ✅ Emoji sent successfully');
      return true;
    } catch (e) {
      debugPrint('[CHAT] ❌ Error sending emoji: $e');
      return false;
    }
  }

  /// Send an image message
  Future<bool> sendImageMessage({
    required String receiverId,
    required String receiverName,
    required String imageUrl,
    String? caption,
  }) async {
    if (!_isInitialized || _currentUser == null) {
      debugPrint('[CHAT] ❌ Not initialized');
      return false;
    }

    try {
      // Create image message object
      final chatMessage = ChatMessage(
        id: '${_currentUser!.id}_${DateTime.now().millisecondsSinceEpoch}',
        senderId: _currentUser!.id,
        senderName: _currentUser!.name,
        receiverId: receiverId,
        receiverName: receiverName,
        message: caption ?? 'Image',
        timestamp: DateTime.now(),
        isRead: false,
        messageType: MessageType.image,
        mediaUrl: imageUrl,
      );

      // Send via RTM with metadata
      final sent = await _rtmService.sendChatMessage(
        receiverId: receiverId,
        message: caption ?? 'Image',
        metadata: {
          'type': 'image',
          'imageUrl': imageUrl,
        },
      );

      if (!sent) {
        debugPrint('[CHAT] ❌ Failed to send image via RTM');
        return false;
      }

      // Add to local storage
      _addMessage(chatMessage);

      // Notify listeners
      _conversationsUpdateController.add(chatMessage.conversationId);

      debugPrint('[CHAT] ✅ Image sent successfully');
      return true;
    } catch (e) {
      debugPrint('[CHAT] ❌ Error sending image: $e');
      return false;
    }
  }

  /// Send a file message
  Future<bool> sendFileMessage({
    required String receiverId,
    required String receiverName,
    required String fileUrl,
    required String fileName,
    required int fileSize,
  }) async {
    if (!_isInitialized || _currentUser == null) {
      debugPrint('[CHAT] ❌ Not initialized');
      return false;
    }

    try {
      // Create file message object
      final chatMessage = ChatMessage(
        id: '${_currentUser!.id}_${DateTime.now().millisecondsSinceEpoch}',
        senderId: _currentUser!.id,
        senderName: _currentUser!.name,
        receiverId: receiverId,
        receiverName: receiverName,
        message: fileName,
        timestamp: DateTime.now(),
        isRead: false,
        messageType: MessageType.file,
        mediaUrl: fileUrl,
        fileName: fileName,
        fileSize: fileSize,
      );

      // Send via RTM with metadata
      final sent = await _rtmService.sendChatMessage(
        receiverId: receiverId,
        message: fileName,
        metadata: {
          'type': 'file',
          'fileUrl': fileUrl,
          'fileName': fileName,
          'fileSize': fileSize,
        },
      );

      if (!sent) {
        debugPrint('[CHAT] ❌ Failed to send file via RTM');
        return false;
      }

      // Add to local storage
      _addMessage(chatMessage);

      // Notify listeners
      _conversationsUpdateController.add(chatMessage.conversationId);

      debugPrint('[CHAT] ✅ File sent successfully');
      return true;
    } catch (e) {
      debugPrint('[CHAT] ❌ Error sending file: $e');
      return false;
    }
  }

  /// Add message to conversation
  void _addMessage(ChatMessage message) {
    final conversationId = message.conversationId;

    if (!_conversations.containsKey(conversationId)) {
      _conversations[conversationId] = [];
    }

    _conversations[conversationId]!.add(message);

    // Save to persistent storage
    _saveMessages();
  }

  /// Get messages for a conversation
  List<ChatMessage> getMessages(String userId) {
    final conversationId = _getConversationId(_currentUser!.id, userId);
    return _conversations[conversationId] ?? [];
  }

  /// Get all conversations
  Map<String, List<ChatMessage>> getAllConversations() {
    return Map.from(_conversations);
  }

  /// Get conversation preview (last message, etc.)
  ChatMessage? getLastMessage(String userId) {
    final messages = getMessages(userId);
    if (messages.isEmpty) return null;
    return messages.last;
  }

  /// Mark messages as read for a conversation
  Future<void> markAsRead(String userId) async {
    if (_currentUser == null) return;

    final conversationId = _getConversationId(_currentUser!.id, userId);
    final messages = _conversations[conversationId];

    if (messages == null) return;

    // Mark all unread messages as read
    for (int i = 0; i < messages.length; i++) {
      if (!messages[i].isRead && messages[i].receiverId == _currentUser!.id) {
        messages[i] = messages[i].markAsRead();

        // Send read receipt to sender
        await _rtmService.sendReadReceipt(
          receiverId: messages[i].senderId,
          messageId: messages[i].id,
        );
      }
    }

    // Reset unread count
    _unreadCounts[conversationId] = 0;
    _saveUnreadCounts();
    _unreadCountsController.add(Map.from(_unreadCounts));

    // Save updated messages
    _saveMessages();
  }

  /// Mark a specific message as read by messageId
  void _markMessageAsRead(String messageId) {
    // Find the message in all conversations and mark it as read
    for (var conversationMessages in _conversations.values) {
      for (int i = 0; i < conversationMessages.length; i++) {
        if (conversationMessages[i].id == messageId &&
            !conversationMessages[i].isRead) {
          conversationMessages[i] = conversationMessages[i].markAsRead();
          _saveMessages();

          // Notify about the conversation update
          _conversationsUpdateController.add(
            conversationMessages[i].conversationId,
          );
          return;
        }
      }
    }
  }

  /// Get unread count for a conversation
  int getUnreadCount(String userId) {
    final conversationId = _getConversationId(_currentUser!.id, userId);
    return _unreadCounts[conversationId] ?? 0;
  }

  /// Get total unread count
  int getTotalUnreadCount() {
    return _unreadCounts.values.fold(0, (sum, count) => sum + count);
  }

  /// Increment unread count
  void _incrementUnreadCount(String conversationId) {
    _unreadCounts[conversationId] = (_unreadCounts[conversationId] ?? 0) + 1;
    _saveUnreadCounts();
    _unreadCountsController.add(Map.from(_unreadCounts));
  }

  /// Delete a conversation
  Future<void> deleteConversation(String userId) async {
    if (_currentUser == null) return;

    final conversationId = _getConversationId(_currentUser!.id, userId);
    _conversations.remove(conversationId);
    _unreadCounts.remove(conversationId);

    await _saveMessages();
    await _saveUnreadCounts();

    _conversationsUpdateController.add(conversationId);
    _unreadCountsController.add(Map.from(_unreadCounts));
  }

  /// Delete a specific message
  Future<bool> deleteMessage(String messageId, String userId) async {
    if (_currentUser == null) return false;

    final conversationId = _getConversationId(_currentUser!.id, userId);
    final messages = _conversations[conversationId];

    if (messages == null) return false;

    // Find and remove the message
    final initialLength = messages.length;
    messages.removeWhere((msg) => msg.id == messageId);

    if (messages.length < initialLength) {
      // Message was deleted locally
      await _saveMessages();
      _conversationsUpdateController.add(conversationId);

      // Send deletion notification to other user
      await _rtmService.sendMessageDeletion(
        receiverId: userId,
        messageId: messageId,
      );

      debugPrint('[CHAT] ✅ Message deleted: $messageId');
      return true;
    }

    return false;
  }

  /// Delete message locally (called when remote user deletes)
  void _deleteMessageLocally(String messageId, String otherUserId) {
    if (_currentUser == null) return;

    final conversationId = _getConversationId(_currentUser!.id, otherUserId);
    final messages = _conversations[conversationId];

    if (messages == null) return;

    messages.removeWhere((msg) => msg.id == messageId);
    _saveMessages();
    _conversationsUpdateController.add(conversationId);
  }

  /// Edit a specific message
  Future<bool> editMessage(
    String messageId,
    String userId,
    String newMessage,
  ) async {
    if (_currentUser == null) return false;

    final conversationId = _getConversationId(_currentUser!.id, userId);
    final messages = _conversations[conversationId];

    if (messages == null) return false;

    // Find and update the message
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].id == messageId) {
        messages[i] = messages[i].copyWith(
          message: newMessage,
          isEdited: true,
          editedAt: DateTime.now(),
        );

        await _saveMessages();
        _conversationsUpdateController.add(conversationId);

        // Send edit notification to other user
        await _rtmService.sendMessageEdit(
          receiverId: userId,
          messageId: messageId,
          newMessage: newMessage,
        );

        debugPrint('[CHAT] ✅ Message edited: $messageId');
        return true;
      }
    }

    return false;
  }

  /// Edit message locally (called when remote user edits)
  void _editMessageLocally(
    String messageId,
    String otherUserId,
    String newMessage,
  ) {
    if (_currentUser == null) return;

    final conversationId = _getConversationId(_currentUser!.id, otherUserId);
    final messages = _conversations[conversationId];

    if (messages == null) return;

    for (int i = 0; i < messages.length; i++) {
      if (messages[i].id == messageId) {
        messages[i] = messages[i].copyWith(
          message: newMessage,
          isEdited: true,
          editedAt: DateTime.now(),
        );
        _saveMessages();
        _conversationsUpdateController.add(conversationId);
        break;
      }
    }
  }

  // ===== TYPING INDICATORS =====

  /// Send typing indicator
  Future<void> sendTypingIndicator(String userId, bool isTyping) async {
    await _rtmService.sendTypingIndicator(
      receiverId: userId,
      isTyping: isTyping,
    );
  }

  /// Check if user is typing
  bool isUserTyping(String userId) {
    return _typingIndicators[userId] ?? false;
  }

  // ===== PERSISTENCE =====

  /// Load messages from SharedPreferences
  Future<void> _loadMessages() async {
    if (_prefs == null) return;

    try {
      final messagesJson = _prefs!.getString(_messagesKey);
      if (messagesJson == null) return;

      final Map<String, dynamic> data = jsonDecode(messagesJson);

      data.forEach((conversationId, messagesList) {
        final List<dynamic> messagesData = messagesList;
        _conversations[conversationId] = messagesData
            .map((json) => ChatMessage.fromJson(json as Map<String, dynamic>))
            .toList();
      });

      debugPrint(
        '[CHAT] ✅ Loaded ${_conversations.length} conversations from storage',
      );
    } catch (e) {
      debugPrint('[CHAT] ⚠️  Error loading messages: $e');
    }
  }

  /// Save messages to SharedPreferences
  Future<void> _saveMessages() async {
    if (_prefs == null) return;

    try {
      final Map<String, dynamic> data = {};

      _conversations.forEach((conversationId, messages) {
        data[conversationId] = messages.map((msg) => msg.toJson()).toList();
      });

      final messagesJson = jsonEncode(data);
      await _prefs!.setString(_messagesKey, messagesJson);
    } catch (e) {
      debugPrint('[CHAT] ⚠️  Error saving messages: $e');
    }
  }

  /// Load unread counts from SharedPreferences
  Future<void> _loadUnreadCounts() async {
    if (_prefs == null) return;

    try {
      final countsJson = _prefs!.getString(_unreadCountsKey);
      if (countsJson == null) return;

      final Map<String, dynamic> data = jsonDecode(countsJson);
      data.forEach((key, value) {
        _unreadCounts[key] = value as int;
      });

      debugPrint('[CHAT] ✅ Loaded unread counts');
      _unreadCountsController.add(Map.from(_unreadCounts));
    } catch (e) {
      debugPrint('[CHAT] ⚠️  Error loading unread counts: $e');
    }
  }

  /// Save unread counts to SharedPreferences
  Future<void> _saveUnreadCounts() async {
    if (_prefs == null) return;

    try {
      final countsJson = jsonEncode(_unreadCounts);
      await _prefs!.setString(_unreadCountsKey, countsJson);
    } catch (e) {
      debugPrint('[CHAT] ⚠️  Error saving unread counts: $e');
    }
  }

  // ===== UTILITIES =====

  /// Get conversation ID from two user IDs
  String _getConversationId(String userId1, String userId2) {
    final ids = [userId1, userId2]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  /// Determine message type from metadata
  MessageType _getMessageTypeFromMetadata(Map<String, dynamic>? metadata) {
    if (metadata == null) {
      debugPrint('[CHAT] 📋 No metadata, defaulting to text');
      return MessageType.text;
    }

    final type = metadata['type'] as String?;
    debugPrint('[CHAT] 📋 Metadata type: $type');
    
    switch (type) {
      case 'emoji':
        debugPrint('[CHAT] 😀 Detected emoji message type');
        return MessageType.emoji;
      case 'image':
        debugPrint('[CHAT] 📸 Detected image message type');
        return MessageType.image;
      case 'file':
        return MessageType.file;
      case 'audio':
        return MessageType.audio;
      case 'video':
        return MessageType.video;
      default:
        debugPrint('[CHAT] 📝 Defaulting to text message type');
        return MessageType.text;
    }
  }

  /// Clear all data
  Future<void> clearAll() async {
    _conversations.clear();
    _unreadCounts.clear();
    _typingIndicators.clear();

    await _prefs?.remove(_messagesKey);
    await _prefs?.remove(_unreadCountsKey);

    debugPrint('[CHAT] 🧹 All data cleared');
  }

  /// Dispose
  void dispose() {
    _newMessageController.close();
    _conversationsUpdateController.close();
    _unreadCountsController.close();
    _typingController.close();

    _isInitialized = false;
    debugPrint('[CHAT] ✅ Disposed');
  }
}
