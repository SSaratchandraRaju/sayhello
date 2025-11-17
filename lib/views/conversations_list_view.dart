import 'package:flutter/material.dart';
import 'dart:async';
import '../models/user_model.dart';
import '../models/chat_message_model.dart';
import '../services/chat_service.dart';
import '../services/online_users_service.dart';
import 'chat_view.dart';
import 'package:intl/intl.dart';

class ConversationsListView extends StatefulWidget {
  const ConversationsListView({Key? key}) : super(key: key);

  @override
  State<ConversationsListView> createState() => _ConversationsListViewState();
}

class _ConversationsListViewState extends State<ConversationsListView> {
  final ChatService _chatService = ChatService();
  final OnlineUsersService _onlineService = OnlineUsersService();

  List<ConversationItem> _conversations = [];
  StreamSubscription? _conversationsSubscription;
  StreamSubscription? _unreadCountsSubscription;
  StreamSubscription? _newMessageSubscription;

  @override
  void initState() {
    super.initState();
    _loadConversations();
    _setupListeners();
  }

  @override
  void dispose() {
    _conversationsSubscription?.cancel();
    _unreadCountsSubscription?.cancel();
    _newMessageSubscription?.cancel();
    super.dispose();
  }

  void _loadConversations() {
    final allConversations = _chatService.getAllConversations();
    final List<ConversationItem> items = [];

    allConversations.forEach((conversationId, messages) {
      if (messages.isEmpty) return;

      final lastMessage = messages.last;
      final currentUserId = _onlineService.currentUser?.id;

      // Determine the other user
      final otherUserId = lastMessage.senderId == currentUserId
          ? lastMessage.receiverId
          : lastMessage.senderId;

      final otherUserName = lastMessage.senderId == currentUserId
          ? lastMessage.receiverName
          : lastMessage.senderName;

      // Get unread count
      final unreadCount = _chatService.getUnreadCount(otherUserId);

      // Check if user is online
      final isOnline = _onlineService.onlineUserIds.value.contains(otherUserId);

      items.add(
        ConversationItem(
          userId: otherUserId,
          userName: otherUserName,
          lastMessage: lastMessage,
          unreadCount: unreadCount,
          isOnline: isOnline,
        ),
      );
    });

    // Sort by last message timestamp (most recent first)
    items.sort(
      (a, b) => b.lastMessage.timestamp.compareTo(a.lastMessage.timestamp),
    );

    setState(() {
      _conversations = items;
    });
  }

  void _setupListeners() {
    // Listen for conversation updates
    _conversationsSubscription = _chatService.conversationsUpdateStream.listen((
      _,
    ) {
      _loadConversations();
    });

    // Listen for unread count updates
    _unreadCountsSubscription = _chatService.unreadCountsStream.listen((_) {
      _loadConversations();
    });

    // Listen for new messages
    _newMessageSubscription = _chatService.newMessageStream.listen((_) {
      _loadConversations();
    });
  }

  void _openChat(ConversationItem item) {
    // Create a UserModel for the chat view
    final user = UserModel(
      id: item.userId,
      name: item.userName,
      age: 0,
      gender: 'Unknown',
      location: 'Unknown',
      isOnline: item.isOnline,
      agoraUid: item.userId,
    );

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => ChatView(otherUser: user)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Messages',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your conversations',
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                    // Total unread count badge
                    StreamBuilder<Map<String, int>>(
                      stream: _chatService.unreadCountsStream,
                      builder: (context, snapshot) {
                        final totalUnread = _chatService.getTotalUnreadCount();
                        if (totalUnread == 0) return const SizedBox.shrink();

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            totalUnread > 99 ? '99+' : totalUnread.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Conversations list
              Expanded(
                child: _conversations.isEmpty
                    ? _buildEmptyState()
                    : RefreshIndicator(
                        onRefresh: () async {
                          _loadConversations();
                        },
                        color: const Color(0xFF667eea),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _conversations.length,
                          itemBuilder: (context, index) {
                            final conversation = _conversations[index];
                            return _buildConversationCard(conversation);
                          },
                        ),
                      ),
              ),
            ],
          ),
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
            color: Colors.white.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No conversations yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start chatting with someone!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationCard(ConversationItem item) {
    final currentUserId = _onlineService.currentUser?.id;
    final isLastMessageFromMe = item.lastMessage.senderId == currentUserId;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _openChat(item),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Profile Picture
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFF667eea),
                      child: Text(
                        item.userName[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (item.isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(width: 12),

                // Conversation Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and timestamp
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.userName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2d3436),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            _formatTimestamp(item.lastMessage.timestamp),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Last message and unread count
                      Row(
                        children: [
                          if (isLastMessageFromMe) ...[
                            Icon(
                              item.lastMessage.isRead
                                  ? Icons.done_all
                                  : Icons.done,
                              size: 14,
                              color: item.lastMessage.isRead
                                  ? Colors.blue
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                          ],
                          Expanded(
                            child: Text(
                              item.lastMessage.message,
                              style: TextStyle(
                                fontSize: 14,
                                color: item.unreadCount > 0
                                    ? Colors.black87
                                    : Colors.grey.shade600,
                                fontWeight: item.unreadCount > 0
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (item.unreadCount > 0) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF667eea),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                item.unreadCount > 99
                                    ? '99+'
                                    : item.unreadCount.toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return DateFormat('EEE').format(timestamp);
    } else {
      return DateFormat('MMM d').format(timestamp);
    }
  }
}

/// Helper class to represent a conversation item
class ConversationItem {
  final String userId;
  final String userName;
  final ChatMessage lastMessage;
  final int unreadCount;
  final bool isOnline;

  ConversationItem({
    required this.userId,
    required this.userName,
    required this.lastMessage,
    required this.unreadCount,
    required this.isOnline,
  });
}
