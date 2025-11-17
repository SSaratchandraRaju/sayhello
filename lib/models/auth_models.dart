import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

/// OTP Request Model
@freezed
class OtpRequest with _$OtpRequest {
  const factory OtpRequest({
    required String phoneNumber,
    @Default('+91') String countryCode,
  }) = _OtpRequest;

  factory OtpRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestFromJson(json);
}

/// OTP Response Model
@freezed
class OtpResponse with _$OtpResponse {
  const factory OtpResponse({
    required bool success,
    required String message,
    required String otpId,
    int? expiresIn,
  }) = _OtpResponse;

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);
}

/// OTP Verification Request Model
@freezed
class OtpVerificationRequest with _$OtpVerificationRequest {
  const factory OtpVerificationRequest({
    required String phoneNumber,
    required String otp,
    required String otpId,
  }) = _OtpVerificationRequest;

  factory OtpVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationRequestFromJson(json);
}

/// OTP Verification Response Model
@freezed
class OtpVerificationResponse with _$OtpVerificationResponse {
  const factory OtpVerificationResponse({
    required bool success,
    required String message,
    required bool isNewUser,
    String? token,
    String? refreshToken,
    String? tempToken,
  }) = _OtpVerificationResponse;

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationResponseFromJson(json);
}

/// Profile Setup Request Model
@freezed
class ProfileSetupRequest with _$ProfileSetupRequest {
  const factory ProfileSetupRequest({
    required String name,
    required int age,
    required String gender,
    required String location,
    String? profilePic,
  }) = _ProfileSetupRequest;

  factory ProfileSetupRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileSetupRequestFromJson(json);
}

/// Token Refresh Request Model
@freezed
class TokenRefreshRequest with _$TokenRefreshRequest {
  const factory TokenRefreshRequest({required String refreshToken}) =
      _TokenRefreshRequest;

  factory TokenRefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshRequestFromJson(json);
}

/// Token Response Model
@freezed
class TokenResponse with _$TokenResponse {
  const factory TokenResponse({
    required bool success,
    required String token,
    required String refreshToken,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}
