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
  RtcEngine? _engine;
  bool _isInitialized = false;
  int? _remoteUid;
  final remoteUidNotifier = ValueNotifier<int?>(null);
  bool _joined = false;
  bool _mutedAudio = false;
  bool _mutedVideo = false;
  String? _currentChannel;
  String? _currentToken;
  int _currentUid = 0;

  // Guarding fields for token refresh to avoid rapid/infinite renew loops
  bool _isRefreshingToken = false;
  // DateTime? _lastTokenRefreshTime; // removed; using _nextAllowedRefreshTime instead
  int _refreshFailCount = 0;
  static const int _maxRefreshFailures = 5;
  static const Duration _minRefreshInterval = Duration(seconds: 5);
  // Don't attempt another refresh until this time
  DateTime? _nextAllowedRefreshTime;
  // Track the last token we successfully renewed to avoid renewing the same token repeatedly
  String? _lastRenewedToken;
  // Guards for errInvalidToken event spam
  DateTime? _lastErrInvalidTime;
  int _errInvalidCount = 0;
  static const Duration _errInvalidWindow = Duration(seconds: 10);
  static const int _maxErrInvalidInWindow = 3;

  /// Optional async token provider callback used to fetch/refresh tokens.
  /// Should return a fresh token for the current channel/uid.
  Future<String?> Function(String channel, int uid)? tokenProvider;
  
  /// Optional callback when all remote users have left the channel
  Function()? onAllUsersLeft;

  /// Expose current token for debugging or external inspection.
  String? get currentToken => _currentToken;

  int? get remoteUid => _remoteUid;
  bool get joined => _joined;
  bool get isAudioMuted => _mutedAudio;
  bool get isVideoMuted => _mutedVideo;

  Future<void> initialize() async {
    if (_isInitialized && _engine != null) {
      _logInfo('Agora Engine already initialized, skipping...');
      return;
    }
    
    _logInfo('Initializing Agora Engine');
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(RtcEngineContext(
      appId: AppConfig.agoraAppId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    // register event handlers
    _engine!.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType code, String? msg) {
  _logError('Agora error: $code ${msg ?? ''}');
        // handle invalid token by attempting to refresh
        if (code == ErrorCodeType.errInvalidToken) {
          _logInfo('Received errInvalidToken');
          _handleErrInvalidTokenEvent();
        }
      },
      onJoinChannelSuccess: (connection, elapsed) {
  _joined = true;
  _logInfo('✅ Successfully joined channel: ${connection.channelId} with UID: ${connection.localUid}');
  _logInfo('⏱️  Elapsed time: $elapsed ms');
      },
      onUserJoined: (connection, remoteUid, elapsed) {
  _remoteUid = remoteUid;
  remoteUidNotifier.value = remoteUid;
  _logInfo('👤 Remote user JOINED: UID=$remoteUid (elapsed: $elapsed ms)');
  _logInfo('🎉 You should now see the remote user\'s video!');
      },
      onUserOffline: (connection, remoteUid, reason) {
        _logInfo('User offline: $remoteUid, reason: $reason');
        if (_remoteUid == remoteUid) {
          _remoteUid = null;
          remoteUidNotifier.value = null;
          
          // Notify that all users have left (in a 1-on-1 call scenario)
          // For multi-user support, you'd track all remote UIDs
          if (onAllUsersLeft != null) {
            _logInfo('All remote users left, triggering callback');
            onAllUsersLeft!();
          }
        }
      },
      onLeaveChannel: (connection, stats) {
        _joined = false;
        _remoteUid = null;
        remoteUidNotifier.value = null;
        _logInfo('Left channel');
        // Clear stored channel/token on leave
        _currentChannel = null;
        _currentToken = null;
      },
      onTokenPrivilegeWillExpire: (connection, token) async {
        _logInfo('Token privilege will expire soon');
        await _attemptTokenRefresh();
      },
    ));
    
    _isInitialized = true;
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

    // store details so we can attempt refreshes later
    _currentChannel = channelName;
    _currentUid = uid;

    // If caller did not pass a token but a tokenProvider exists, try to fetch one
    if ((token == null || token.isEmpty) && tokenProvider != null) {
      try {
        _logInfo('No token passed to joinChannel; fetching from tokenProvider');
        final fetched = await tokenProvider!(channelName, uid);
        if (fetched != null && fetched.isNotEmpty) {
          token = fetched;
          _logInfo('Fetched token from tokenProvider');
        } else {
          _logInfo('tokenProvider returned null/empty token; will fall back to stored/AppConfig.tempToken');
        }
      } catch (e, st) {
        _logError('tokenProvider threw while fetching initial token: $e');
        print(st);
      }
    }

    _currentToken = token;
    _currentUid = uid;

    // enable video & audio
    await _engine!.enableVideo();
    await _engine!.startPreview();

    final joinToken = token ?? AppConfig.tempToken ?? '';
    if (joinToken.isEmpty) {
      _logInfo('⚠️  Joining without a token (using empty token) — this may trigger errInvalidToken if the project requires tokens');
    } else {
      _logInfo('🔑 Using token: ${joinToken.substring(0, 20)}... (length: ${joinToken.length})');
    }

    _logInfo('📡 Attempting to join channel: $channelName with UID: $uid');
    await _engine!.joinChannel(
      token: joinToken,
      channelId: channelName,
      uid: uid,
      options: const ChannelMediaOptions(
        autoSubscribeVideo: true,
        autoSubscribeAudio: true,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  // Attempt to refresh token using tokenProvider if available.
  Future<void> _attemptTokenRefresh() async {
    // Prevent concurrent refreshes
    if (_isRefreshingToken) {
      _logInfo('Token refresh already in progress; skipping');
      return;
    }

    if (_currentChannel == null) {
      _logError('No channel configured, cannot refresh token');
      return;
    }

    final now = DateTime.now();
    if (_nextAllowedRefreshTime != null && now.isBefore(_nextAllowedRefreshTime!)) {
      final wait = _nextAllowedRefreshTime!.difference(now).inSeconds;
      _logInfo('Token refresh suppressed; next allowed in ${wait}s');
      return;
    }

    if (_refreshFailCount >= _maxRefreshFailures) {
      _logError('Max token refresh failures reached ($_refreshFailCount); will not retry automatically');
      return;
    }

    _isRefreshingToken = true;
    String? newToken;
    try {
      if (tokenProvider != null) {
        try {
          newToken = await tokenProvider!(_currentChannel!, _currentUid);
        } catch (e, st) {
          _logError('tokenProvider threw an exception: $e');
          print(st);
        }
      }

      newToken ??= _currentToken ?? AppConfig.tempToken;

      // If we're about to renew the same token we last renewed and there's no tokenProvider
      // (i.e. using fallback token), avoid looping renews
      if (tokenProvider == null && _lastRenewedToken != null && newToken == _lastRenewedToken) {
        _refreshFailCount += 1;
        final backoffSec = 1 << (_refreshFailCount > 6 ? 6 : _refreshFailCount);
        _nextAllowedRefreshTime = DateTime.now().add(Duration(seconds: backoffSec));
        _logError('Attempted to renew same fallback token repeatedly; backing off $backoffSec seconds (fail=$_refreshFailCount)');
        return;
      }

      if (newToken == null || newToken.isEmpty) {
        _logError('No token available to renew (tokenProvider/stored/AppConfig.tempToken empty)');
        return;
      }

      _currentToken = newToken;
      _logInfo('Renewing Agora token (fallback=${tokenProvider==null})');
      await _engine!.renewToken(newToken);
      _logInfo('Token renewed successfully');

      // reset failure counter on success and record token/time
      _refreshFailCount = 0;
      _lastRenewedToken = newToken;
      _nextAllowedRefreshTime = DateTime.now().add(_minRefreshInterval);
    } catch (e, st) {
      _refreshFailCount += 1;
      _logError('Failed to renew token: $e (fail count=$_refreshFailCount)');
      print(st);

      // exponential backoff delay before allowing another attempt
      final backoffSec = 1 << (_refreshFailCount > 6 ? 6 : _refreshFailCount);
      _nextAllowedRefreshTime = DateTime.now().add(Duration(seconds: backoffSec));
    } finally {
      _isRefreshingToken = false;
    }
  }

  /// Handle errInvalidToken event frequency and decide whether to invoke refresh.
  void _handleErrInvalidTokenEvent() {
    final now = DateTime.now();
    if (_lastErrInvalidTime == null || now.difference(_lastErrInvalidTime!) > _errInvalidWindow) {
      _errInvalidCount = 1;
      _lastErrInvalidTime = now;
    } else {
      _errInvalidCount += 1;
      _lastErrInvalidTime = now;
    }

    if (_errInvalidCount > _maxErrInvalidInWindow) {
      _logError('errInvalidToken received >$_maxErrInvalidInWindow times within ${_errInvalidWindow.inSeconds}s; suppressing further automatic refreshes');
      // set a cooldown to avoid further attempts for a while
      _nextAllowedRefreshTime = DateTime.now().add(Duration(seconds: 30));
      return;
    }

    // Otherwise, attempt a refresh (async fire-and-forget)
    _logInfo('errInvalidToken count=$_errInvalidCount; attempting token refresh');
    _attemptTokenRefresh();
  }

  // Expose engine for creating video controllers
  RtcEngine get engine => _engine!;

  Future<void> leaveChannel() async {
    _logInfo('Leaving channel');
    await _engine!.leaveChannel();
    await _engine!.stopPreview();
    _joined = false;
    _remoteUid = null;
  }

  Future<void> toggleAudio() async {
    _mutedAudio = !_mutedAudio;
    await _engine!.muteLocalAudioStream(_mutedAudio);
    _logInfo('Audio ${_mutedAudio ? 'muted' : 'unmuted'}');
  }

  Future<void> toggleVideo() async {
    _mutedVideo = !_mutedVideo;
    await _engine!.muteLocalVideoStream(_mutedVideo);
    if (_mutedVideo) {
      await _engine!.stopPreview();
    } else {
      await _engine!.startPreview();
    }
    _logInfo('Video ${_mutedVideo ? 'disabled' : 'enabled'}');
  }

  Future<void> switchCamera() async {
    _logInfo('Switching camera');
    await _engine!.switchCamera();
  }

  // Dispose the engine when app exits or service no longer needed
  Future<void> dispose() async {
    _logInfo('Disposing Agora engine');
    if (_engine != null) {
      await _engine!.release();
      _engine = null;
      _isInitialized = false;
    }
  }
}
