// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OtpRequestImpl _$$OtpRequestImplFromJson(Map<String, dynamic> json) =>
    _$OtpRequestImpl(
      phoneNumber: json['phoneNumber'] as String,
      countryCode: json['countryCode'] as String? ?? '+91',
    );

Map<String, dynamic> _$$OtpRequestImplToJson(_$OtpRequestImpl instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'countryCode': instance.countryCode,
    };

_$OtpResponseImpl _$$OtpResponseImplFromJson(Map<String, dynamic> json) =>
    _$OtpResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      otpId: json['otpId'] as String,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$OtpResponseImplToJson(_$OtpResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otpId': instance.otpId,
      'expiresIn': instance.expiresIn,
    };

_$OtpVerificationRequestImpl _$$OtpVerificationRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OtpVerificationRequestImpl(
  phoneNumber: json['phoneNumber'] as String,
  otp: json['otp'] as String,
  otpId: json['otpId'] as String,
);

Map<String, dynamic> _$$OtpVerificationRequestImplToJson(
  _$OtpVerificationRequestImpl instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'otp': instance.otp,
  'otpId': instance.otpId,
};

_$OtpVerificationResponseImpl _$$OtpVerificationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$OtpVerificationResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
  isNewUser: json['isNewUser'] as bool,
  token: json['token'] as String?,
  refreshToken: json['refreshToken'] as String?,
  tempToken: json['tempToken'] as String?,
);

Map<String, dynamic> _$$OtpVerificationResponseImplToJson(
  _$OtpVerificationResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'isNewUser': instance.isNewUser,
  'token': instance.token,
  'refreshToken': instance.refreshToken,
  'tempToken': instance.tempToken,
};

_$ProfileSetupRequestImpl _$$ProfileSetupRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ProfileSetupRequestImpl(
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
  gender: json['gender'] as String,
  location: json['location'] as String,
  profilePic: json['profilePic'] as String?,
);

Map<String, dynamic> _$$ProfileSetupRequestImplToJson(
  _$ProfileSetupRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'age': instance.age,
  'gender': instance.gender,
  'location': instance.location,
  'profilePic': instance.profilePic,
};

_$TokenRefreshRequestImpl _$$TokenRefreshRequestImplFromJson(
  Map<String, dynamic> json,
) => _$TokenRefreshRequestImpl(refreshToken: json['refreshToken'] as String);

Map<String, dynamic> _$$TokenRefreshRequestImplToJson(
  _$TokenRefreshRequestImpl instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};

_$TokenResponseImpl _$$TokenResponseImplFromJson(Map<String, dynamic> json) =>
    _$TokenResponseImpl(
      success: json['success'] as bool,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$$TokenResponseImplToJson(_$TokenResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
