import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';
import '../models/chat_message_model.dart';
import '../services/chat_service.dart';
import '../services/credits_service.dart';
import '../services/agora_rtm_service.dart';
import 'package:intl/intl.dart';

class ChatView extends StatefulWidget {
  final UserModel otherUser;

  const ChatView({Key? key, required this.otherUser}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ChatService _chatService = ChatService();
  final CreditsService _creditsService = CreditsService();
  final AgoraRtmService _rtmService = AgoraRtmService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();

  List<ChatMessage> _messages = [];
  bool _isTyping = false;
  bool _otherUserIsTyping = false;
  bool _showEmojiPicker = false;
  ChatMessage? _replyingToMessage;
  Timer? _typingTimer;
  StreamSubscription? _messagesSubscription;
  StreamSubscription? _conversationsSubscription;
  StreamSubscription? _typingSubscription;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _setupListeners();
    _markMessagesAsRead();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _typingTimer?.cancel();
    _messagesSubscription?.cancel();
    _conversationsSubscription?.cancel();
    _typingSubscription?.cancel();
    super.dispose();
  }

  void _loadMessages() {
    debugPrint('[CHAT_VIEW] 📂 Loading messages for ${widget.otherUser.id}');
    final messages = _chatService.getMessages(widget.otherUser.id);
    debugPrint('[CHAT_VIEW] 📊 Found ${messages.length} messages');

    setState(() {
      _messages = messages;
    });

    debugPrint('[CHAT_VIEW] ✅ Messages loaded and UI updated');

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _setupListeners() {
    debugPrint(
      '[CHAT_VIEW] 🎧 Setting up stream listeners for ${widget.otherUser.name}',
    );

    // Listen for new messages
    _messagesSubscription = _chatService.newMessageStream.listen((message) {
      final preview = message.message.length > 20
          ? '${message.message.substring(0, 20)}...'
          : message.message;
      debugPrint('[CHAT_VIEW] 📨 Received message notification: $preview');
      debugPrint(
        '[CHAT_VIEW] 📝 Message from: ${message.senderId}, to: ${message.receiverId}',
      );
      debugPrint('[CHAT_VIEW] 🔍 Current user: ${widget.otherUser.id}');

      // Only update if message is for this conversation
      if (message.senderId == widget.otherUser.id ||
          message.receiverId == widget.otherUser.id) {
        debugPrint(
          '[CHAT_VIEW] ✅ Message is for this conversation, reloading...',
        );
        _loadMessages();
        _markMessagesAsRead();
      } else {
        debugPrint(
          '[CHAT_VIEW] ⚠️ Message NOT for this conversation (expected ${widget.otherUser.id})',
        );
      }
    });

    // Listen for conversation updates
    _conversationsSubscription = _chatService.conversationsUpdateStream.listen((
      conversationId,
    ) {
      debugPrint('[CHAT_VIEW] 🔄 Conversation update: $conversationId');
      if (conversationId.contains(widget.otherUser.id)) {
        debugPrint(
          '[CHAT_VIEW] ✅ Update is for this conversation, reloading...',
        );
        _loadMessages();
      }
    });

    // Listen for typing indicators
    _typingSubscription = _chatService.typingStream.listen((typingMap) {
      debugPrint('[CHAT_VIEW] ⌨️  Typing indicator update: $typingMap');
      final isTyping = typingMap[widget.otherUser.id] ?? false;
      if (_otherUserIsTyping != isTyping) {
        setState(() {
          _otherUserIsTyping = isTyping;
        });
        debugPrint(
          '[CHAT_VIEW] ✅ ${widget.otherUser.name} typing status: $isTyping',
        );
      }
    });

    debugPrint('[CHAT_VIEW] ✅ Stream listeners setup complete');
  }

  void _markMessagesAsRead() {
    _chatService.markAsRead(widget.otherUser.id);
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();

    if (message.isEmpty) return;

    // Clear input
    _messageController.clear();

    // Stop typing indicator
    _onTypingChanged(false);

    // Send message with reply info if replying
    final sent = await _chatService.sendMessage(
      receiverId: widget.otherUser.id,
      receiverName: widget.otherUser.name,
      message: message,
      replyToMessageId: _replyingToMessage?.id,
      replyToMessage: _replyingToMessage?.message,
      replyToSenderName: _replyingToMessage?.senderName,
    );

    if (sent) {
      // Clear reply state
      setState(() {
        _replyingToMessage = null;
      });
      _loadMessages();
    } else {
      _showError('Failed to send message. Please try again.');
    }
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
    if (_showEmojiPicker) {
      // Hide keyboard
      FocusScope.of(context).unfocus();
    }
  }

  void _sendEmoji(String emoji) async {
    debugPrint('[CHAT_VIEW] 📤 Sending emoji: $emoji');
    
    final sent = await _chatService.sendEmojiMessage(
      receiverId: widget.otherUser.id,
      receiverName: widget.otherUser.name,
      emoji: emoji,
    );

    if (sent) {
      debugPrint('[CHAT_VIEW] ✅ Emoji sent successfully');
      _loadMessages();
      // Close emoji picker
      setState(() {
        _showEmojiPicker = false;
      });
    } else {
      debugPrint('[CHAT_VIEW] ❌ Failed to send emoji');
      _showError('Failed to send emoji. Please try again.');
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF667eea)),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF667eea)),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 400,  // Reduced from 800
        maxHeight: 400,  // Reduced from 800
        imageQuality: 40,  // Reduced from 70 to stay under 32KB RTM limit
      );

      if (image != null) {
        // Read image as bytes and encode to base64
        final bytes = await File(image.path).readAsBytes();
        final base64Image = base64Encode(bytes);
        
        debugPrint('[CHAT] 📸 Image size: ${bytes.length} bytes, base64 length: ${base64Image.length}');
        
        // Check if base64 is too large for RTM (32KB limit)
        if (base64Image.length > 30000) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image too large. Please select a smaller image or take a new photo.'),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 4),
              ),
            );
          }
          debugPrint('[CHAT] ❌ Image too large: ${base64Image.length} bytes (limit: 30KB)');
          return;
        }
        
        // Send image with base64 data in mediaUrl
        final sent = await _chatService.sendImageMessage(
          receiverId: widget.otherUser.id,
          receiverName: widget.otherUser.name,
          imageUrl: base64Image, // Store base64 string
          caption: '📷 Photo',
        );

        if (sent) {
          _loadMessages();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Image sent!')),
            );
          }
        } else {
          _showError('Failed to send image. Please try again.');
        }
      }
    } catch (e) {
      debugPrint('[CHAT] ❌ Error picking image: $e');
      _showError('Failed to pick image: $e');
    }
  }

  void _startReply(ChatMessage message) {
    setState(() {
      _replyingToMessage = message;
    });
    // Focus on text field
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _cancelReply() {
    setState(() {
      _replyingToMessage = null;
    });
  }

  void _deleteMessage(ChatMessage message) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Message'),
        content: const Text('Are you sure you want to delete this message?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final deleted = await _chatService.deleteMessage(
        message.id,
        widget.otherUser.id,
      );
      if (deleted) {
        _loadMessages();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Message deleted')));
      }
    }
  }

  void _showMessageOptions(ChatMessage message, bool isMe) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.reply, color: Color(0xFF667eea)),
              title: const Text('Reply'),
              onTap: () {
                Navigator.pop(context);
                _startReply(message);
              },
            ),
            if (isMe) ...[
              ListTile(
                leading: const Icon(Icons.edit, color: Color(0xFF667eea)),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  _editMessage(message);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteMessage(message);
                },
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _editMessage(ChatMessage message) {
    showDialog(
      context: context,
      builder: (context) => _EditMessageDialog(
        message: message,
        chatService: _chatService,
        onMessageEdited: _loadMessages,
      ),
    );
  }

  void _onTypingChanged(bool isTyping) {
    if (_isTyping != isTyping) {
      setState(() {
        _isTyping = isTyping;
      });

      _chatService.sendTypingIndicator(widget.otherUser.id, isTyping);

      // Auto-stop typing after 3 seconds
      _typingTimer?.cancel();
      if (isTyping) {
        _typingTimer = Timer(const Duration(seconds: 3), () {
          _onTypingChanged(false);
        });
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _initiateCall(bool isVideo) async {
    // Check credits before starting call
    if (!_creditsService.canMakeCall(isVideo)) {
      _showInsufficientCreditsDialog(isVideo);
      return;
    }

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('${isVideo ? 'Video' : 'Voice'} Call'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Call ${widget.otherUser.name}?'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.orange.shade700,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Call Charges',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade900,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${isVideo ? '80' : '40'} credits per minute',
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Available: ${_creditsService.getRemainingCallTime(isVideo)} minutes',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: isVideo ? const Color(0xFF667eea) : Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Call'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _startCall(isVideo);
    }
  }

  Future<void> _startCall(bool isVideo) async {
    final channelName =
        'channel_${widget.otherUser.id}_${DateTime.now().millisecondsSinceEpoch}';

    // Send call request via RTM
    final sent = await _rtmService.sendCallRequest(
      receiverId: widget.otherUser.id,
      receiverName: widget.otherUser.name,
      isVideoCall: isVideo,
      channelName: channelName,
    );

    if (!sent) {
      _showError('Failed to send call request. Please try again.');
      return;
    }

    // Navigate to appropriate call screen
    final routeName = isVideo ? '/video-call' : '/voice-call';
    Get.toNamed(
      routeName,
      arguments: {'user': widget.otherUser, 'channelName': channelName},
    );
  }

  void _showInsufficientCreditsDialog(bool isVideo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade400),
            const SizedBox(width: 12),
            const Text('Insufficient Credits'),
          ],
        ),
        content: Text(
          'You need at least ${isVideo ? '80' : '40'} credits to make a ${isVideo ? 'video' : 'voice'} call.\n\n'
          'Current balance: ${_creditsService.credits.value} credits',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Navigate to credits purchase screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Credits purchase coming soon!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667eea),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Buy Credits'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF667eea),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: widget.otherUser.profilePic != null
                  ? ClipOval(
                      child: Image.network(
                        widget.otherUser.profilePic!,
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Text(
                          widget.otherUser.name[0].toUpperCase(),
                          style: const TextStyle(
                            color: Color(0xFF667eea),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : Text(
                      widget.otherUser.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF667eea),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            // Name and status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.otherUser.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.otherUser.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Video call button
          IconButton(
            icon: const Icon(Icons.videocam),
            tooltip: 'Video Call',
            onPressed: widget.otherUser.isOnline
                ? () => _initiateCall(true)
                : null,
          ),
          // Voice call button
          IconButton(
            icon: const Icon(Icons.phone),
            tooltip: 'Voice Call',
            onPressed: widget.otherUser.isOnline
                ? () => _initiateCall(false)
                : null,
          ),
          // More options
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case 'clear':
                  _showClearChatDialog();
                  break;
                case 'block':
                  // TODO: Block user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Block feature coming soon!')),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'clear', child: Text('Clear chat')),
              const PopupMenuItem(value: 'block', child: Text('Block user')),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF667eea).withOpacity(0.05), Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Messages list
            Expanded(
              child: _messages.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final isMe = message.senderId != widget.otherUser.id;

                        // Check if we need to show date separator
                        bool showDateSeparator = false;
                        if (index == 0) {
                          showDateSeparator = true;
                        } else {
                          final prevMessage = _messages[index - 1];
                          showDateSeparator = !_isSameDay(
                            message.timestamp,
                            prevMessage.timestamp,
                          );
                        }

                        return Column(
                          children: [
                            if (showDateSeparator)
                              _buildDateSeparator(message.timestamp),
                            _buildMessageBubble(message, isMe),
                          ],
                        );
                      },
                    ),
            ),

            // Typing indicator
            if (_otherUserIsTyping)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      '${widget.otherUser.name} is typing',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SizedBox(
                      width: 20,
                      height: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTypingDot(0),
                          _buildTypingDot(1),
                          _buildTypingDot(2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Reply preview
            if (_replyingToMessage != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF667eea).withOpacity(0.1),
                  border: Border(
                    top: BorderSide(color: const Color(0xFF667eea), width: 2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 3,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF667eea),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Replying to ${_replyingToMessage!.senderName}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF667eea),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _replyingToMessage!.message.length > 50
                                ? '${_replyingToMessage!.message.substring(0, 50)}...'
                                : _replyingToMessage!.message,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.grey.shade600,
                      ),
                      onPressed: _cancelReply,
                    ),
                  ],
                ),
              ),

            // Message input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        // Attach button
                        IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            color: Colors.grey.shade600,
                          ),
                          onPressed: _showAttachmentOptions,
                        ),

                        // Emoji button
                        IconButton(
                          icon: Icon(
                            _showEmojiPicker
                                ? Icons.keyboard
                                : Icons.emoji_emotions_outlined,
                            color: const Color(0xFF667eea),
                          ),
                          onPressed: _toggleEmojiPicker,
                        ),

                        // Text field
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (text) {
                                _onTypingChanged(text.isNotEmpty);
                              },
                              onSubmitted: (_) => _sendMessage(),
                              onTap: () {
                                if (_showEmojiPicker) {
                                  setState(() {
                                    _showEmojiPicker = false;
                                  });
                                }
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Send button
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: _sendMessage,
                          ),
                        ),
                      ],
                    ),

                    // Emoji picker
                    if (_showEmojiPicker)
                      SizedBox(
                        height: 300,
                        child: EmojiPicker(
                          onEmojiSelected: (category, emoji) {
                            _sendEmoji(emoji.emoji);
                          },
                          config: Config(
                            height: 300,
                            emojiViewConfig: EmojiViewConfig(
                              emojiSizeMax: 32,
                              backgroundColor: Colors.white,
                              columns: 7,
                              buttonMode: ButtonMode.MATERIAL,
                            ),
                            searchViewConfig: const SearchViewConfig(
                              backgroundColor: Colors.white,
                            ),
                            categoryViewConfig: const CategoryViewConfig(
                              indicatorColor: Color(0xFF667eea),
                              iconColorSelected: Color(0xFF667eea),
                              backgroundColor: Colors.white,
                            ),
                            bottomActionBarConfig: const BottomActionBarConfig(
                              backgroundColor: Colors.white,
                              buttonColor: Colors.white,
                              buttonIconColor: Color(0xFF667eea),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No messages yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start a conversation with ${widget.otherUser.name}',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(DateTime date) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade300)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _formatDateSeparator(date),
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade300)),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => _showMessageOptions(message, isMe),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Column(
            crossAxisAlignment: isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: isMe
                      ? const LinearGradient(
                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                        )
                      : null,
                  color: isMe ? null : Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isMe ? 16 : 4),
                    bottomRight: Radius.circular(isMe ? 4 : 16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Show reply preview if this message is a reply
                    if (message.replyToMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.white.withOpacity(0.2)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(
                              color: isMe
                                  ? Colors.white
                                  : const Color(0xFF667eea),
                              width: 3,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.replyToSenderName ?? 'Unknown',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isMe
                                    ? Colors.white
                                    : const Color(0xFF667eea),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              message.replyToMessage!.length > 50
                                  ? '${message.replyToMessage!.substring(0, 50)}...'
                                  : message.replyToMessage!,
                              style: TextStyle(
                                fontSize: 12,
                                color: isMe
                                    ? Colors.white.withOpacity(0.8)
                                    : Colors.black54,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                    // Message content based on type
                    _buildMessageContent(message, isMe),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  if (message.isEdited) ...[
                    const SizedBox(width: 4),
                    Text(
                      '(edited)',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  if (isMe) ...[
                    const SizedBox(width: 4),
                    Icon(
                      message.isRead ? Icons.done_all : Icons.done,
                      size: 14,
                      color: message.isRead
                          ? Colors.blue
                          : Colors.grey.shade600,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageContent(ChatMessage message, bool isMe) {
    debugPrint('[CHAT_VIEW] 🎨 Rendering message type: ${message.messageType}, message: ${message.message}');
    
    switch (message.messageType) {
      case MessageType.emoji:
        // Display emoji larger like WhatsApp stickers
        debugPrint('[CHAT_VIEW] 😀 Displaying emoji at 64px');
        return Text(
          message.message,
          style: const TextStyle(
            fontSize: 64, // Large size for sticker-like appearance
          ),
        );

      case MessageType.image:
        // Display image with preview (decode base64)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.mediaUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildImageWidget(message.mediaUrl!),
              ),
            if (message.message != '📷 Photo' && message.message != 'Image')
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  message.message,
                  style: TextStyle(
                    fontSize: 14,
                    color: isMe ? Colors.white : Colors.black87,
                  ),
                ),
              ),
          ],
        );

      case MessageType.file:
        // Display file with icon and name
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.white.withOpacity(0.2)
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.insert_drive_file,
                color: isMe ? Colors.white : const Color(0xFF667eea),
                size: 32,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.fileName ?? message.message,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isMe ? Colors.white : Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (message.fileSize != null)
                    Text(
                      _formatFileSize(message.fileSize!),
                      style: TextStyle(
                        fontSize: 12,
                        color: isMe
                            ? Colors.white.withOpacity(0.7)
                            : Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
          ],
        );

      case MessageType.text:
      default:
        // Regular text message
        return Text(
          message.message,
          style: TextStyle(
            fontSize: 15,
            color: isMe ? Colors.white : Colors.black87,
          ),
        );
    }
  }

  Widget _buildImageWidget(String imageData) {
    try {
      // Try to decode as base64 first
      final bytes = base64Decode(imageData);
      return Image.memory(
        bytes,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildImagePlaceholder();
        },
      );
    } catch (e) {
      // If base64 decode fails, try as file path (for backward compatibility)
      final file = File(imageData);
      if (file.existsSync()) {
        return Image.file(
          file,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildImagePlaceholder();
          },
        );
      }
      return _buildImagePlaceholder();
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.grey.shade300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image, size: 48, color: Colors.grey.shade600),
          const SizedBox(height: 8),
          Text(
            'Image',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        final delay = index * 0.2;
        final animValue = (value - delay).clamp(0.0, 1.0);
        final opacity = (animValue * 2).clamp(0.0, 1.0);

        return Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade600.withOpacity(opacity),
          ),
        );
      },
    );
  }

  void _showClearChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Clear chat?'),
        content: Text(
          'This will delete all messages with ${widget.otherUser.name}. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _chatService.deleteConversation(widget.otherUser.id);
              _loadMessages();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Chat cleared')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _formatDateSeparator(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else if (now.difference(date).inDays < 7) {
      return DateFormat('EEEE').format(date);
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }

  String _formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }
}

// Separate StatefulWidget for edit dialog to properly manage controller lifecycle
class _EditMessageDialog extends StatefulWidget {
  final ChatMessage message;
  final ChatService chatService;
  final VoidCallback onMessageEdited;

  const _EditMessageDialog({
    required this.message,
    required this.chatService,
    required this.onMessageEdited,
  });

  @override
  State<_EditMessageDialog> createState() => _EditMessageDialogState();
}

class _EditMessageDialogState extends State<_EditMessageDialog> {
  late final TextEditingController _editController;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.message.message);
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Edit Message'),
      content: TextField(
        controller: _editController,
        decoration: const InputDecoration(
          hintText: 'Edit your message...',
          border: OutlineInputBorder(),
        ),
        maxLines: null,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final newMessage = _editController.text.trim();
            if (newMessage.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Message cannot be empty')),
              );
              return;
            }

            if (newMessage == widget.message.message) {
              // No changes made
              Navigator.pop(context);
              return;
            }

            final edited = await widget.chatService.editMessage(
              widget.message.id,
              widget.message.receiverId,
              newMessage,
            );

            if (edited && context.mounted) {
              widget.onMessageEdited();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Message edited')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF667eea),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
