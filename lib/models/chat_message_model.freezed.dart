// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  String get receiverName => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  MessageType get messageType => throw _privateConstructorUsedError;
  String? get mediaUrl => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  int? get fileSize => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  String? get replyToMessageId => throw _privateConstructorUsedError;
  String? get replyToMessage => throw _privateConstructorUsedError;
  String? get replyToSenderName => throw _privateConstructorUsedError;
  bool get isEdited => throw _privateConstructorUsedError;
  DateTime? get editedAt => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String receiverId,
    String receiverName,
    String message,
    DateTime timestamp,
    bool isRead,
    MessageType messageType,
    String? mediaUrl,
    String? fileName,
    int? fileSize,
    Map<String, dynamic>? metadata,
    String? replyToMessageId,
    String? replyToMessage,
    String? replyToSenderName,
    bool isEdited,
    DateTime? editedAt,
  });
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? receiverId = null,
    Object? receiverName = null,
    Object? message = null,
    Object? timestamp = null,
    Object? isRead = null,
    Object? messageType = null,
    Object? mediaUrl = freezed,
    Object? fileName = freezed,
    Object? fileSize = freezed,
    Object? metadata = freezed,
    Object? replyToMessageId = freezed,
    Object? replyToMessage = freezed,
    Object? replyToSenderName = freezed,
    Object? isEdited = null,
    Object? editedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverId: null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverName: null == receiverName
                ? _value.receiverName
                : receiverName // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            messageType: null == messageType
                ? _value.messageType
                : messageType // ignore: cast_nullable_to_non_nullable
                      as MessageType,
            mediaUrl: freezed == mediaUrl
                ? _value.mediaUrl
                : mediaUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileName: freezed == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileSize: freezed == fileSize
                ? _value.fileSize
                : fileSize // ignore: cast_nullable_to_non_nullable
                      as int?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            replyToMessageId: freezed == replyToMessageId
                ? _value.replyToMessageId
                : replyToMessageId // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyToMessage: freezed == replyToMessage
                ? _value.replyToMessage
                : replyToMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyToSenderName: freezed == replyToSenderName
                ? _value.replyToSenderName
                : replyToSenderName // ignore: cast_nullable_to_non_nullable
                      as String?,
            isEdited: null == isEdited
                ? _value.isEdited
                : isEdited // ignore: cast_nullable_to_non_nullable
                      as bool,
            editedAt: freezed == editedAt
                ? _value.editedAt
                : editedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderName,
    String receiverId,
    String receiverName,
    String message,
    DateTime timestamp,
    bool isRead,
    MessageType messageType,
    String? mediaUrl,
    String? fileName,
    int? fileSize,
    Map<String, dynamic>? metadata,
    String? replyToMessageId,
    String? replyToMessage,
    String? replyToSenderName,
    bool isEdited,
    DateTime? editedAt,
  });
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderName = null,
    Object? receiverId = null,
    Object? receiverName = null,
    Object? message = null,
    Object? timestamp = null,
    Object? isRead = null,
    Object? messageType = null,
    Object? mediaUrl = freezed,
    Object? fileName = freezed,
    Object? fileSize = freezed,
    Object? metadata = freezed,
    Object? replyToMessageId = freezed,
    Object? replyToMessage = freezed,
    Object? replyToSenderName = freezed,
    Object? isEdited = null,
    Object? editedAt = freezed,
  }) {
    return _then(
      _$ChatMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverId: null == receiverId
            ? _value.receiverId
            : receiverId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverName: null == receiverName
            ? _value.receiverName
            : receiverName // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        messageType: null == messageType
            ? _value.messageType
            : messageType // ignore: cast_nullable_to_non_nullable
                  as MessageType,
        mediaUrl: freezed == mediaUrl
            ? _value.mediaUrl
            : mediaUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileName: freezed == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileSize: freezed == fileSize
            ? _value.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        replyToMessageId: freezed == replyToMessageId
            ? _value.replyToMessageId
            : replyToMessageId // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyToMessage: freezed == replyToMessage
            ? _value.replyToMessage
            : replyToMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyToSenderName: freezed == replyToSenderName
            ? _value.replyToSenderName
            : replyToSenderName // ignore: cast_nullable_to_non_nullable
                  as String?,
        isEdited: null == isEdited
            ? _value.isEdited
            : isEdited // ignore: cast_nullable_to_non_nullable
                  as bool,
        editedAt: freezed == editedAt
            ? _value.editedAt
            : editedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl extends _ChatMessage {
  const _$ChatMessageImpl({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.receiverName,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.messageType = MessageType.text,
    this.mediaUrl,
    this.fileName,
    this.fileSize,
    final Map<String, dynamic>? metadata,
    this.replyToMessageId,
    this.replyToMessage,
    this.replyToSenderName,
    this.isEdited = false,
    this.editedAt,
  }) : _metadata = metadata,
       super._();

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String senderName;
  @override
  final String receiverId;
  @override
  final String receiverName;
  @override
  final String message;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isRead;
  @override
  @JsonKey()
  final MessageType messageType;
  @override
  final String? mediaUrl;
  @override
  final String? fileName;
  @override
  final int? fileSize;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? replyToMessageId;
  @override
  final String? replyToMessage;
  @override
  final String? replyToSenderName;
  @override
  @JsonKey()
  final bool isEdited;
  @override
  final DateTime? editedAt;

  @override
  String toString() {
    return 'ChatMessage(id: $id, senderId: $senderId, senderName: $senderName, receiverId: $receiverId, receiverName: $receiverName, message: $message, timestamp: $timestamp, isRead: $isRead, messageType: $messageType, mediaUrl: $mediaUrl, fileName: $fileName, fileSize: $fileSize, metadata: $metadata, replyToMessageId: $replyToMessageId, replyToMessage: $replyToMessage, replyToSenderName: $replyToSenderName, isEdited: $isEdited, editedAt: $editedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.mediaUrl, mediaUrl) ||
                other.mediaUrl == mediaUrl) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId) &&
            (identical(other.replyToMessage, replyToMessage) ||
                other.replyToMessage == replyToMessage) &&
            (identical(other.replyToSenderName, replyToSenderName) ||
                other.replyToSenderName == replyToSenderName) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderId,
    senderName,
    receiverId,
    receiverName,
    message,
    timestamp,
    isRead,
    messageType,
    mediaUrl,
    fileName,
    fileSize,
    const DeepCollectionEquality().hash(_metadata),
    replyToMessageId,
    replyToMessage,
    replyToSenderName,
    isEdited,
    editedAt,
  );

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage extends ChatMessage {
  const factory _ChatMessage({
    required final String id,
    required final String senderId,
    required final String senderName,
    required final String receiverId,
    required final String receiverName,
    required final String message,
    required final DateTime timestamp,
    final bool isRead,
    final MessageType messageType,
    final String? mediaUrl,
    final String? fileName,
    final int? fileSize,
    final Map<String, dynamic>? metadata,
    final String? replyToMessageId,
    final String? replyToMessage,
    final String? replyToSenderName,
    final bool isEdited,
    final DateTime? editedAt,
  }) = _$ChatMessageImpl;
  const _ChatMessage._() : super._();

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get senderId;
  @override
  String get senderName;
  @override
  String get receiverId;
  @override
  String get receiverName;
  @override
  String get message;
  @override
  DateTime get timestamp;
  @override
  bool get isRead;
  @override
  MessageType get messageType;
  @override
  String? get mediaUrl;
  @override
  String? get fileName;
  @override
  int? get fileSize;
  @override
  Map<String, dynamic>? get metadata;
  @override
  String? get replyToMessageId;
  @override
  String? get replyToMessage;
  @override
  String? get replyToSenderName;
  @override
  bool get isEdited;
  @override
  DateTime? get editedAt;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
