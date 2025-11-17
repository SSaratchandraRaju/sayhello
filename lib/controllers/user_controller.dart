import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import '../core/exceptions/api_exceptions.dart';

/// User Controller
class UserController extends GetxController {
  final UserRepository _userRepository;
  final Logger _logger = Logger();

  UserController({UserRepository? userRepository})
    : _userRepository = userRepository ?? UserRepository();

  // Observable state
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxList<UserModel> onlineUsers = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingUsers = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  /// Load current user profile
  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      error.value = '';

      final user = await _userRepository.getProfile();
      currentUser.value = user;
      _logger.i('User profile loaded: ${user.name}');
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to load profile', error: e);
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error loading profile', error: e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Load online users
  Future<void> loadOnlineUsers({
    String? gender,
    int? minAge,
    int? maxAge,
    String? location,
  }) async {
    try {
      isLoadingUsers.value = true;
      error.value = '';

      final users = await _userRepository.getOnlineUsers(
        gender: gender,
        minAge: minAge,
        maxAge: maxAge,
        location: location,
      );

      onlineUsers.value = users;
      _logger.i('Loaded ${users.length} online users');
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to load online users', error: e);
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error loading online users', error: e);
    } finally {
      isLoadingUsers.value = false;
    }
  }

  /// Update user presence
  Future<void> updatePresence(bool isOnline) async {
    try {
      await _userRepository.updatePresence(isOnline);

      if (currentUser.value != null) {
        currentUser.value = currentUser.value!.copyWith(isOnline: isOnline);
      }

      _logger.i('Presence updated: ${isOnline ? "online" : "offline"}');
    } on ApiException catch (e) {
      _logger.e('Failed to update presence', error: e);
    } catch (e) {
      _logger.e('Unexpected error updating presence', error: e);
    }
  }

  /// Update user profile
  Future<bool> updateProfile({
    String? name,
    int? age,
    String? location,
    String? profilePic,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final updatedUser = await _userRepository.updateProfile(
        name: name,
        age: age,
        location: location,
        profilePic: profilePic,
      );

      currentUser.value = updatedUser;
      _logger.i('Profile updated successfully');
      return true;
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to update profile', error: e);
      return false;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error updating profile', error: e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Set user to online
  Future<void> goOnline() async {
    await updatePresence(true);
  }

  /// Set user to offline
  Future<void> goOffline() async {
    await updatePresence(false);
  }

  /// Refresh user data
  Future<void> refresh() async {
    await Future.wait([loadProfile(), loadOnlineUsers()]);
  }

  /// Clear error message
  void clearError() {
    error.value = '';
  }
}
