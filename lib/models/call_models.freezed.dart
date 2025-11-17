// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CallInitiateRequest _$CallInitiateRequestFromJson(Map<String, dynamic> json) {
  return _CallInitiateRequest.fromJson(json);
}

/// @nodoc
mixin _$CallInitiateRequest {
  String get receiverId => throw _privateConstructorUsedError;
  String get callType => throw _privateConstructorUsedError;
  String get agoraChannelName => throw _privateConstructorUsedError;

  /// Serializes this CallInitiateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallInitiateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallInitiateRequestCopyWith<CallInitiateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallInitiateRequestCopyWith<$Res> {
  factory $CallInitiateRequestCopyWith(
    CallInitiateRequest value,
    $Res Function(CallInitiateRequest) then,
  ) = _$CallInitiateRequestCopyWithImpl<$Res, CallInitiateRequest>;
  @useResult
  $Res call({String receiverId, String callType, String agoraChannelName});
}

/// @nodoc
class _$CallInitiateRequestCopyWithImpl<$Res, $Val extends CallInitiateRequest>
    implements $CallInitiateRequestCopyWith<$Res> {
  _$CallInitiateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallInitiateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiverId = null,
    Object? callType = null,
    Object? agoraChannelName = null,
  }) {
    return _then(
      _value.copyWith(
            receiverId: null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                      as String,
            callType: null == callType
                ? _value.callType
                : callType // ignore: cast_nullable_to_non_nullable
                      as String,
            agoraChannelName: null == agoraChannelName
                ? _value.agoraChannelName
                : agoraChannelName // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallInitiateRequestImplCopyWith<$Res>
    implements $CallInitiateRequestCopyWith<$Res> {
  factory _$$CallInitiateRequestImplCopyWith(
    _$CallInitiateRequestImpl value,
    $Res Function(_$CallInitiateRequestImpl) then,
  ) = __$$CallInitiateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String receiverId, String callType, String agoraChannelName});
}

/// @nodoc
class __$$CallInitiateRequestImplCopyWithImpl<$Res>
    extends _$CallInitiateRequestCopyWithImpl<$Res, _$CallInitiateRequestImpl>
    implements _$$CallInitiateRequestImplCopyWith<$Res> {
  __$$CallInitiateRequestImplCopyWithImpl(
    _$CallInitiateRequestImpl _value,
    $Res Function(_$CallInitiateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallInitiateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receiverId = null,
    Object? callType = null,
    Object? agoraChannelName = null,
  }) {
    return _then(
      _$CallInitiateRequestImpl(
        receiverId: null == receiverId
            ? _value.receiverId
            : receiverId // ignore: cast_nullable_to_non_nullable
                  as String,
        callType: null == callType
            ? _value.callType
            : callType // ignore: cast_nullable_to_non_nullable
                  as String,
        agoraChannelName: null == agoraChannelName
            ? _value.agoraChannelName
            : agoraChannelName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallInitiateRequestImpl implements _CallInitiateRequest {
  const _$CallInitiateRequestImpl({
    required this.receiverId,
    required this.callType,
    required this.agoraChannelName,
  });

  factory _$CallInitiateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallInitiateRequestImplFromJson(json);

  @override
  final String receiverId;
  @override
  final String callType;
  @override
  final String agoraChannelName;

  @override
  String toString() {
    return 'CallInitiateRequest(receiverId: $receiverId, callType: $callType, agoraChannelName: $agoraChannelName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallInitiateRequestImpl &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.callType, callType) ||
                other.callType == callType) &&
            (identical(other.agoraChannelName, agoraChannelName) ||
                other.agoraChannelName == agoraChannelName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, receiverId, callType, agoraChannelName);

  /// Create a copy of CallInitiateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallInitiateRequestImplCopyWith<_$CallInitiateRequestImpl> get copyWith =>
      __$$CallInitiateRequestImplCopyWithImpl<_$CallInitiateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CallInitiateRequestImplToJson(this);
  }
}

abstract class _CallInitiateRequest implements CallInitiateRequest {
  const factory _CallInitiateRequest({
    required final String receiverId,
    required final String callType,
    required final String agoraChannelName,
  }) = _$CallInitiateRequestImpl;

  factory _CallInitiateRequest.fromJson(Map<String, dynamic> json) =
      _$CallInitiateRequestImpl.fromJson;

  @override
  String get receiverId;
  @override
  String get callType;
  @override
  String get agoraChannelName;

  /// Create a copy of CallInitiateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallInitiateRequestImplCopyWith<_$CallInitiateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallInitiateResponse _$CallInitiateResponseFromJson(Map<String, dynamic> json) {
  return _CallInitiateResponse.fromJson(json);
}

/// @nodoc
mixin _$CallInitiateResponse {
  bool get allowed => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get callId => throw _privateConstructorUsedError;
  String? get agoraToken => throw _privateConstructorUsedError;
  String? get agoraRtmToken => throw _privateConstructorUsedError;
  int? get tokenExpiresIn => throw _privateConstructorUsedError;
  double? get estimatedCostPerMinute => throw _privateConstructorUsedError;

  /// Serializes this CallInitiateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallInitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallInitiateResponseCopyWith<CallInitiateResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallInitiateResponseCopyWith<$Res> {
  factory $CallInitiateResponseCopyWith(
    CallInitiateResponse value,
    $Res Function(CallInitiateResponse) then,
  ) = _$CallInitiateResponseCopyWithImpl<$Res, CallInitiateResponse>;
  @useResult
  $Res call({
    bool allowed,
    String message,
    String? callId,
    String? agoraToken,
    String? agoraRtmToken,
    int? tokenExpiresIn,
    double? estimatedCostPerMinute,
  });
}

/// @nodoc
class _$CallInitiateResponseCopyWithImpl<
  $Res,
  $Val extends CallInitiateResponse
>
    implements $CallInitiateResponseCopyWith<$Res> {
  _$CallInitiateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallInitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowed = null,
    Object? message = null,
    Object? callId = freezed,
    Object? agoraToken = freezed,
    Object? agoraRtmToken = freezed,
    Object? tokenExpiresIn = freezed,
    Object? estimatedCostPerMinute = freezed,
  }) {
    return _then(
      _value.copyWith(
            allowed: null == allowed
                ? _value.allowed
                : allowed // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            callId: freezed == callId
                ? _value.callId
                : callId // ignore: cast_nullable_to_non_nullable
                      as String?,
            agoraToken: freezed == agoraToken
                ? _value.agoraToken
                : agoraToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            agoraRtmToken: freezed == agoraRtmToken
                ? _value.agoraRtmToken
                : agoraRtmToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            tokenExpiresIn: freezed == tokenExpiresIn
                ? _value.tokenExpiresIn
                : tokenExpiresIn // ignore: cast_nullable_to_non_nullable
                      as int?,
            estimatedCostPerMinute: freezed == estimatedCostPerMinute
                ? _value.estimatedCostPerMinute
                : estimatedCostPerMinute // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallInitiateResponseImplCopyWith<$Res>
    implements $CallInitiateResponseCopyWith<$Res> {
  factory _$$CallInitiateResponseImplCopyWith(
    _$CallInitiateResponseImpl value,
    $Res Function(_$CallInitiateResponseImpl) then,
  ) = __$$CallInitiateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool allowed,
    String message,
    String? callId,
    String? agoraToken,
    String? agoraRtmToken,
    int? tokenExpiresIn,
    double? estimatedCostPerMinute,
  });
}

/// @nodoc
class __$$CallInitiateResponseImplCopyWithImpl<$Res>
    extends _$CallInitiateResponseCopyWithImpl<$Res, _$CallInitiateResponseImpl>
    implements _$$CallInitiateResponseImplCopyWith<$Res> {
  __$$CallInitiateResponseImplCopyWithImpl(
    _$CallInitiateResponseImpl _value,
    $Res Function(_$CallInitiateResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallInitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allowed = null,
    Object? message = null,
    Object? callId = freezed,
    Object? agoraToken = freezed,
    Object? agoraRtmToken = freezed,
    Object? tokenExpiresIn = freezed,
    Object? estimatedCostPerMinute = freezed,
  }) {
    return _then(
      _$CallInitiateResponseImpl(
        allowed: null == allowed
            ? _value.allowed
            : allowed // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        callId: freezed == callId
            ? _value.callId
            : callId // ignore: cast_nullable_to_non_nullable
                  as String?,
        agoraToken: freezed == agoraToken
            ? _value.agoraToken
            : agoraToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        agoraRtmToken: freezed == agoraRtmToken
            ? _value.agoraRtmToken
            : agoraRtmToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokenExpiresIn: freezed == tokenExpiresIn
            ? _value.tokenExpiresIn
            : tokenExpiresIn // ignore: cast_nullable_to_non_nullable
                  as int?,
        estimatedCostPerMinute: freezed == estimatedCostPerMinute
            ? _value.estimatedCostPerMinute
            : estimatedCostPerMinute // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallInitiateResponseImpl implements _CallInitiateResponse {
  const _$CallInitiateResponseImpl({
    required this.allowed,
    required this.message,
    this.callId,
    this.agoraToken,
    this.agoraRtmToken,
    this.tokenExpiresIn,
    this.estimatedCostPerMinute,
  });

  factory _$CallInitiateResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallInitiateResponseImplFromJson(json);

  @override
  final bool allowed;
  @override
  final String message;
  @override
  final String? callId;
  @override
  final String? agoraToken;
  @override
  final String? agoraRtmToken;
  @override
  final int? tokenExpiresIn;
  @override
  final double? estimatedCostPerMinute;

  @override
  String toString() {
    return 'CallInitiateResponse(allowed: $allowed, message: $message, callId: $callId, agoraToken: $agoraToken, agoraRtmToken: $agoraRtmToken, tokenExpiresIn: $tokenExpiresIn, estimatedCostPerMinute: $estimatedCostPerMinute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallInitiateResponseImpl &&
            (identical(other.allowed, allowed) || other.allowed == allowed) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.agoraToken, agoraToken) ||
                other.agoraToken == agoraToken) &&
            (identical(other.agoraRtmToken, agoraRtmToken) ||
                other.agoraRtmToken == agoraRtmToken) &&
            (identical(other.tokenExpiresIn, tokenExpiresIn) ||
                other.tokenExpiresIn == tokenExpiresIn) &&
            (identical(other.estimatedCostPerMinute, estimatedCostPerMinute) ||
                other.estimatedCostPerMinute == estimatedCostPerMinute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    allowed,
    message,
    callId,
    agoraToken,
    agoraRtmToken,
    tokenExpiresIn,
    estimatedCostPerMinute,
  );

  /// Create a copy of CallInitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallInitiateResponseImplCopyWith<_$CallInitiateResponseImpl>
  get copyWith =>
      __$$CallInitiateResponseImplCopyWithImpl<_$CallInitiateResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CallInitiateResponseImplToJson(this);
  }
}

abstract class _CallInitiateResponse implements CallInitiateResponse {
  const factory _CallInitiateResponse({
    required final bool allowed,
    required final String message,
    final String? callId,
    final String? agoraToken,
    final String? agoraRtmToken,
    final int? tokenExpiresIn,
    final double? estimatedCostPerMinute,
  }) = _$CallInitiateResponseImpl;

  factory _CallInitiateResponse.fromJson(Map<String, dynamic> json) =
      _$CallInitiateResponseImpl.fromJson;

  @override
  bool get allowed;
  @override
  String get message;
  @override
  String? get callId;
  @override
  String? get agoraToken;
  @override
  String? get agoraRtmToken;
  @override
  int? get tokenExpiresIn;
  @override
  double? get estimatedCostPerMinute;

  /// Create a copy of CallInitiateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallInitiateResponseImplCopyWith<_$CallInitiateResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CallStartRequest _$CallStartRequestFromJson(Map<String, dynamic> json) {
  return _CallStartRequest.fromJson(json);
}

/// @nodoc
mixin _$CallStartRequest {
  String get callId => throw _privateConstructorUsedError;
  String get actualStartTime => throw _privateConstructorUsedError;

  /// Serializes this CallStartRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallStartRequestCopyWith<CallStartRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallStartRequestCopyWith<$Res> {
  factory $CallStartRequestCopyWith(
    CallStartRequest value,
    $Res Function(CallStartRequest) then,
  ) = _$CallStartRequestCopyWithImpl<$Res, CallStartRequest>;
  @useResult
  $Res call({String callId, String actualStartTime});
}

/// @nodoc
class _$CallStartRequestCopyWithImpl<$Res, $Val extends CallStartRequest>
    implements $CallStartRequestCopyWith<$Res> {
  _$CallStartRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? callId = null, Object? actualStartTime = null}) {
    return _then(
      _value.copyWith(
            callId: null == callId
                ? _value.callId
                : callId // ignore: cast_nullable_to_non_nullable
                      as String,
            actualStartTime: null == actualStartTime
                ? _value.actualStartTime
                : actualStartTime // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallStartRequestImplCopyWith<$Res>
    implements $CallStartRequestCopyWith<$Res> {
  factory _$$CallStartRequestImplCopyWith(
    _$CallStartRequestImpl value,
    $Res Function(_$CallStartRequestImpl) then,
  ) = __$$CallStartRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String callId, String actualStartTime});
}

/// @nodoc
class __$$CallStartRequestImplCopyWithImpl<$Res>
    extends _$CallStartRequestCopyWithImpl<$Res, _$CallStartRequestImpl>
    implements _$$CallStartRequestImplCopyWith<$Res> {
  __$$CallStartRequestImplCopyWithImpl(
    _$CallStartRequestImpl _value,
    $Res Function(_$CallStartRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? callId = null, Object? actualStartTime = null}) {
    return _then(
      _$CallStartRequestImpl(
        callId: null == callId
            ? _value.callId
            : callId // ignore: cast_nullable_to_non_nullable
                  as String,
        actualStartTime: null == actualStartTime
            ? _value.actualStartTime
            : actualStartTime // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallStartRequestImpl implements _CallStartRequest {
  const _$CallStartRequestImpl({
    required this.callId,
    required this.actualStartTime,
  });

  factory _$CallStartRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallStartRequestImplFromJson(json);

  @override
  final String callId;
  @override
  final String actualStartTime;

  @override
  String toString() {
    return 'CallStartRequest(callId: $callId, actualStartTime: $actualStartTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallStartRequestImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.actualStartTime, actualStartTime) ||
                other.actualStartTime == actualStartTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, callId, actualStartTime);

  /// Create a copy of CallStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallStartRequestImplCopyWith<_$CallStartRequestImpl> get copyWith =>
      __$$CallStartRequestImplCopyWithImpl<_$CallStartRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CallStartRequestImplToJson(this);
  }
}

abstract class _CallStartRequest implements CallStartRequest {
  const factory _CallStartRequest({
    required final String callId,
    required final String actualStartTime,
  }) = _$CallStartRequestImpl;

  factory _CallStartRequest.fromJson(Map<String, dynamic> json) =
      _$CallStartRequestImpl.fromJson;

  @override
  String get callId;
  @override
  String get actualStartTime;

  /// Create a copy of CallStartRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallStartRequestImplCopyWith<_$CallStartRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallEndRequest _$CallEndRequestFromJson(Map<String, dynamic> json) {
  return _CallEndRequest.fromJson(json);
}

/// @nodoc
mixin _$CallEndRequest {
  String get callId => throw _privateConstructorUsedError;
  String get actualEndTime => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;

  /// Serializes this CallEndRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallEndRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallEndRequestCopyWith<CallEndRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallEndRequestCopyWith<$Res> {
  factory $CallEndRequestCopyWith(
    CallEndRequest value,
    $Res Function(CallEndRequest) then,
  ) = _$CallEndRequestCopyWithImpl<$Res, CallEndRequest>;
  @useResult
  $Res call({String callId, String actualEndTime, int duration});
}

/// @nodoc
class _$CallEndRequestCopyWithImpl<$Res, $Val extends CallEndRequest>
    implements $CallEndRequestCopyWith<$Res> {
  _$CallEndRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallEndRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
    Object? actualEndTime = null,
    Object? duration = null,
  }) {
    return _then(
      _value.copyWith(
            callId: null == callId
                ? _value.callId
                : callId // ignore: cast_nullable_to_non_nullable
                      as String,
            actualEndTime: null == actualEndTime
                ? _value.actualEndTime
                : actualEndTime // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallEndRequestImplCopyWith<$Res>
    implements $CallEndRequestCopyWith<$Res> {
  factory _$$CallEndRequestImplCopyWith(
    _$CallEndRequestImpl value,
    $Res Function(_$CallEndRequestImpl) then,
  ) = __$$CallEndRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String callId, String actualEndTime, int duration});
}

/// @nodoc
class __$$CallEndRequestImplCopyWithImpl<$Res>
    extends _$CallEndRequestCopyWithImpl<$Res, _$CallEndRequestImpl>
    implements _$$CallEndRequestImplCopyWith<$Res> {
  __$$CallEndRequestImplCopyWithImpl(
    _$CallEndRequestImpl _value,
    $Res Function(_$CallEndRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallEndRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = null,
    Object? actualEndTime = null,
    Object? duration = null,
  }) {
    return _then(
      _$CallEndRequestImpl(
        callId: null == callId
            ? _value.callId
            : callId // ignore: cast_nullable_to_non_nullable
                  as String,
        actualEndTime: null == actualEndTime
            ? _value.actualEndTime
            : actualEndTime // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallEndRequestImpl implements _CallEndRequest {
  const _$CallEndRequestImpl({
    required this.callId,
    required this.actualEndTime,
    required this.duration,
  });

  factory _$CallEndRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallEndRequestImplFromJson(json);

  @override
  final String callId;
  @override
  final String actualEndTime;
  @override
  final int duration;

  @override
  String toString() {
    return 'CallEndRequest(callId: $callId, actualEndTime: $actualEndTime, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallEndRequestImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.actualEndTime, actualEndTime) ||
                other.actualEndTime == actualEndTime) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, callId, actualEndTime, duration);

  /// Create a copy of CallEndRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallEndRequestImplCopyWith<_$CallEndRequestImpl> get copyWith =>
      __$$CallEndRequestImplCopyWithImpl<_$CallEndRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CallEndRequestImplToJson(this);
  }
}

abstract class _CallEndRequest implements CallEndRequest {
  const factory _CallEndRequest({
    required final String callId,
    required final String actualEndTime,
    required final int duration,
  }) = _$CallEndRequestImpl;

  factory _CallEndRequest.fromJson(Map<String, dynamic> json) =
      _$CallEndRequestImpl.fromJson;

  @override
  String get callId;
  @override
  String get actualEndTime;
  @override
  int get duration;

  /// Create a copy of CallEndRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallEndRequestImplCopyWith<_$CallEndRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallActionRequest _$CallActionRequestFromJson(Map<String, dynamic> json) {
  return _CallActionRequest.fromJson(json);
}

/// @nodoc
mixin _$CallActionRequest {
  String get callId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  /// Serializes this CallActionRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallActionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallActionRequestCopyWith<CallActionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallActionRequestCopyWith<$Res> {
  factory $CallActionRequestCopyWith(
    CallActionRequest value,
    $Res Function(CallActionRequest) then,
  ) = _$CallActionRequestCopyWithImpl<$Res, CallActionRequest>;
  @useResult
  $Res call({String callId, String reason});
}

/// @nodoc
class _$CallActionRequestCopyWithImpl<$Res, $Val extends CallActionRequest>
    implements $CallActionRequestCopyWith<$Res> {
  _$CallActionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallActionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? callId = null, Object? reason = null}) {
    return _then(
      _value.copyWith(
            callId: null == callId
                ? _value.callId
                : callId // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallActionRequestImplCopyWith<$Res>
    implements $CallActionRequestCopyWith<$Res> {
  factory _$$CallActionRequestImplCopyWith(
    _$CallActionRequestImpl value,
    $Res Function(_$CallActionRequestImpl) then,
  ) = __$$CallActionRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String callId, String reason});
}

/// @nodoc
class __$$CallActionRequestImplCopyWithImpl<$Res>
    extends _$CallActionRequestCopyWithImpl<$Res, _$CallActionRequestImpl>
    implements _$$CallActionRequestImplCopyWith<$Res> {
  __$$CallActionRequestImplCopyWithImpl(
    _$CallActionRequestImpl _value,
    $Res Function(_$CallActionRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallActionRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? callId = null, Object? reason = null}) {
    return _then(
      _$CallActionRequestImpl(
        callId: null == callId
            ? _value.callId
            : callId // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallActionRequestImpl implements _CallActionRequest {
  const _$CallActionRequestImpl({required this.callId, required this.reason});

  factory _$CallActionRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallActionRequestImplFromJson(json);

  @override
  final String callId;
  @override
  final String reason;

  @override
  String toString() {
    return 'CallActionRequest(callId: $callId, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallActionRequestImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, callId, reason);

  /// Create a copy of CallActionRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallActionRequestImplCopyWith<_$CallActionRequestImpl> get copyWith =>
      __$$CallActionRequestImplCopyWithImpl<_$CallActionRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CallActionRequestImplToJson(this);
  }
}

abstract class _CallActionRequest implements CallActionRequest {
  const factory _CallActionRequest({
    required final String callId,
    required final String reason,
  }) = _$CallActionRequestImpl;

  factory _CallActionRequest.fromJson(Map<String, dynamic> json) =
      _$CallActionRequestImpl.fromJson;

  @override
  String get callId;
  @override
  String get reason;

  /// Create a copy of CallActionRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallActionRequestImplCopyWith<_$CallActionRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallDetails _$CallDetailsFromJson(Map<String, dynamic> json) {
  return _CallDetails.fromJson(json);
}

/// @nodoc
mixin _$CallDetails {
  String get id => throw _privateConstructorUsedError;
  String get callerId => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  String get callType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get agoraChannelName => throw _privateConstructorUsedError;
  DateTime? get initiatedAt => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  double? get creditsCharged => throw _privateConstructorUsedError;
  String? get endReason => throw _privateConstructorUsedError;

  /// Serializes this CallDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallDetailsCopyWith<CallDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallDetailsCopyWith<$Res> {
  factory $CallDetailsCopyWith(
    CallDetails value,
    $Res Function(CallDetails) then,
  ) = _$CallDetailsCopyWithImpl<$Res, CallDetails>;
  @useResult
  $Res call({
    String id,
    String callerId,
    String receiverId,
    String callType,
    String status,
    String agoraChannelName,
    DateTime? initiatedAt,
    DateTime? startedAt,
    DateTime? endedAt,
    int? duration,
    double? creditsCharged,
    String? endReason,
  });
}

/// @nodoc
class _$CallDetailsCopyWithImpl<$Res, $Val extends CallDetails>
    implements $CallDetailsCopyWith<$Res> {
  _$CallDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? callerId = null,
    Object? receiverId = null,
    Object? callType = null,
    Object? status = null,
    Object? agoraChannelName = null,
    Object? initiatedAt = freezed,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? duration = freezed,
    Object? creditsCharged = freezed,
    Object? endReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            callerId: null == callerId
                ? _value.callerId
                : callerId // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverId: null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                      as String,
            callType: null == callType
                ? _value.callType
                : callType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            agoraChannelName: null == agoraChannelName
                ? _value.agoraChannelName
                : agoraChannelName // ignore: cast_nullable_to_non_nullable
                      as String,
            initiatedAt: freezed == initiatedAt
                ? _value.initiatedAt
                : initiatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int?,
            creditsCharged: freezed == creditsCharged
                ? _value.creditsCharged
                : creditsCharged // ignore: cast_nullable_to_non_nullable
                      as double?,
            endReason: freezed == endReason
                ? _value.endReason
                : endReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallDetailsImplCopyWith<$Res>
    implements $CallDetailsCopyWith<$Res> {
  factory _$$CallDetailsImplCopyWith(
    _$CallDetailsImpl value,
    $Res Function(_$CallDetailsImpl) then,
  ) = __$$CallDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String callerId,
    String receiverId,
    String callType,
    String status,
    String agoraChannelName,
    DateTime? initiatedAt,
    DateTime? startedAt,
    DateTime? endedAt,
    int? duration,
    double? creditsCharged,
    String? endReason,
  });
}

/// @nodoc
class __$$CallDetailsImplCopyWithImpl<$Res>
    extends _$CallDetailsCopyWithImpl<$Res, _$CallDetailsImpl>
    implements _$$CallDetailsImplCopyWith<$Res> {
  __$$CallDetailsImplCopyWithImpl(
    _$CallDetailsImpl _value,
    $Res Function(_$CallDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? callerId = null,
    Object? receiverId = null,
    Object? callType = null,
    Object? status = null,
    Object? agoraChannelName = null,
    Object? initiatedAt = freezed,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? duration = freezed,
    Object? creditsCharged = freezed,
    Object? endReason = freezed,
  }) {
    return _then(
      _$CallDetailsImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        callerId: null == callerId
            ? _value.callerId
            : callerId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverId: null == receiverId
            ? _value.receiverId
            : receiverId // ignore: cast_nullable_to_non_nullable
                  as String,
        callType: null == callType
            ? _value.callType
            : callType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        agoraChannelName: null == agoraChannelName
            ? _value.agoraChannelName
            : agoraChannelName // ignore: cast_nullable_to_non_nullable
                  as String,
        initiatedAt: freezed == initiatedAt
            ? _value.initiatedAt
            : initiatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int?,
        creditsCharged: freezed == creditsCharged
            ? _value.creditsCharged
            : creditsCharged // ignore: cast_nullable_to_non_nullable
                  as double?,
        endReason: freezed == endReason
            ? _value.endReason
            : endReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallDetailsImpl implements _CallDetails {
  const _$CallDetailsImpl({
    required this.id,
    required this.callerId,
    required this.receiverId,
    required this.callType,
    required this.status,
    required this.agoraChannelName,
    this.initiatedAt,
    this.startedAt,
    this.endedAt,
    this.duration,
    this.creditsCharged,
    this.endReason,
  });

  factory _$CallDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallDetailsImplFromJson(json);

  @override
  final String id;
  @override
  final String callerId;
  @override
  final String receiverId;
  @override
  final String callType;
  @override
  final String status;
  @override
  final String agoraChannelName;
  @override
  final DateTime? initiatedAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? endedAt;
  @override
  final int? duration;
  @override
  final double? creditsCharged;
  @override
  final String? endReason;

  @override
  String toString() {
    return 'CallDetails(id: $id, callerId: $callerId, receiverId: $receiverId, callType: $callType, status: $status, agoraChannelName: $agoraChannelName, initiatedAt: $initiatedAt, startedAt: $startedAt, endedAt: $endedAt, duration: $duration, creditsCharged: $creditsCharged, endReason: $endReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.callerId, callerId) ||
                other.callerId == callerId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.callType, callType) ||
                other.callType == callType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.agoraChannelName, agoraChannelName) ||
                other.agoraChannelName == agoraChannelName) &&
            (identical(other.initiatedAt, initiatedAt) ||
                other.initiatedAt == initiatedAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.creditsCharged, creditsCharged) ||
                other.creditsCharged == creditsCharged) &&
            (identical(other.endReason, endReason) ||
                other.endReason == endReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    callerId,
    receiverId,
    callType,
    status,
    agoraChannelName,
    initiatedAt,
    startedAt,
    endedAt,
    duration,
    creditsCharged,
    endReason,
  );

  /// Create a copy of CallDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallDetailsImplCopyWith<_$CallDetailsImpl> get copyWith =>
      __$$CallDetailsImplCopyWithImpl<_$CallDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallDetailsImplToJson(this);
  }
}

abstract class _CallDetails implements CallDetails {
  const factory _CallDetails({
    required final String id,
    required final String callerId,
    required final String receiverId,
    required final String callType,
    required final String status,
    required final String agoraChannelName,
    final DateTime? initiatedAt,
    final DateTime? startedAt,
    final DateTime? endedAt,
    final int? duration,
    final double? creditsCharged,
    final String? endReason,
  }) = _$CallDetailsImpl;

  factory _CallDetails.fromJson(Map<String, dynamic> json) =
      _$CallDetailsImpl.fromJson;

  @override
  String get id;
  @override
  String get callerId;
  @override
  String get receiverId;
  @override
  String get callType;
  @override
  String get status;
  @override
  String get agoraChannelName;
  @override
  DateTime? get initiatedAt;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get endedAt;
  @override
  int? get duration;
  @override
  double? get creditsCharged;
  @override
  String? get endReason;

  /// Create a copy of CallDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallDetailsImplCopyWith<_$CallDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallResponse _$CallResponseFromJson(Map<String, dynamic> json) {
  return _CallResponse.fromJson(json);
}

/// @nodoc
mixin _$CallResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  CallDetails? get callDetails => throw _privateConstructorUsedError;

  /// Serializes this CallResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallResponseCopyWith<CallResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallResponseCopyWith<$Res> {
  factory $CallResponseCopyWith(
    CallResponse value,
    $Res Function(CallResponse) then,
  ) = _$CallResponseCopyWithImpl<$Res, CallResponse>;
  @useResult
  $Res call({bool success, String message, CallDetails? callDetails});

  $CallDetailsCopyWith<$Res>? get callDetails;
}

/// @nodoc
class _$CallResponseCopyWithImpl<$Res, $Val extends CallResponse>
    implements $CallResponseCopyWith<$Res> {
  _$CallResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? callDetails = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            callDetails: freezed == callDetails
                ? _value.callDetails
                : callDetails // ignore: cast_nullable_to_non_nullable
                      as CallDetails?,
          )
          as $Val,
    );
  }

  /// Create a copy of CallResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallDetailsCopyWith<$Res>? get callDetails {
    if (_value.callDetails == null) {
      return null;
    }

    return $CallDetailsCopyWith<$Res>(_value.callDetails!, (value) {
      return _then(_value.copyWith(callDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CallResponseImplCopyWith<$Res>
    implements $CallResponseCopyWith<$Res> {
  factory _$$CallResponseImplCopyWith(
    _$CallResponseImpl value,
    $Res Function(_$CallResponseImpl) then,
  ) = __$$CallResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, CallDetails? callDetails});

  @override
  $CallDetailsCopyWith<$Res>? get callDetails;
}

/// @nodoc
class __$$CallResponseImplCopyWithImpl<$Res>
    extends _$CallResponseCopyWithImpl<$Res, _$CallResponseImpl>
    implements _$$CallResponseImplCopyWith<$Res> {
  __$$CallResponseImplCopyWithImpl(
    _$CallResponseImpl _value,
    $Res Function(_$CallResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? callDetails = freezed,
  }) {
    return _then(
      _$CallResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        callDetails: freezed == callDetails
            ? _value.callDetails
            : callDetails // ignore: cast_nullable_to_non_nullable
                  as CallDetails?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallResponseImpl implements _CallResponse {
  const _$CallResponseImpl({
    required this.success,
    required this.message,
    this.callDetails,
  });

  factory _$CallResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final CallDetails? callDetails;

  @override
  String toString() {
    return 'CallResponse(success: $success, message: $message, callDetails: $callDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.callDetails, callDetails) ||
                other.callDetails == callDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, callDetails);

  /// Create a copy of CallResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallResponseImplCopyWith<_$CallResponseImpl> get copyWith =>
      __$$CallResponseImplCopyWithImpl<_$CallResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallResponseImplToJson(this);
  }
}

abstract class _CallResponse implements CallResponse {
  const factory _CallResponse({
    required final bool success,
    required final String message,
    final CallDetails? callDetails,
  }) = _$CallResponseImpl;

  factory _CallResponse.fromJson(Map<String, dynamic> json) =
      _$CallResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  CallDetails? get callDetails;

  /// Create a copy of CallResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallResponseImplCopyWith<_$CallResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallHistoryResponse _$CallHistoryResponseFromJson(Map<String, dynamic> json) {
  return _CallHistoryResponse.fromJson(json);
}

/// @nodoc
mixin _$CallHistoryResponse {
  List<CallDetails> get calls => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this CallHistoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallHistoryResponseCopyWith<CallHistoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallHistoryResponseCopyWith<$Res> {
  factory $CallHistoryResponseCopyWith(
    CallHistoryResponse value,
    $Res Function(CallHistoryResponse) then,
  ) = _$CallHistoryResponseCopyWithImpl<$Res, CallHistoryResponse>;
  @useResult
  $Res call({
    List<CallDetails> calls,
    int total,
    int page,
    int limit,
    int totalPages,
  });
}

/// @nodoc
class _$CallHistoryResponseCopyWithImpl<$Res, $Val extends CallHistoryResponse>
    implements $CallHistoryResponseCopyWith<$Res> {
  _$CallHistoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calls = null,
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? totalPages = null,
  }) {
    return _then(
      _value.copyWith(
            calls: null == calls
                ? _value.calls
                : calls // ignore: cast_nullable_to_non_nullable
                      as List<CallDetails>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CallHistoryResponseImplCopyWith<$Res>
    implements $CallHistoryResponseCopyWith<$Res> {
  factory _$$CallHistoryResponseImplCopyWith(
    _$CallHistoryResponseImpl value,
    $Res Function(_$CallHistoryResponseImpl) then,
  ) = __$$CallHistoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<CallDetails> calls,
    int total,
    int page,
    int limit,
    int totalPages,
  });
}

/// @nodoc
class __$$CallHistoryResponseImplCopyWithImpl<$Res>
    extends _$CallHistoryResponseCopyWithImpl<$Res, _$CallHistoryResponseImpl>
    implements _$$CallHistoryResponseImplCopyWith<$Res> {
  __$$CallHistoryResponseImplCopyWithImpl(
    _$CallHistoryResponseImpl _value,
    $Res Function(_$CallHistoryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CallHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calls = null,
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? totalPages = null,
  }) {
    return _then(
      _$CallHistoryResponseImpl(
        calls: null == calls
            ? _value._calls
            : calls // ignore: cast_nullable_to_non_nullable
                  as List<CallDetails>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CallHistoryResponseImpl implements _CallHistoryResponse {
  const _$CallHistoryResponseImpl({
    required final List<CallDetails> calls,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  }) : _calls = calls;

  factory _$CallHistoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallHistoryResponseImplFromJson(json);

  final List<CallDetails> _calls;
  @override
  List<CallDetails> get calls {
    if (_calls is EqualUnmodifiableListView) return _calls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_calls);
  }

  @override
  final int total;
  @override
  final int page;
  @override
  final int limit;
  @override
  final int totalPages;

  @override
  String toString() {
    return 'CallHistoryResponse(calls: $calls, total: $total, page: $page, limit: $limit, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallHistoryResponseImpl &&
            const DeepCollectionEquality().equals(other._calls, _calls) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_calls),
    total,
    page,
    limit,
    totalPages,
  );

  /// Create a copy of CallHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallHistoryResponseImplCopyWith<_$CallHistoryResponseImpl> get copyWith =>
      __$$CallHistoryResponseImplCopyWithImpl<_$CallHistoryResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CallHistoryResponseImplToJson(this);
  }
}

abstract class _CallHistoryResponse implements CallHistoryResponse {
  const factory _CallHistoryResponse({
    required final List<CallDetails> calls,
    required final int total,
    required final int page,
    required final int limit,
    required final int totalPages,
  }) = _$CallHistoryResponseImpl;

  factory _CallHistoryResponse.fromJson(Map<String, dynamic> json) =
      _$CallHistoryResponseImpl.fromJson;

  @override
  List<CallDetails> get calls;
  @override
  int get total;
  @override
  int get page;
  @override
  int get limit;
  @override
  int get totalPages;

  /// Create a copy of CallHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallHistoryResponseImplCopyWith<_$CallHistoryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AgoraTokenRequest _$AgoraTokenRequestFromJson(Map<String, dynamic> json) {
  return _AgoraTokenRequest.fromJson(json);
}

/// @nodoc
mixin _$AgoraTokenRequest {
  String get channelName => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;

  /// Serializes this AgoraTokenRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AgoraTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgoraTokenRequestCopyWith<AgoraTokenRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgoraTokenRequestCopyWith<$Res> {
  factory $AgoraTokenRequestCopyWith(
    AgoraTokenRequest value,
    $Res Function(AgoraTokenRequest) then,
  ) = _$AgoraTokenRequestCopyWithImpl<$Res, AgoraTokenRequest>;
  @useResult
  $Res call({String channelName, String userId, String role});
}

/// @nodoc
class _$AgoraTokenRequestCopyWithImpl<$Res, $Val extends AgoraTokenRequest>
    implements $AgoraTokenRequestCopyWith<$Res> {
  _$AgoraTokenRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgoraTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channelName = null,
    Object? userId = null,
    Object? role = null,
  }) {
    return _then(
      _value.copyWith(
            channelName: null == channelName
                ? _value.channelName
                : channelName // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AgoraTokenRequestImplCopyWith<$Res>
    implements $AgoraTokenRequestCopyWith<$Res> {
  factory _$$AgoraTokenRequestImplCopyWith(
    _$AgoraTokenRequestImpl value,
    $Res Function(_$AgoraTokenRequestImpl) then,
  ) = __$$AgoraTokenRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String channelName, String userId, String role});
}

/// @nodoc
class __$$AgoraTokenRequestImplCopyWithImpl<$Res>
    extends _$AgoraTokenRequestCopyWithImpl<$Res, _$AgoraTokenRequestImpl>
    implements _$$AgoraTokenRequestImplCopyWith<$Res> {
  __$$AgoraTokenRequestImplCopyWithImpl(
    _$AgoraTokenRequestImpl _value,
    $Res Function(_$AgoraTokenRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgoraTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channelName = null,
    Object? userId = null,
    Object? role = null,
  }) {
    return _then(
      _$AgoraTokenRequestImpl(
        channelName: null == channelName
            ? _value.channelName
            : channelName // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AgoraTokenRequestImpl implements _AgoraTokenRequest {
  const _$AgoraTokenRequestImpl({
    required this.channelName,
    required this.userId,
    this.role = 'publisher',
  });

  factory _$AgoraTokenRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgoraTokenRequestImplFromJson(json);

  @override
  final String channelName;
  @override
  final String userId;
  @override
  @JsonKey()
  final String role;

  @override
  String toString() {
    return 'AgoraTokenRequest(channelName: $channelName, userId: $userId, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgoraTokenRequestImpl &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, channelName, userId, role);

  /// Create a copy of AgoraTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgoraTokenRequestImplCopyWith<_$AgoraTokenRequestImpl> get copyWith =>
      __$$AgoraTokenRequestImplCopyWithImpl<_$AgoraTokenRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AgoraTokenRequestImplToJson(this);
  }
}

abstract class _AgoraTokenRequest implements AgoraTokenRequest {
  const factory _AgoraTokenRequest({
    required final String channelName,
    required final String userId,
    final String role,
  }) = _$AgoraTokenRequestImpl;

  factory _AgoraTokenRequest.fromJson(Map<String, dynamic> json) =
      _$AgoraTokenRequestImpl.fromJson;

  @override
  String get channelName;
  @override
  String get userId;
  @override
  String get role;

  /// Create a copy of AgoraTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgoraTokenRequestImplCopyWith<_$AgoraTokenRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AgoraTokenResponse _$AgoraTokenResponseFromJson(Map<String, dynamic> json) {
  return _AgoraTokenResponse.fromJson(json);
}

/// @nodoc
mixin _$AgoraTokenResponse {
  bool get success => throw _privateConstructorUsedError;
  String get rtcToken => throw _privateConstructorUsedError;
  String get rtmToken => throw _privateConstructorUsedError;
  int get expiresIn => throw _privateConstructorUsedError;

  /// Serializes this AgoraTokenResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AgoraTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgoraTokenResponseCopyWith<AgoraTokenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgoraTokenResponseCopyWith<$Res> {
  factory $AgoraTokenResponseCopyWith(
    AgoraTokenResponse value,
    $Res Function(AgoraTokenResponse) then,
  ) = _$AgoraTokenResponseCopyWithImpl<$Res, AgoraTokenResponse>;
  @useResult
  $Res call({bool success, String rtcToken, String rtmToken, int expiresIn});
}

/// @nodoc
class _$AgoraTokenResponseCopyWithImpl<$Res, $Val extends AgoraTokenResponse>
    implements $AgoraTokenResponseCopyWith<$Res> {
  _$AgoraTokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AgoraTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? rtcToken = null,
    Object? rtmToken = null,
    Object? expiresIn = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            rtcToken: null == rtcToken
                ? _value.rtcToken
                : rtcToken // ignore: cast_nullable_to_non_nullable
                      as String,
            rtmToken: null == rtmToken
                ? _value.rtmToken
                : rtmToken // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresIn: null == expiresIn
                ? _value.expiresIn
                : expiresIn // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AgoraTokenResponseImplCopyWith<$Res>
    implements $AgoraTokenResponseCopyWith<$Res> {
  factory _$$AgoraTokenResponseImplCopyWith(
    _$AgoraTokenResponseImpl value,
    $Res Function(_$AgoraTokenResponseImpl) then,
  ) = __$$AgoraTokenResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String rtcToken, String rtmToken, int expiresIn});
}

/// @nodoc
class __$$AgoraTokenResponseImplCopyWithImpl<$Res>
    extends _$AgoraTokenResponseCopyWithImpl<$Res, _$AgoraTokenResponseImpl>
    implements _$$AgoraTokenResponseImplCopyWith<$Res> {
  __$$AgoraTokenResponseImplCopyWithImpl(
    _$AgoraTokenResponseImpl _value,
    $Res Function(_$AgoraTokenResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AgoraTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? rtcToken = null,
    Object? rtmToken = null,
    Object? expiresIn = null,
  }) {
    return _then(
      _$AgoraTokenResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        rtcToken: null == rtcToken
            ? _value.rtcToken
            : rtcToken // ignore: cast_nullable_to_non_nullable
                  as String,
        rtmToken: null == rtmToken
            ? _value.rtmToken
            : rtmToken // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresIn: null == expiresIn
            ? _value.expiresIn
            : expiresIn // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AgoraTokenResponseImpl implements _AgoraTokenResponse {
  const _$AgoraTokenResponseImpl({
    required this.success,
    required this.rtcToken,
    required this.rtmToken,
    required this.expiresIn,
  });

  factory _$AgoraTokenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgoraTokenResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String rtcToken;
  @override
  final String rtmToken;
  @override
  final int expiresIn;

  @override
  String toString() {
    return 'AgoraTokenResponse(success: $success, rtcToken: $rtcToken, rtmToken: $rtmToken, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgoraTokenResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.rtcToken, rtcToken) ||
                other.rtcToken == rtcToken) &&
            (identical(other.rtmToken, rtmToken) ||
                other.rtmToken == rtmToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, rtcToken, rtmToken, expiresIn);

  /// Create a copy of AgoraTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgoraTokenResponseImplCopyWith<_$AgoraTokenResponseImpl> get copyWith =>
      __$$AgoraTokenResponseImplCopyWithImpl<_$AgoraTokenResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AgoraTokenResponseImplToJson(this);
  }
}

abstract class _AgoraTokenResponse implements AgoraTokenResponse {
  const factory _AgoraTokenResponse({
    required final bool success,
    required final String rtcToken,
    required final String rtmToken,
    required final int expiresIn,
  }) = _$AgoraTokenResponseImpl;

  factory _AgoraTokenResponse.fromJson(Map<String, dynamic> json) =
      _$AgoraTokenResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get rtcToken;
  @override
  String get rtmToken;
  @override
  int get expiresIn;

  /// Create a copy of AgoraTokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgoraTokenResponseImplCopyWith<_$AgoraTokenResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
