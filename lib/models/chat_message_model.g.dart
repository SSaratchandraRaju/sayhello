// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      receiverId: json['receiverId'] as String,
      receiverName: json['receiverName'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
      messageType:
          $enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']) ??
          MessageType.text,
      mediaUrl: json['mediaUrl'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: (json['fileSize'] as num?)?.toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      replyToMessageId: json['replyToMessageId'] as String?,
      replyToMessage: json['replyToMessage'] as String?,
      replyToSenderName: json['replyToSenderName'] as String?,
      isEdited: json['isEdited'] as bool? ?? false,
      editedAt: json['editedAt'] == null
          ? null
          : DateTime.parse(json['editedAt'] as String),
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'receiverId': instance.receiverId,
      'receiverName': instance.receiverName,
      'message': instance.message,
      'timestamp': instance.timestamp.toIso8601String(),
      'isRead': instance.isRead,
      'messageType': _$MessageTypeEnumMap[instance.messageType]!,
      'mediaUrl': instance.mediaUrl,
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'metadata': instance.metadata,
      'replyToMessageId': instance.replyToMessageId,
      'replyToMessage': instance.replyToMessage,
      'replyToSenderName': instance.replyToSenderName,
      'isEdited': instance.isEdited,
      'editedAt': instance.editedAt?.toIso8601String(),
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.emoji: 'emoji',
  MessageType.image: 'image',
  MessageType.audio: 'audio',
  MessageType.video: 'video',
  MessageType.file: 'file',
};
