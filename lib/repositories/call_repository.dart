import '../../core/network/api_client.dart';
import '../../models/call_models.dart';

/// Call Repository
class CallRepository {
  final ApiClient _apiClient;

  CallRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  /// Initiate a call (pre-flight check)
  Future<CallInitiateResponse> initiateCall({
    required String receiverId,
    required String callType,
    required String agoraChannelName,
  }) async {
    try {
      final response = await _apiClient.post(
        '/calls/initiate',
        data: CallInitiateRequest(
          receiverId: receiverId,
          callType: callType,
          agoraChannelName: agoraChannelName,
        ).toJson(),
      );

      return CallInitiateResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Start a call (begin billing)
  Future<CallResponse> startCall({
    required String callId,
    required String actualStartTime,
  }) async {
    try {
      final response = await _apiClient.post(
        '/calls/start',
        data: CallStartRequest(
          callId: callId,
          actualStartTime: actualStartTime,
        ).toJson(),
      );

      return CallResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// End a call (finalize billing)
  Future<CallResponse> endCall({
    required String callId,
    required String actualEndTime,
    required int duration,
  }) async {
    try {
      final response = await _apiClient.post(
        '/calls/end',
        data: CallEndRequest(
          callId: callId,
          actualEndTime: actualEndTime,
          duration: duration,
        ).toJson(),
      );

      return CallResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Cancel a call
  Future<CallResponse> cancelCall({
    required String callId,
    required String reason,
  }) async {
    try {
      final response = await _apiClient.post(
        '/calls/cancel',
        data: CallActionRequest(callId: callId, reason: reason).toJson(),
      );

      return CallResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Decline a call
  Future<CallResponse> declineCall({
    required String callId,
    required String reason,
  }) async {
    try {
      final response = await _apiClient.post(
        '/calls/decline',
        data: CallActionRequest(callId: callId, reason: reason).toJson(),
      );

      return CallResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Get call history
  Future<CallHistoryResponse> getCallHistory({
    int page = 1,
    int limit = 20,
    String type = 'all',
    String callType = 'all',
  }) async {
    try {
      final response = await _apiClient.get(
        '/calls/history',
        queryParameters: {
          'page': page,
          'limit': limit,
          'type': type,
          'callType': callType,
        },
      );

      return CallHistoryResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Get active call status
  Future<CallResponse> getCallStatus(String callId) async {
    try {
      final response = await _apiClient.get('/calls/$callId/status');
      return CallResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Generate Agora tokens
  Future<AgoraTokenResponse> generateAgoraTokens({
    required String channelName,
    required String userId,
    String role = 'publisher',
  }) async {
    try {
      final response = await _apiClient.post(
        '/agora/tokens',
        data: AgoraTokenRequest(
          channelName: channelName,
          userId: userId,
          role: role,
        ).toJson(),
      );

      return AgoraTokenResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
