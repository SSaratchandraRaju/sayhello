// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CallInitiateRequestImpl _$$CallInitiateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CallInitiateRequestImpl(
  receiverId: json['receiverId'] as String,
  callType: json['callType'] as String,
  agoraChannelName: json['agoraChannelName'] as String,
);

Map<String, dynamic> _$$CallInitiateRequestImplToJson(
  _$CallInitiateRequestImpl instance,
) => <String, dynamic>{
  'receiverId': instance.receiverId,
  'callType': instance.callType,
  'agoraChannelName': instance.agoraChannelName,
};

_$CallInitiateResponseImpl _$$CallInitiateResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CallInitiateResponseImpl(
  allowed: json['allowed'] as bool,
  message: json['message'] as String,
  callId: json['callId'] as String?,
  agoraToken: json['agoraToken'] as String?,
  agoraRtmToken: json['agoraRtmToken'] as String?,
  tokenExpiresIn: (json['tokenExpiresIn'] as num?)?.toInt(),
  estimatedCostPerMinute: (json['estimatedCostPerMinute'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$CallInitiateResponseImplToJson(
  _$CallInitiateResponseImpl instance,
) => <String, dynamic>{
  'allowed': instance.allowed,
  'message': instance.message,
  'callId': instance.callId,
  'agoraToken': instance.agoraToken,
  'agoraRtmToken': instance.agoraRtmToken,
  'tokenExpiresIn': instance.tokenExpiresIn,
  'estimatedCostPerMinute': instance.estimatedCostPerMinute,
};

_$CallStartRequestImpl _$$CallStartRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CallStartRequestImpl(
  callId: json['callId'] as String,
  actualStartTime: json['actualStartTime'] as String,
);

Map<String, dynamic> _$$CallStartRequestImplToJson(
  _$CallStartRequestImpl instance,
) => <String, dynamic>{
  'callId': instance.callId,
  'actualStartTime': instance.actualStartTime,
};

_$CallEndRequestImpl _$$CallEndRequestImplFromJson(Map<String, dynamic> json) =>
    _$CallEndRequestImpl(
      callId: json['callId'] as String,
      actualEndTime: json['actualEndTime'] as String,
      duration: (json['duration'] as num).toInt(),
    );

Map<String, dynamic> _$$CallEndRequestImplToJson(
  _$CallEndRequestImpl instance,
) => <String, dynamic>{
  'callId': instance.callId,
  'actualEndTime': instance.actualEndTime,
  'duration': instance.duration,
};

_$CallActionRequestImpl _$$CallActionRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CallActionRequestImpl(
  callId: json['callId'] as String,
  reason: json['reason'] as String,
);

Map<String, dynamic> _$$CallActionRequestImplToJson(
  _$CallActionRequestImpl instance,
) => <String, dynamic>{'callId': instance.callId, 'reason': instance.reason};

_$CallDetailsImpl _$$CallDetailsImplFromJson(Map<String, dynamic> json) =>
    _$CallDetailsImpl(
      id: json['id'] as String,
      callerId: json['callerId'] as String,
      receiverId: json['receiverId'] as String,
      callType: json['callType'] as String,
      status: json['status'] as String,
      agoraChannelName: json['agoraChannelName'] as String,
      initiatedAt: json['initiatedAt'] == null
          ? null
          : DateTime.parse(json['initiatedAt'] as String),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      duration: (json['duration'] as num?)?.toInt(),
      creditsCharged: (json['creditsCharged'] as num?)?.toDouble(),
      endReason: json['endReason'] as String?,
    );

Map<String, dynamic> _$$CallDetailsImplToJson(_$CallDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'callerId': instance.callerId,
      'receiverId': instance.receiverId,
      'callType': instance.callType,
      'status': instance.status,
      'agoraChannelName': instance.agoraChannelName,
      'initiatedAt': instance.initiatedAt?.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'duration': instance.duration,
      'creditsCharged': instance.creditsCharged,
      'endReason': instance.endReason,
    };

_$CallResponseImpl _$$CallResponseImplFromJson(Map<String, dynamic> json) =>
    _$CallResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      callDetails: json['callDetails'] == null
          ? null
          : CallDetails.fromJson(json['callDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CallResponseImplToJson(_$CallResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'callDetails': instance.callDetails,
    };

_$CallHistoryResponseImpl _$$CallHistoryResponseImplFromJson(
  Map<String, dynamic> json,
) => _$CallHistoryResponseImpl(
  calls: (json['calls'] as List<dynamic>)
      .map((e) => CallDetails.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
);

Map<String, dynamic> _$$CallHistoryResponseImplToJson(
  _$CallHistoryResponseImpl instance,
) => <String, dynamic>{
  'calls': instance.calls,
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
  'totalPages': instance.totalPages,
};

_$AgoraTokenRequestImpl _$$AgoraTokenRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AgoraTokenRequestImpl(
  channelName: json['channelName'] as String,
  userId: json['userId'] as String,
  role: json['role'] as String? ?? 'publisher',
);

Map<String, dynamic> _$$AgoraTokenRequestImplToJson(
  _$AgoraTokenRequestImpl instance,
) => <String, dynamic>{
  'channelName': instance.channelName,
  'userId': instance.userId,
  'role': instance.role,
};

_$AgoraTokenResponseImpl _$$AgoraTokenResponseImplFromJson(
  Map<String, dynamic> json,
) => _$AgoraTokenResponseImpl(
  success: json['success'] as bool,
  rtcToken: json['rtcToken'] as String,
  rtmToken: json['rtmToken'] as String,
  expiresIn: (json['expiresIn'] as num).toInt(),
);

Map<String, dynamic> _$$AgoraTokenResponseImplToJson(
  _$AgoraTokenResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'rtcToken': instance.rtcToken,
  'rtmToken': instance.rtmToken,
  'expiresIn': instance.expiresIn,
};
