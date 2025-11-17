import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/call_models.dart';
import '../repositories/call_repository.dart';
import '../core/exceptions/api_exceptions.dart';
import 'wallet_controller.dart';

/// Call Controller
class CallController extends GetxController {
  final CallRepository _callRepository;
  final Logger _logger = Logger();

  CallController({CallRepository? callRepository})
    : _callRepository = callRepository ?? CallRepository();

  // Observable state
  final Rx<CallDetails?> activeCall = Rx<CallDetails?>(null);
  final RxList<CallDetails> callHistory = <CallDetails>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingHistory = false.obs;
  final RxString error = ''.obs;

  // Call state
  final RxString callId = ''.obs;
  final Rx<DateTime?> callStartTime = Rx<DateTime?>(null);
  final RxInt callDuration = 0.obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxBool hasMore = true.obs;

  /// Initiate a call
  Future<CallInitiateResponse?> initiateCall({
    required String receiverId,
    required String callType,
    required String agoraChannelName,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _callRepository.initiateCall(
        receiverId: receiverId,
        callType: callType,
        agoraChannelName: agoraChannelName,
      );

      if (response.allowed) {
        callId.value = response.callId ?? '';
        _logger.i('Call initiated successfully: ${response.callId}');
        return response;
      } else {
        error.value = response.message;
        _logger.w('Call not allowed: ${response.message}');
        return null;
      }
    } on InsufficientCreditsException catch (e) {
      error.value = e.message;
      _logger.w('Insufficient credits for call', error: e);
      return null;
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to initiate call', error: e);
      return null;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error initiating call', error: e);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Start a call (begin billing)
  Future<bool> startCall() async {
    if (callId.value.isEmpty) {
      _logger.e('Cannot start call: No active call ID');
      return false;
    }

    try {
      callStartTime.value = DateTime.now();

      final response = await _callRepository.startCall(
        callId: callId.value,
        actualStartTime: callStartTime.value!.toIso8601String(),
      );

      if (response.success) {
        activeCall.value = response.callDetails;
        _logger.i('Call started successfully');

        // Start duration counter
        _startDurationCounter();
        return true;
      }
      return false;
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to start call', error: e);
      return false;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error starting call', error: e);
      return false;
    }
  }

  /// End a call (finalize billing)
  Future<CallDetails?> endCall() async {
    if (callId.value.isEmpty || callStartTime.value == null) {
      _logger.e('Cannot end call: No active call');
      return null;
    }

    try {
      final endTime = DateTime.now();
      final duration = endTime.difference(callStartTime.value!).inSeconds;

      final response = await _callRepository.endCall(
        callId: callId.value,
        actualEndTime: endTime.toIso8601String(),
        duration: duration,
      );

      if (response.success && response.callDetails != null) {
        _logger.i('Call ended successfully. Duration: $duration seconds');

        // Update wallet balance
        final walletController = Get.find<WalletController>();
        if (response.callDetails!.creditsCharged != null) {
          walletController.deductCredits(response.callDetails!.creditsCharged!);
        }

        // Reset call state
        _resetCallState();

        return response.callDetails;
      }
      return null;
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to end call', error: e);
      return null;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error ending call', error: e);
      return null;
    }
  }

  /// Cancel a call
  Future<bool> cancelCall(String reason) async {
    if (callId.value.isEmpty) {
      _logger.e('Cannot cancel call: No active call ID');
      return false;
    }

    try {
      final response = await _callRepository.cancelCall(
        callId: callId.value,
        reason: reason,
      );

      if (response.success) {
        _logger.i('Call cancelled successfully');
        _resetCallState();
        return true;
      }
      return false;
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to cancel call', error: e);
      return false;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error cancelling call', error: e);
      return false;
    }
  }

  /// Decline a call
  Future<bool> declineCall(String callIdParam, String reason) async {
    try {
      final response = await _callRepository.declineCall(
        callId: callIdParam,
        reason: reason,
      );

      if (response.success) {
        _logger.i('Call declined successfully');
        return true;
      }
      return false;
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to decline call', error: e);
      return false;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error declining call', error: e);
      return false;
    }
  }

  /// Load call history
  Future<void> loadCallHistory({
    bool refresh = false,
    String type = 'all',
    String callType = 'all',
  }) async {
    try {
      if (refresh) {
        currentPage.value = 1;
        callHistory.clear();
      }

      isLoadingHistory.value = true;
      error.value = '';

      final response = await _callRepository.getCallHistory(
        page: currentPage.value,
        limit: 20,
        type: type,
        callType: callType,
      );

      if (refresh) {
        callHistory.value = response.calls;
      } else {
        callHistory.addAll(response.calls);
      }

      totalPages.value = response.totalPages;
      hasMore.value = currentPage.value < totalPages.value;

      _logger.i('Loaded ${response.calls.length} call records');
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to load call history', error: e);
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error loading call history', error: e);
    } finally {
      isLoadingHistory.value = false;
    }
  }

  /// Load more call history
  Future<void> loadMoreHistory({
    String type = 'all',
    String callType = 'all',
  }) async {
    if (!hasMore.value || isLoadingHistory.value) return;

    currentPage.value++;
    await loadCallHistory(type: type, callType: callType);
  }

  /// Get call status
  Future<CallDetails?> getCallStatus(String callIdParam) async {
    try {
      final response = await _callRepository.getCallStatus(callIdParam);
      return response.callDetails;
    } on ApiException catch (e) {
      _logger.e('Failed to get call status', error: e);
      return null;
    } catch (e) {
      _logger.e('Unexpected error getting call status', error: e);
      return null;
    }
  }

  /// Generate Agora tokens
  Future<AgoraTokenResponse?> generateAgoraTokens({
    required String channelName,
    required String userId,
    String role = 'publisher',
  }) async {
    try {
      final response = await _callRepository.generateAgoraTokens(
        channelName: channelName,
        userId: userId,
        role: role,
      );

      if (response.success) {
        _logger.i('Agora tokens generated successfully');
        return response;
      }
      return null;
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to generate Agora tokens', error: e);
      return null;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error generating tokens', error: e);
      return null;
    }
  }

  /// Start duration counter
  void _startDurationCounter() {
    // Update duration every second
    Stream.periodic(const Duration(seconds: 1)).listen((_) {
      if (callStartTime.value != null) {
        callDuration.value = DateTime.now()
            .difference(callStartTime.value!)
            .inSeconds;
      }
    });
  }

  /// Reset call state
  void _resetCallState() {
    callId.value = '';
    callStartTime.value = null;
    callDuration.value = 0;
    activeCall.value = null;
  }

  /// Clear error message
  void clearError() {
    error.value = '';
  }
}
