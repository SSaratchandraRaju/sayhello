import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/user_model.dart';
import '../services/credits_service.dart';
import '../config/app_config.dart';
import 'dart:async';

class VideoCallView extends StatefulWidget {
  final UserModel user;
  final String channelName;

  const VideoCallView({
    Key? key,
    required this.user,
    required this.channelName,
  }) : super(key: key);

  @override
  State<VideoCallView> createState() => _VideoCallViewState();
}

class _VideoCallViewState extends State<VideoCallView> {
  RtcEngine? _engine;
  final CreditsService _creditsService = CreditsService();
  
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isFrontCamera = true;
  bool _isRemoteUserJoined = false;
  int _remoteUid = 0;
  
  int _callDuration = 0;
  Timer? _callTimer;
  
  bool _isInitialized = false;
  bool _showLowCreditsWarning = false;
  bool _showControls = true;
  Timer? _controlsTimer;

  @override
  void initState() {
    super.initState();
    _initializeAgora();
    _startControlsTimer();
  }

  void _startControlsTimer() {
    _controlsTimer?.cancel();
    _controlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _showControls = false);
      }
    });
  }

  void _toggleControlsVisibility() {
    setState(() => _showControls = !_showControls);
    if (_showControls) {
      _startControlsTimer();
    }
  }

  Future<void> _initializeAgora() async {
    // Request permissions
    await [Permission.microphone, Permission.camera].request();

    try {
      // Create Agora engine
      _engine = createAgoraRtcEngine();
      
      await _engine!.initialize(RtcEngineContext(
        appId: AppConfig.agoraAppId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ));

      // Register event handlers
      _engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            debugPrint('[AGORA] Successfully joined channel: ${connection.channelId}');
            setState(() => _isInitialized = true);
            
            // Start call timer and credit deduction
            _startCallTimer();
            _creditsService.startCall(true); // true = video call
            
            // Listen for credit exhaustion
            _creditsService.onCreditsExhausted = _onCreditsExhausted;
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            debugPrint('[AGORA] Remote user joined: $remoteUid');
            setState(() {
              _isRemoteUserJoined = true;
              _remoteUid = remoteUid;
            });
          },
          onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
            debugPrint('[AGORA] Remote user left: $remoteUid, reason: $reason');
            setState(() {
              _isRemoteUserJoined = false;
              _remoteUid = 0;
            });
            _endCall(isRemoteUserLeft: true);
          },
          onError: (ErrorCodeType err, String msg) {
            debugPrint('[AGORA] Error: $err - $msg');
          },
        ),
      );

      // Enable audio and video
      await _engine!.enableAudio();
      await _engine!.enableVideo();
      await _engine!.startPreview();
      
      // Join channel
      await _engine!.joinChannel(
        token: '', // Testing Mode - no token needed
        channelId: widget.channelName,
        uid: 0,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          autoSubscribeAudio: true,
          autoSubscribeVideo: true,
          publishMicrophoneTrack: true,
          publishCameraTrack: true,
        ),
      );
      
      debugPrint('[AGORA] Joining channel: ${widget.channelName}');
      
    } catch (e) {
      debugPrint('[AGORA] Error initializing: $e');
      _showError('Failed to initialize call: $e');
      Navigator.pop(context);
    }
  }

  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _callDuration++);
      
      // Check for low credits warning (less than 100 credits = ~1.25 minutes)
      if (_creditsService.credits.value < 100 && !_showLowCreditsWarning) {
        _showLowCreditsWarning = true;
        _showLowCreditsDialog();
      }
    });
  }

  void _onCreditsExhausted() {
    // Credits ran out - end call
    _showError('Credits exhausted! Call ending...');
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _endCall();
      }
    });
  }

  Future<void> _toggleMute() async {
    setState(() => _isMuted = !_isMuted);
    await _engine?.muteLocalAudioStream(_isMuted);
    debugPrint('[AGORA] Mute: $_isMuted');
  }

  Future<void> _toggleVideo() async {
    setState(() => _isVideoEnabled = !_isVideoEnabled);
    await _engine?.muteLocalVideoStream(!_isVideoEnabled);
    debugPrint('[AGORA] Video: $_isVideoEnabled');
  }

  Future<void> _switchCamera() async {
    setState(() => _isFrontCamera = !_isFrontCamera);
    await _engine?.switchCamera();
    debugPrint('[AGORA] Camera switched to: ${_isFrontCamera ? 'front' : 'back'}');
  }

  Future<void> _endCall({bool isRemoteUserLeft = false}) async {
    _callTimer?.cancel();
    _controlsTimer?.cancel();
    _creditsService.stopCall();
    _creditsService.onCreditsExhausted = null;
    
    if (_engine != null) {
      await _engine!.leaveChannel();
      await _engine!.release();
      _engine = null;
    }
    
    if (mounted) {
      Get.back(result: {
        'duration': _callDuration,
        'creditsUsed': _callDuration * (CreditsService.videoCallRate / 60).round(),
        'isRemoteUserLeft': isRemoteUserLeft,
      });
    }
  }

  void _showLowCreditsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700),
            const SizedBox(width: 12),
            const Text('Low Credits'),
          ],
        ),
        content: const Text(
          'You have less than 100 credits remaining!\n\n'
          'Your call will automatically end when credits run out.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _callTimer?.cancel();
    _controlsTimer?.cancel();
    _creditsService.stopCall();
    _creditsService.onCreditsExhausted = null;
    if (_engine != null) {
      _engine!.leaveChannel();
      _engine!.release();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text('End Call?'),
            content: const Text('Are you sure you want to end this call?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('End Call'),
              ),
            ],
          ),
        );
        if (result == true) {
          await _endCall();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: _toggleControlsVisibility,
          child: Stack(
            children: [
              // Remote video (full screen)
              if (_isRemoteUserJoined)
                SizedBox.expand(
                  child: AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: _engine!,
                      canvas: VideoCanvas(uid: _remoteUid),
                      connection: RtcConnection(channelId: widget.channelName),
                    ),
                  ),
                )
              else
                // Waiting for remote user
                Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF667eea).withOpacity(0.3),
                            border: Border.all(
                              color: const Color(0xFF667eea),
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.user.name[0].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          widget.user.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Calling...',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Local video (small preview at top right)
              if (_isInitialized && _isVideoEnabled)
                Positioned(
                  top: 60,
                  right: 16,
                  child: Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine!,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      ),
                    ),
                  ),
                ),

              // Controls overlay
              if (_showControls)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: const [0.0, 0.2, 0.7, 1.0],
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          // Top bar
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // User name and call duration
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.user.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _isRemoteUserJoined
                                          ? _formatDuration(_callDuration)
                                          : 'Connecting...',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                // Credits display
                                ValueListenableBuilder<int>(
                                  valueListenable: _creditsService.credits,
                                  builder: (context, credits, _) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: credits < 100
                                            ? Colors.red.shade400
                                            : Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.monetization_on,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            credits.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // Bottom controls
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Mute button
                                _buildControlButton(
                                  icon: _isMuted ? Icons.mic_off : Icons.mic,
                                  onPressed: _toggleMute,
                                  isActive: _isMuted,
                                ),
                                
                                // Video toggle button
                                _buildControlButton(
                                  icon: _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                                  onPressed: _toggleVideo,
                                  isActive: !_isVideoEnabled,
                                ),
                                
                                // End call button
                                GestureDetector(
                                  onTap: _endCall,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.call_end,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                ),
                                
                                // Switch camera button
                                _buildControlButton(
                                  icon: Icons.flip_camera_ios,
                                  onPressed: _switchCamera,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white
              : Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive ? const Color(0xFF667eea) : Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
