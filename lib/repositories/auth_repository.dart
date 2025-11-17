import '../../core/network/api_client.dart';
import '../../models/auth_models.dart';
import '../../models/user_model.dart';

/// Authentication Repository
class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  /// Send OTP to phone number
  Future<OtpResponse> sendOtp(
    String phoneNumber, {
    String countryCode = '+91',
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/send-otp',
        data: OtpRequest(
          phoneNumber: phoneNumber,
          countryCode: countryCode,
        ).toJson(),
      );

      return OtpResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Verify OTP
  Future<OtpVerificationResponse> verifyOtp({
    required String phoneNumber,
    required String otp,
    required String otpId,
  }) async {
    try {
      final response = await _apiClient.post(
        '/auth/verify-otp',
        data: OtpVerificationRequest(
          phoneNumber: phoneNumber,
          otp: otp,
          otpId: otpId,
        ).toJson(),
      );

      final verificationResponse = OtpVerificationResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Save tokens if user is not new
      if (!verificationResponse.isNewUser &&
          verificationResponse.token != null &&
          verificationResponse.refreshToken != null) {
        await _apiClient.setTokens(
          verificationResponse.token!,
          verificationResponse.refreshToken!,
        );
      }

      return verificationResponse;
    } catch (e) {
      rethrow;
    }
  }

  /// Setup user profile (for new users)
  Future<UserModel> setupProfile({
    required String tempToken,
    required String name,
    required int age,
    required String gender,
    required String location,
    String? profilePic,
  }) async {
    try {
      // Set temp token for this request
      await _apiClient.setTokens(tempToken, '');

      final response = await _apiClient.post(
        '/auth/setup-profile',
        data: ProfileSetupRequest(
          name: name,
          age: age,
          gender: gender,
          location: location,
          profilePic: profilePic,
        ).toJson(),
      );

      final data = response.data as Map<String, dynamic>;

      // Save actual tokens
      await _apiClient.setTokens(
        data['token'] as String,
        data['refreshToken'] as String,
      );

      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Refresh access token
  Future<TokenResponse> refreshToken(String refreshToken) async {
    try {
      final response = await _apiClient.post(
        '/auth/refresh-token',
        data: TokenRefreshRequest(refreshToken: refreshToken).toJson(),
      );

      final tokenResponse = TokenResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Save new tokens
      await _apiClient.setTokens(
        tokenResponse.token,
        tokenResponse.refreshToken,
      );

      return tokenResponse;
    } catch (e) {
      rethrow;
    }
  }

  /// Logout
  Future<void> logout() async {
    await _apiClient.clearTokens();
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _apiClient.isAuthenticated;
}
