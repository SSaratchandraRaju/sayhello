import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import '../config/app_config.dart';
// DebugLogger removed; using console prints for agora service events

class AgoraService {
  AgoraService._internal();
  static final AgoraService _instance = AgoraService._internal();
  factory AgoraService() => _instance;

  // Replace DebugLogger with simple console prints
  void _logInfo(String msg) => print('[AGORA] $msg');
  void _logError(String msg) => print('[AGORA][ERROR] $msg');
  late final RtcEngine _engine;
  int? _remoteUid;
  final remoteUidNotifier = ValueNotifier<int?>(null);
  bool _joined = false;
  bool _mutedAudio = false;
  bool _mutedVideo = false;

  int? get remoteUid => _remoteUid;
  bool get joined => _joined;
  bool get isAudioMuted => _mutedAudio;
  bool get isVideoMuted => _mutedVideo;

  Future<void> initialize() async {
  _logInfo('Initializing Agora Engine');
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: AppConfig.agoraAppId));

    // register event handlers
    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType code, String? msg) {
  _logError('Agora error: $code ${msg ?? ''}');
      },
      onJoinChannelSuccess: (connection, elapsed) {
  _joined = true;
  _logInfo('Joined channel');
      },
      onUserJoined: (connection, remoteUid, elapsed) {
  _remoteUid = remoteUid;
  remoteUidNotifier.value = remoteUid;
  _logInfo('User joined: $remoteUid');
      },
      onUserOffline: (connection, remoteUid, reason) {
  _logInfo('User offline: $remoteUid, reason: $reason');
        if (_remoteUid == remoteUid) {
          _remoteUid = null;
          remoteUidNotifier.value = null;
        }
      },
      onLeaveChannel: (connection, stats) {
  _joined = false;
  _remoteUid = null;
  remoteUidNotifier.value = null;
  _logInfo('Left channel');
      },
    ));
  }

  Future<bool> _ensurePermissions() async {
    final statuses = await [Permission.camera, Permission.microphone].request();
    final camera = statuses[Permission.camera];
    final mic = statuses[Permission.microphone];
    final ok = (camera?.isGranted ?? false) && (mic?.isGranted ?? false);
    if (!ok) {
      _logError('Camera or microphone permission not granted');
    }
    return ok;
  }

  Future<void> joinChannel(String channelName, {String? token, int uid = 0}) async {
  _logInfo('Joining channel: $channelName');
    final ok = await _ensurePermissions();
    if (!ok) return;

    // enable video & audio
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token ?? AppConfig.tempToken ?? '',
      channelId: channelName,
      uid: uid,
      options: const ChannelMediaOptions(),
    );
  }

  // Expose engine for creating video controllers
  RtcEngine get engine => _engine;

  Future<void> leaveChannel() async {
  _logInfo('Leaving channel');
    await _engine.leaveChannel();
    await _engine.stopPreview();
    _joined = false;
    _remoteUid = null;
  }

  Future<void> toggleAudio() async {
    _mutedAudio = !_mutedAudio;
    await _engine.muteLocalAudioStream(_mutedAudio);
  _logInfo('Audio ${_mutedAudio ? 'muted' : 'unmuted'}');
  }

  Future<void> toggleVideo() async {
    _mutedVideo = !_mutedVideo;
    await _engine.muteLocalVideoStream(_mutedVideo);
    if (_mutedVideo) {
      await _engine.stopPreview();
    } else {
      await _engine.startPreview();
    }
  _logInfo('Video ${_mutedVideo ? 'disabled' : 'enabled'}');
  }

  Future<void> switchCamera() async {
  _logInfo('Switching camera');
    await _engine.switchCamera();
  }

  // Dispose the engine when app exits or service no longer needed
  Future<void> dispose() async {
  _logInfo('Disposing Agora engine');
    await _engine.release();
  }
}
