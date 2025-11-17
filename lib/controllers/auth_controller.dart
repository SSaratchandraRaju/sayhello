import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/auth_models.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../core/exceptions/api_exceptions.dart';

/// Authentication Controller
class AuthController extends GetxController {
  final AuthRepository _authRepository;
  final Logger _logger = Logger();

  AuthController({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository();

  // Observable state
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isAuthenticated = false.obs;
  final RxString error = ''.obs;

  // OTP state
  final RxString otpId = ''.obs;
  final RxString phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  /// Check if user is already authenticated
  Future<void> checkAuthStatus() async {
    try {
      isAuthenticated.value = _authRepository.isAuthenticated;
      if (isAuthenticated.value) {
        await loadCurrentUser();
      }
    } catch (e) {
      _logger.e('Error checking auth status', error: e);
    }
  }

  /// Load current user profile
  Future<void> loadCurrentUser() async {
    try {
      // This will be implemented when we integrate user repository
      // For now, just mark as authenticated
      isAuthenticated.value = true;
    } catch (e) {
      _logger.e('Error loading user', error: e);
    }
  }

  /// Send OTP to phone number
  Future<bool> sendOtp(String phone, {String countryCode = '+91'}) async {
    try {
      isLoading.value = true;
      error.value = '';
      phoneNumber.value = phone;

      final response = await _authRepository.sendOtp(
        phone,
        countryCode: countryCode,
      );

      if (response.success) {
        otpId.value = response.otpId;
        _logger.i('OTP sent successfully to $phone');
        return true;
      } else {
        error.value = response.message;
        return false;
      }
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to send OTP', error: e);
      return false;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error sending OTP', error: e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Verify OTP
  Future<OtpVerificationResponse?> verifyOtp(String otp) async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _authRepository.verifyOtp(
        phoneNumber: phoneNumber.value,
        otp: otp,
        otpId: otpId.value,
      );

      if (response.success) {
        if (!response.isNewUser) {
          // Existing user - mark as authenticated
          isAuthenticated.value = true;
          await loadCurrentUser();
          _logger.i('User logged in successfully');
        } else {
          _logger.i('New user - needs profile setup');
        }
        return response;
      } else {
        error.value = response.message;
        return null;
      }
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to verify OTP', error: e);
      return null;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error verifying OTP', error: e);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Setup user profile (for new users)
  Future<bool> setupProfile({
    required String tempToken,
    required String name,
    required int age,
    required String gender,
    required String location,
    String? profilePic,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final user = await _authRepository.setupProfile(
        tempToken: tempToken,
        name: name,
        age: age,
        gender: gender,
        location: location,
        profilePic: profilePic,
      );

      currentUser.value = user;
      isAuthenticated.value = true;
      _logger.i('Profile setup completed for ${user.name}');
      return true;
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to setup profile', error: e);
      return false;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error setting up profile', error: e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await _authRepository.logout();
      currentUser.value = null;
      isAuthenticated.value = false;
      phoneNumber.value = '';
      otpId.value = '';
      _logger.i('User logged out successfully');
    } catch (e) {
      _logger.e('Error during logout', error: e);
    }
  }

  /// Clear error message
  void clearError() {
    error.value = '';
  }
}
