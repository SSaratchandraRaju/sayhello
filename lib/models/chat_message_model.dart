import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

/// Message type enum
enum MessageType { text, emoji, image, audio, video, file }

@freezed
class ChatMessage with _$ChatMessage {
  const ChatMessage._();

  const factory ChatMessage({
    required String id,
    required String senderId,
    required String senderName,
    required String receiverId,
    required String receiverName,
    required String message,
    required DateTime timestamp,
    @Default(false) bool isRead,
    @Default(MessageType.text) MessageType messageType,
    String? mediaUrl,
    String? fileName,
    int? fileSize,
    Map<String, dynamic>? metadata,
    String? replyToMessageId,
    String? replyToMessage,
    String? replyToSenderName,
    @Default(false) bool isEdited,
    DateTime? editedAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  /// Check if this message was sent by the given user
  bool isSentByUser(String userId) => senderId == userId;

  /// Get conversation ID (ordered by user IDs)
  String get conversationId {
    final ids = [senderId, receiverId]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  /// Create a copy with isRead = true
  ChatMessage markAsRead() => copyWith(isRead: true);
}
