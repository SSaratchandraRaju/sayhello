import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'agora_rtm_service.dart';
import 'chat_service.dart';

/// Service to track online users
/// Integrates with Agora RTM for real-time presence tracking
class OnlineUsersService {
  OnlineUsersService._internal();
  static final OnlineUsersService _instance = OnlineUsersService._internal();
  factory OnlineUsersService() => _instance;

  final AgoraRtmService _rtmService = AgoraRtmService();
  final ChatService _chatService = ChatService();

  // Currently selected user (logged in user)
  UserModel? _currentUser;

  // List of user IDs that are currently online
  final ValueNotifier<Set<String>> onlineUserIds = ValueNotifier<Set<String>>(
    {},
  );

  // Get current logged in user
  UserModel? get currentUser => _currentUser;

  // Set the current user (when they select a profile)
  Future<void> setCurrentUser(UserModel user) async {
    _currentUser = user;

    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user_id', user.id);
    await prefs.setString('current_user_name', user.name);

    // Initialize RTM for this user
    try {
      await _rtmService.initialize(user);

      // Initialize Chat Service
      await _chatService.initialize(user);

      // IMPORTANT: Setup RTM callbacks AFTER both services are initialized
      // This prevents callbacks from being overwritten

      // Listen for online users updates from RTM
      _rtmService.onOnlineUsersUpdated = (Set<String> userIds) {
        // Create a new Set to trigger ValueNotifier listeners
        onlineUserIds.value = Set<String>.from(userIds);
        debugPrint(
          '[ONLINE_USERS] Updated from RTM: ${userIds.length} users online: ${userIds.toList()}',
        );
      };

      // Setup chat message listener (from ChatService)
      _chatService.setupRTMMessageListener();

      debugPrint(
        '[ONLINE_USERS] Current user set with RTM and Chat: ${user.name} (${user.id})',
      );
    } catch (e) {
      debugPrint('[ONLINE_USERS] RTM/Chat initialization failed: $e');
      // Fallback to local tracking
      await _markUserOnline(user.id);
    }
  }

  // Mark a user as online
  Future<void> _markUserOnline(String userId) async {
    // Fallback for when RTM is not available
    final currentOnline = Set<String>.from(onlineUserIds.value);
    currentOnline.add(userId);
    onlineUserIds.value = currentOnline;

    debugPrint('[ONLINE_USERS] User marked online (local): $userId');
  }

  // Mark a user as offline
  Future<void> markUserOffline(String userId) async {
    // Fallback for when RTM is not available
    final currentOnline = Set<String>.from(onlineUserIds.value);
    currentOnline.remove(userId);
    onlineUserIds.value = currentOnline;

    debugPrint('[ONLINE_USERS] User marked offline (local): $userId');
  }

  // Check if a user is online
  bool isUserOnline(String userId) {
    return onlineUserIds.value.contains(userId);
  }

  // Get list of all online users
  List<UserModel> getOnlineUsers(List<UserModel> allUsers) {
    return allUsers.where((user) => isUserOnline(user.id)).toList();
  }

  // Simulate other users being online (for testing)
  void simulateOnlineUsers() {
    // This is no longer needed with RTM - real users will show as online
    // Keep for backward compatibility in case RTM fails
    debugPrint(
      '[ONLINE_USERS] RTM handles online status - simulation not needed',
    );
  }

  // Load persisted user from local storage
  Future<void> loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('current_user_id');
    final userName = prefs.getString('current_user_name');

    if (userId != null && userName != null) {
      // Reconstruct user from storage (in real app, fetch from API)
      debugPrint(
        '[ONLINE_USERS] Loaded user from storage: $userName ($userId)',
      );
    }
  }

  // Clear current user (logout)
  Future<void> clearCurrentUser() async {
    if (_currentUser != null) {
      // Logout from RTM
      await _rtmService.dispose();
      await markUserOffline(_currentUser!.id);
    }

    _currentUser = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_user_id');
    await prefs.remove('current_user_name');

    debugPrint('[ONLINE_USERS] Current user cleared');
  }

  // Get RTM service instance
  AgoraRtmService get rtmService => _rtmService;

  // Manually refresh online users from RTM
  Future<void> refreshOnlineUsers() async {
    debugPrint('[ONLINE_USERS] Requesting refresh from RTM...');
    await _rtmService.refreshOnlineUsers();
  }
}
