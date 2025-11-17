import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_models.freezed.dart';
part 'call_models.g.dart';

/// Call Initiate Request Model
@freezed
class CallInitiateRequest with _$CallInitiateRequest {
  const factory CallInitiateRequest({
    required String receiverId,
    required String callType,
    required String agoraChannelName,
  }) = _CallInitiateRequest;

  factory CallInitiateRequest.fromJson(Map<String, dynamic> json) =>
      _$CallInitiateRequestFromJson(json);
}

/// Call Initiate Response Model
@freezed
class CallInitiateResponse with _$CallInitiateResponse {
  const factory CallInitiateResponse({
    required bool allowed,
    required String message,
    String? callId,
    String? agoraToken,
    String? agoraRtmToken,
    int? tokenExpiresIn,
    double? estimatedCostPerMinute,
  }) = _CallInitiateResponse;

  factory CallInitiateResponse.fromJson(Map<String, dynamic> json) =>
      _$CallInitiateResponseFromJson(json);
}

/// Call Start Request Model
@freezed
class CallStartRequest with _$CallStartRequest {
  const factory CallStartRequest({
    required String callId,
    required String actualStartTime,
  }) = _CallStartRequest;

  factory CallStartRequest.fromJson(Map<String, dynamic> json) =>
      _$CallStartRequestFromJson(json);
}

/// Call End Request Model
@freezed
class CallEndRequest with _$CallEndRequest {
  const factory CallEndRequest({
    required String callId,
    required String actualEndTime,
    required int duration,
  }) = _CallEndRequest;

  factory CallEndRequest.fromJson(Map<String, dynamic> json) =>
      _$CallEndRequestFromJson(json);
}

/// Call Action Request Model (for cancel/decline)
@freezed
class CallActionRequest with _$CallActionRequest {
  const factory CallActionRequest({
    required String callId,
    required String reason,
  }) = _CallActionRequest;

  factory CallActionRequest.fromJson(Map<String, dynamic> json) =>
      _$CallActionRequestFromJson(json);
}

/// Call Details Model
@freezed
class CallDetails with _$CallDetails {
  const factory CallDetails({
    required String id,
    required String callerId,
    required String receiverId,
    required String callType,
    required String status,
    required String agoraChannelName,
    DateTime? initiatedAt,
    DateTime? startedAt,
    DateTime? endedAt,
    int? duration,
    double? creditsCharged,
    String? endReason,
  }) = _CallDetails;

  factory CallDetails.fromJson(Map<String, dynamic> json) =>
      _$CallDetailsFromJson(json);
}

/// Call Response Model
@freezed
class CallResponse with _$CallResponse {
  const factory CallResponse({
    required bool success,
    required String message,
    CallDetails? callDetails,
  }) = _CallResponse;

  factory CallResponse.fromJson(Map<String, dynamic> json) =>
      _$CallResponseFromJson(json);
}

/// Call History Response Model
@freezed
class CallHistoryResponse with _$CallHistoryResponse {
  const factory CallHistoryResponse({
    required List<CallDetails> calls,
    required int total,
    required int page,
    required int limit,
    required int totalPages,
  }) = _CallHistoryResponse;

  factory CallHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CallHistoryResponseFromJson(json);
}

/// Agora Token Request Model
@freezed
class AgoraTokenRequest with _$AgoraTokenRequest {
  const factory AgoraTokenRequest({
    required String channelName,
    required String userId,
    @Default('publisher') String role,
  }) = _AgoraTokenRequest;

  factory AgoraTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenRequestFromJson(json);
}

/// Agora Token Response Model
@freezed
class AgoraTokenResponse with _$AgoraTokenResponse {
  const factory AgoraTokenResponse({
    required bool success,
    required String rtcToken,
    required String rtmToken,
    required int expiresIn,
  }) = _AgoraTokenResponse;

  factory AgoraTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$AgoraTokenResponseFromJson(json);
}
