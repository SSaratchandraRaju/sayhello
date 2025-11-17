// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OtpRequest _$OtpRequestFromJson(Map<String, dynamic> json) {
  return _OtpRequest.fromJson(json);
}

/// @nodoc
mixin _$OtpRequest {
  String get phoneNumber => throw _privateConstructorUsedError;
  String get countryCode => throw _privateConstructorUsedError;

  /// Serializes this OtpRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpRequestCopyWith<OtpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpRequestCopyWith<$Res> {
  factory $OtpRequestCopyWith(
    OtpRequest value,
    $Res Function(OtpRequest) then,
  ) = _$OtpRequestCopyWithImpl<$Res, OtpRequest>;
  @useResult
  $Res call({String phoneNumber, String countryCode});
}

/// @nodoc
class _$OtpRequestCopyWithImpl<$Res, $Val extends OtpRequest>
    implements $OtpRequestCopyWith<$Res> {
  _$OtpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phoneNumber = null, Object? countryCode = null}) {
    return _then(
      _value.copyWith(
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            countryCode: null == countryCode
                ? _value.countryCode
                : countryCode // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtpRequestImplCopyWith<$Res>
    implements $OtpRequestCopyWith<$Res> {
  factory _$$OtpRequestImplCopyWith(
    _$OtpRequestImpl value,
    $Res Function(_$OtpRequestImpl) then,
  ) = __$$OtpRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phoneNumber, String countryCode});
}

/// @nodoc
class __$$OtpRequestImplCopyWithImpl<$Res>
    extends _$OtpRequestCopyWithImpl<$Res, _$OtpRequestImpl>
    implements _$$OtpRequestImplCopyWith<$Res> {
  __$$OtpRequestImplCopyWithImpl(
    _$OtpRequestImpl _value,
    $Res Function(_$OtpRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phoneNumber = null, Object? countryCode = null}) {
    return _then(
      _$OtpRequestImpl(
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        countryCode: null == countryCode
            ? _value.countryCode
            : countryCode // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpRequestImpl implements _OtpRequest {
  const _$OtpRequestImpl({required this.phoneNumber, this.countryCode = '+91'});

  factory _$OtpRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpRequestImplFromJson(json);

  @override
  final String phoneNumber;
  @override
  @JsonKey()
  final String countryCode;

  @override
  String toString() {
    return 'OtpRequest(phoneNumber: $phoneNumber, countryCode: $countryCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpRequestImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber, countryCode);

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpRequestImplCopyWith<_$OtpRequestImpl> get copyWith =>
      __$$OtpRequestImplCopyWithImpl<_$OtpRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpRequestImplToJson(this);
  }
}

abstract class _OtpRequest implements OtpRequest {
  const factory _OtpRequest({
    required final String phoneNumber,
    final String countryCode,
  }) = _$OtpRequestImpl;

  factory _OtpRequest.fromJson(Map<String, dynamic> json) =
      _$OtpRequestImpl.fromJson;

  @override
  String get phoneNumber;
  @override
  String get countryCode;

  /// Create a copy of OtpRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpRequestImplCopyWith<_$OtpRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpResponse _$OtpResponseFromJson(Map<String, dynamic> json) {
  return _OtpResponse.fromJson(json);
}

/// @nodoc
mixin _$OtpResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get otpId => throw _privateConstructorUsedError;
  int? get expiresIn => throw _privateConstructorUsedError;

  /// Serializes this OtpResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpResponseCopyWith<OtpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpResponseCopyWith<$Res> {
  factory $OtpResponseCopyWith(
    OtpResponse value,
    $Res Function(OtpResponse) then,
  ) = _$OtpResponseCopyWithImpl<$Res, OtpResponse>;
  @useResult
  $Res call({bool success, String message, String otpId, int? expiresIn});
}

/// @nodoc
class _$OtpResponseCopyWithImpl<$Res, $Val extends OtpResponse>
    implements $OtpResponseCopyWith<$Res> {
  _$OtpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? otpId = null,
    Object? expiresIn = freezed,
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
            otpId: null == otpId
                ? _value.otpId
                : otpId // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresIn: freezed == expiresIn
                ? _value.expiresIn
                : expiresIn // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtpResponseImplCopyWith<$Res>
    implements $OtpResponseCopyWith<$Res> {
  factory _$$OtpResponseImplCopyWith(
    _$OtpResponseImpl value,
    $Res Function(_$OtpResponseImpl) then,
  ) = __$$OtpResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, String otpId, int? expiresIn});
}

/// @nodoc
class __$$OtpResponseImplCopyWithImpl<$Res>
    extends _$OtpResponseCopyWithImpl<$Res, _$OtpResponseImpl>
    implements _$$OtpResponseImplCopyWith<$Res> {
  __$$OtpResponseImplCopyWithImpl(
    _$OtpResponseImpl _value,
    $Res Function(_$OtpResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? otpId = null,
    Object? expiresIn = freezed,
  }) {
    return _then(
      _$OtpResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        otpId: null == otpId
            ? _value.otpId
            : otpId // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresIn: freezed == expiresIn
            ? _value.expiresIn
            : expiresIn // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpResponseImpl implements _OtpResponse {
  const _$OtpResponseImpl({
    required this.success,
    required this.message,
    required this.otpId,
    this.expiresIn,
  });

  factory _$OtpResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final String otpId;
  @override
  final int? expiresIn;

  @override
  String toString() {
    return 'OtpResponse(success: $success, message: $message, otpId: $otpId, expiresIn: $expiresIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.otpId, otpId) || other.otpId == otpId) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, otpId, expiresIn);

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpResponseImplCopyWith<_$OtpResponseImpl> get copyWith =>
      __$$OtpResponseImplCopyWithImpl<_$OtpResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpResponseImplToJson(this);
  }
}

abstract class _OtpResponse implements OtpResponse {
  const factory _OtpResponse({
    required final bool success,
    required final String message,
    required final String otpId,
    final int? expiresIn,
  }) = _$OtpResponseImpl;

  factory _OtpResponse.fromJson(Map<String, dynamic> json) =
      _$OtpResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  String get otpId;
  @override
  int? get expiresIn;

  /// Create a copy of OtpResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpResponseImplCopyWith<_$OtpResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OtpVerificationRequest _$OtpVerificationRequestFromJson(
  Map<String, dynamic> json,
) {
  return _OtpVerificationRequest.fromJson(json);
}

/// @nodoc
mixin _$OtpVerificationRequest {
  String get phoneNumber => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;
  String get otpId => throw _privateConstructorUsedError;

  /// Serializes this OtpVerificationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpVerificationRequestCopyWith<OtpVerificationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerificationRequestCopyWith<$Res> {
  factory $OtpVerificationRequestCopyWith(
    OtpVerificationRequest value,
    $Res Function(OtpVerificationRequest) then,
  ) = _$OtpVerificationRequestCopyWithImpl<$Res, OtpVerificationRequest>;
  @useResult
  $Res call({String phoneNumber, String otp, String otpId});
}

/// @nodoc
class _$OtpVerificationRequestCopyWithImpl<
  $Res,
  $Val extends OtpVerificationRequest
>
    implements $OtpVerificationRequestCopyWith<$Res> {
  _$OtpVerificationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? otp = null,
    Object? otpId = null,
  }) {
    return _then(
      _value.copyWith(
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            otp: null == otp
                ? _value.otp
                : otp // ignore: cast_nullable_to_non_nullable
                      as String,
            otpId: null == otpId
                ? _value.otpId
                : otpId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtpVerificationRequestImplCopyWith<$Res>
    implements $OtpVerificationRequestCopyWith<$Res> {
  factory _$$OtpVerificationRequestImplCopyWith(
    _$OtpVerificationRequestImpl value,
    $Res Function(_$OtpVerificationRequestImpl) then,
  ) = __$$OtpVerificationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phoneNumber, String otp, String otpId});
}

/// @nodoc
class __$$OtpVerificationRequestImplCopyWithImpl<$Res>
    extends
        _$OtpVerificationRequestCopyWithImpl<$Res, _$OtpVerificationRequestImpl>
    implements _$$OtpVerificationRequestImplCopyWith<$Res> {
  __$$OtpVerificationRequestImplCopyWithImpl(
    _$OtpVerificationRequestImpl _value,
    $Res Function(_$OtpVerificationRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? otp = null,
    Object? otpId = null,
  }) {
    return _then(
      _$OtpVerificationRequestImpl(
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        otp: null == otp
            ? _value.otp
            : otp // ignore: cast_nullable_to_non_nullable
                  as String,
        otpId: null == otpId
            ? _value.otpId
            : otpId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpVerificationRequestImpl implements _OtpVerificationRequest {
  const _$OtpVerificationRequestImpl({
    required this.phoneNumber,
    required this.otp,
    required this.otpId,
  });

  factory _$OtpVerificationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpVerificationRequestImplFromJson(json);

  @override
  final String phoneNumber;
  @override
  final String otp;
  @override
  final String otpId;

  @override
  String toString() {
    return 'OtpVerificationRequest(phoneNumber: $phoneNumber, otp: $otp, otpId: $otpId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerificationRequestImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.otpId, otpId) || other.otpId == otpId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber, otp, otpId);

  /// Create a copy of OtpVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerificationRequestImplCopyWith<_$OtpVerificationRequestImpl>
  get copyWith =>
      __$$OtpVerificationRequestImplCopyWithImpl<_$OtpVerificationRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpVerificationRequestImplToJson(this);
  }
}

abstract class _OtpVerificationRequest implements OtpVerificationRequest {
  const factory _OtpVerificationRequest({
    required final String phoneNumber,
    required final String otp,
    required final String otpId,
  }) = _$OtpVerificationRequestImpl;

  factory _OtpVerificationRequest.fromJson(Map<String, dynamic> json) =
      _$OtpVerificationRequestImpl.fromJson;

  @override
  String get phoneNumber;
  @override
  String get otp;
  @override
  String get otpId;

  /// Create a copy of OtpVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpVerificationRequestImplCopyWith<_$OtpVerificationRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OtpVerificationResponse _$OtpVerificationResponseFromJson(
  Map<String, dynamic> json,
) {
  return _OtpVerificationResponse.fromJson(json);
}

/// @nodoc
mixin _$OtpVerificationResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  bool get isNewUser => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  String? get tempToken => throw _privateConstructorUsedError;

  /// Serializes this OtpVerificationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OtpVerificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpVerificationResponseCopyWith<OtpVerificationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerificationResponseCopyWith<$Res> {
  factory $OtpVerificationResponseCopyWith(
    OtpVerificationResponse value,
    $Res Function(OtpVerificationResponse) then,
  ) = _$OtpVerificationResponseCopyWithImpl<$Res, OtpVerificationResponse>;
  @useResult
  $Res call({
    bool success,
    String message,
    bool isNewUser,
    String? token,
    String? refreshToken,
    String? tempToken,
  });
}

/// @nodoc
class _$OtpVerificationResponseCopyWithImpl<
  $Res,
  $Val extends OtpVerificationResponse
>
    implements $OtpVerificationResponseCopyWith<$Res> {
  _$OtpVerificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpVerificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? isNewUser = null,
    Object? token = freezed,
    Object? refreshToken = freezed,
    Object? tempToken = freezed,
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
            isNewUser: null == isNewUser
                ? _value.isNewUser
                : isNewUser // ignore: cast_nullable_to_non_nullable
                      as bool,
            token: freezed == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String?,
            refreshToken: freezed == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String?,
            tempToken: freezed == tempToken
                ? _value.tempToken
                : tempToken // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OtpVerificationResponseImplCopyWith<$Res>
    implements $OtpVerificationResponseCopyWith<$Res> {
  factory _$$OtpVerificationResponseImplCopyWith(
    _$OtpVerificationResponseImpl value,
    $Res Function(_$OtpVerificationResponseImpl) then,
  ) = __$$OtpVerificationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    String message,
    bool isNewUser,
    String? token,
    String? refreshToken,
    String? tempToken,
  });
}

/// @nodoc
class __$$OtpVerificationResponseImplCopyWithImpl<$Res>
    extends
        _$OtpVerificationResponseCopyWithImpl<
          $Res,
          _$OtpVerificationResponseImpl
        >
    implements _$$OtpVerificationResponseImplCopyWith<$Res> {
  __$$OtpVerificationResponseImplCopyWithImpl(
    _$OtpVerificationResponseImpl _value,
    $Res Function(_$OtpVerificationResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OtpVerificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? isNewUser = null,
    Object? token = freezed,
    Object? refreshToken = freezed,
    Object? tempToken = freezed,
  }) {
    return _then(
      _$OtpVerificationResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        isNewUser: null == isNewUser
            ? _value.isNewUser
            : isNewUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        token: freezed == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String?,
        refreshToken: freezed == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String?,
        tempToken: freezed == tempToken
            ? _value.tempToken
            : tempToken // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpVerificationResponseImpl implements _OtpVerificationResponse {
  const _$OtpVerificationResponseImpl({
    required this.success,
    required this.message,
    required this.isNewUser,
    this.token,
    this.refreshToken,
    this.tempToken,
  });

  factory _$OtpVerificationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpVerificationResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final bool isNewUser;
  @override
  final String? token;
  @override
  final String? refreshToken;
  @override
  final String? tempToken;

  @override
  String toString() {
    return 'OtpVerificationResponse(success: $success, message: $message, isNewUser: $isNewUser, token: $token, refreshToken: $refreshToken, tempToken: $tempToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerificationResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isNewUser, isNewUser) ||
                other.isNewUser == isNewUser) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.tempToken, tempToken) ||
                other.tempToken == tempToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    message,
    isNewUser,
    token,
    refreshToken,
    tempToken,
  );

  /// Create a copy of OtpVerificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerificationResponseImplCopyWith<_$OtpVerificationResponseImpl>
  get copyWith =>
      __$$OtpVerificationResponseImplCopyWithImpl<
        _$OtpVerificationResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpVerificationResponseImplToJson(this);
  }
}

abstract class _OtpVerificationResponse implements OtpVerificationResponse {
  const factory _OtpVerificationResponse({
    required final bool success,
    required final String message,
    required final bool isNewUser,
    final String? token,
    final String? refreshToken,
    final String? tempToken,
  }) = _$OtpVerificationResponseImpl;

  factory _OtpVerificationResponse.fromJson(Map<String, dynamic> json) =
      _$OtpVerificationResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  bool get isNewUser;
  @override
  String? get token;
  @override
  String? get refreshToken;
  @override
  String? get tempToken;

  /// Create a copy of OtpVerificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpVerificationResponseImplCopyWith<_$OtpVerificationResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ProfileSetupRequest _$ProfileSetupRequestFromJson(Map<String, dynamic> json) {
  return _ProfileSetupRequest.fromJson(json);
}

/// @nodoc
mixin _$ProfileSetupRequest {
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String? get profilePic => throw _privateConstructorUsedError;

  /// Serializes this ProfileSetupRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileSetupRequestCopyWith<ProfileSetupRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileSetupRequestCopyWith<$Res> {
  factory $ProfileSetupRequestCopyWith(
    ProfileSetupRequest value,
    $Res Function(ProfileSetupRequest) then,
  ) = _$ProfileSetupRequestCopyWithImpl<$Res, ProfileSetupRequest>;
  @useResult
  $Res call({
    String name,
    int age,
    String gender,
    String location,
    String? profilePic,
  });
}

/// @nodoc
class _$ProfileSetupRequestCopyWithImpl<$Res, $Val extends ProfileSetupRequest>
    implements $ProfileSetupRequestCopyWith<$Res> {
  _$ProfileSetupRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? location = null,
    Object? profilePic = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String,
            profilePic: freezed == profilePic
                ? _value.profilePic
                : profilePic // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileSetupRequestImplCopyWith<$Res>
    implements $ProfileSetupRequestCopyWith<$Res> {
  factory _$$ProfileSetupRequestImplCopyWith(
    _$ProfileSetupRequestImpl value,
    $Res Function(_$ProfileSetupRequestImpl) then,
  ) = __$$ProfileSetupRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    int age,
    String gender,
    String location,
    String? profilePic,
  });
}

/// @nodoc
class __$$ProfileSetupRequestImplCopyWithImpl<$Res>
    extends _$ProfileSetupRequestCopyWithImpl<$Res, _$ProfileSetupRequestImpl>
    implements _$$ProfileSetupRequestImplCopyWith<$Res> {
  __$$ProfileSetupRequestImplCopyWithImpl(
    _$ProfileSetupRequestImpl _value,
    $Res Function(_$ProfileSetupRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? location = null,
    Object? profilePic = freezed,
  }) {
    return _then(
      _$ProfileSetupRequestImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String,
        profilePic: freezed == profilePic
            ? _value.profilePic
            : profilePic // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileSetupRequestImpl implements _ProfileSetupRequest {
  const _$ProfileSetupRequestImpl({
    required this.name,
    required this.age,
    required this.gender,
    required this.location,
    this.profilePic,
  });

  factory _$ProfileSetupRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileSetupRequestImplFromJson(json);

  @override
  final String name;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String location;
  @override
  final String? profilePic;

  @override
  String toString() {
    return 'ProfileSetupRequest(name: $name, age: $age, gender: $gender, location: $location, profilePic: $profilePic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSetupRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.profilePic, profilePic) ||
                other.profilePic == profilePic));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, age, gender, location, profilePic);

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSetupRequestImplCopyWith<_$ProfileSetupRequestImpl> get copyWith =>
      __$$ProfileSetupRequestImplCopyWithImpl<_$ProfileSetupRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileSetupRequestImplToJson(this);
  }
}

abstract class _ProfileSetupRequest implements ProfileSetupRequest {
  const factory _ProfileSetupRequest({
    required final String name,
    required final int age,
    required final String gender,
    required final String location,
    final String? profilePic,
  }) = _$ProfileSetupRequestImpl;

  factory _ProfileSetupRequest.fromJson(Map<String, dynamic> json) =
      _$ProfileSetupRequestImpl.fromJson;

  @override
  String get name;
  @override
  int get age;
  @override
  String get gender;
  @override
  String get location;
  @override
  String? get profilePic;

  /// Create a copy of ProfileSetupRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileSetupRequestImplCopyWith<_$ProfileSetupRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenRefreshRequest _$TokenRefreshRequestFromJson(Map<String, dynamic> json) {
  return _TokenRefreshRequest.fromJson(json);
}

/// @nodoc
mixin _$TokenRefreshRequest {
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this TokenRefreshRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenRefreshRequestCopyWith<TokenRefreshRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenRefreshRequestCopyWith<$Res> {
  factory $TokenRefreshRequestCopyWith(
    TokenRefreshRequest value,
    $Res Function(TokenRefreshRequest) then,
  ) = _$TokenRefreshRequestCopyWithImpl<$Res, TokenRefreshRequest>;
  @useResult
  $Res call({String refreshToken});
}

/// @nodoc
class _$TokenRefreshRequestCopyWithImpl<$Res, $Val extends TokenRefreshRequest>
    implements $TokenRefreshRequestCopyWith<$Res> {
  _$TokenRefreshRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? refreshToken = null}) {
    return _then(
      _value.copyWith(
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenRefreshRequestImplCopyWith<$Res>
    implements $TokenRefreshRequestCopyWith<$Res> {
  factory _$$TokenRefreshRequestImplCopyWith(
    _$TokenRefreshRequestImpl value,
    $Res Function(_$TokenRefreshRequestImpl) then,
  ) = __$$TokenRefreshRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String refreshToken});
}

/// @nodoc
class __$$TokenRefreshRequestImplCopyWithImpl<$Res>
    extends _$TokenRefreshRequestCopyWithImpl<$Res, _$TokenRefreshRequestImpl>
    implements _$$TokenRefreshRequestImplCopyWith<$Res> {
  __$$TokenRefreshRequestImplCopyWithImpl(
    _$TokenRefreshRequestImpl _value,
    $Res Function(_$TokenRefreshRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? refreshToken = null}) {
    return _then(
      _$TokenRefreshRequestImpl(
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenRefreshRequestImpl implements _TokenRefreshRequest {
  const _$TokenRefreshRequestImpl({required this.refreshToken});

  factory _$TokenRefreshRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenRefreshRequestImplFromJson(json);

  @override
  final String refreshToken;

  @override
  String toString() {
    return 'TokenRefreshRequest(refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenRefreshRequestImpl &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refreshToken);

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenRefreshRequestImplCopyWith<_$TokenRefreshRequestImpl> get copyWith =>
      __$$TokenRefreshRequestImplCopyWithImpl<_$TokenRefreshRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenRefreshRequestImplToJson(this);
  }
}

abstract class _TokenRefreshRequest implements TokenRefreshRequest {
  const factory _TokenRefreshRequest({required final String refreshToken}) =
      _$TokenRefreshRequestImpl;

  factory _TokenRefreshRequest.fromJson(Map<String, dynamic> json) =
      _$TokenRefreshRequestImpl.fromJson;

  @override
  String get refreshToken;

  /// Create a copy of TokenRefreshRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenRefreshRequestImplCopyWith<_$TokenRefreshRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return _TokenResponse.fromJson(json);
}

/// @nodoc
mixin _$TokenResponse {
  bool get success => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this TokenResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenResponseCopyWith<TokenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenResponseCopyWith<$Res> {
  factory $TokenResponseCopyWith(
    TokenResponse value,
    $Res Function(TokenResponse) then,
  ) = _$TokenResponseCopyWithImpl<$Res, TokenResponse>;
  @useResult
  $Res call({bool success, String token, String refreshToken});
}

/// @nodoc
class _$TokenResponseCopyWithImpl<$Res, $Val extends TokenResponse>
    implements $TokenResponseCopyWith<$Res> {
  _$TokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? token = null,
    Object? refreshToken = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenResponseImplCopyWith<$Res>
    implements $TokenResponseCopyWith<$Res> {
  factory _$$TokenResponseImplCopyWith(
    _$TokenResponseImpl value,
    $Res Function(_$TokenResponseImpl) then,
  ) = __$$TokenResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String token, String refreshToken});
}

/// @nodoc
class __$$TokenResponseImplCopyWithImpl<$Res>
    extends _$TokenResponseCopyWithImpl<$Res, _$TokenResponseImpl>
    implements _$$TokenResponseImplCopyWith<$Res> {
  __$$TokenResponseImplCopyWithImpl(
    _$TokenResponseImpl _value,
    $Res Function(_$TokenResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? token = null,
    Object? refreshToken = null,
  }) {
    return _then(
      _$TokenResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenResponseImpl implements _TokenResponse {
  const _$TokenResponseImpl({
    required this.success,
    required this.token,
    required this.refreshToken,
  });

  factory _$TokenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String token;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'TokenResponse(success: $success, token: $token, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, token, refreshToken);

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      __$$TokenResponseImplCopyWithImpl<_$TokenResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenResponseImplToJson(this);
  }
}

abstract class _TokenResponse implements TokenResponse {
  const factory _TokenResponse({
    required final bool success,
    required final String token,
    required final String refreshToken,
  }) = _$TokenResponseImpl;

  factory _TokenResponse.fromJson(Map<String, dynamic> json) =
      _$TokenResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get token;
  @override
  String get refreshToken;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
