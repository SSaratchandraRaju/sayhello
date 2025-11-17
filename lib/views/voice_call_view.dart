import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/user_model.dart';
import '../services/credits_service.dart';
import '../config/app_config.dart';
import 'dart:async';

class VoiceCallView extends StatefulWidget {
  final UserModel user;
  final String channelName;

  const VoiceCallView({Key? key, required this.user, required this.channelName})
    : super(key: key);

  @override
  State<VoiceCallView> createState() => _VoiceCallViewState();
}

class _VoiceCallViewState extends State<VoiceCallView> {
  RtcEngine? _engine;
  final CreditsService _creditsService = CreditsService();

  bool _isMuted = false;
  bool _isSpeakerOn = true;
  bool _isRemoteUserJoined = false;

  int _callDuration = 0;
  Timer? _callTimer;

  bool _isInitialized = false;
  bool _showLowCreditsWarning = false;

  @override
  void initState() {
    super.initState();
    _initializeAgora();
  }

  Future<void> _initializeAgora() async {
    // Request microphone permission
    await Permission.microphone.request();

    try {
      // Create Agora engine
      _engine = createAgoraRtcEngine();

      await _engine!.initialize(
        RtcEngineContext(
          appId: AppConfig.agoraAppId,
          channelProfile: ChannelProfileType.channelProfileCommunication,
        ),
      );

      // Register event handlers
      _engine!.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            debugPrint(
              '[AGORA] Successfully joined channel: ${connection.channelId}',
            );
            setState(() => _isInitialized = true);

            // Start call timer and credit deduction
            _startCallTimer();
            _creditsService.startCall(false); // false = voice call

            // Listen for credit exhaustion
            _creditsService.onCreditsExhausted = _onCreditsExhausted;
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            debugPrint('[AGORA] Remote user joined: $remoteUid');
            setState(() {
              _isRemoteUserJoined = true;
            });
          },
          onUserOffline:
              (
                RtcConnection connection,
                int remoteUid,
                UserOfflineReasonType reason,
              ) {
                debugPrint(
                  '[AGORA] Remote user left: $remoteUid, reason: $reason',
                );
                setState(() {
                  _isRemoteUserJoined = false;
                });
                _endCall(isRemoteUserLeft: true);
              },
          onError: (ErrorCodeType err, String msg) {
            debugPrint('[AGORA] Error: $err - $msg');
          },
        ),
      );

      // Enable audio
      await _engine!.enableAudio();
      await _engine!.setDefaultAudioRouteToSpeakerphone(true);

      // Join channel
      await _engine!.joinChannel(
        token: '', // Testing Mode - no token needed
        channelId: widget.channelName,
        uid: 0,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          autoSubscribeAudio: true,
          publishMicrophoneTrack: true,
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

      // Check for low credits warning (less than 100 credits = ~2.5 minutes)
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

  Future<void> _toggleSpeaker() async {
    setState(() => _isSpeakerOn = !_isSpeakerOn);
    await _engine?.setEnableSpeakerphone(_isSpeakerOn);
    debugPrint('[AGORA] Speaker: $_isSpeakerOn');
  }

  Future<void> _endCall({bool isRemoteUserLeft = false}) async {
    _callTimer?.cancel();
    _creditsService.stopCall();
    _creditsService.onCreditsExhausted = null;

    if (_engine != null) {
      await _engine!.leaveChannel();
      await _engine!.release();
      _engine = null;
    }

    if (mounted) {
      Get.back(
        result: {
          'duration': _callDuration,
          'creditsUsed':
              _callDuration * (CreditsService.voiceCallRate / 60).round(),
          'isRemoteUserLeft': isRemoteUserLeft,
        },
      );
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
        content: Text(
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
        // Show confirmation before leaving
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green.shade700, Colors.green.shade900],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header with credits
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: const Text('End Call?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text('End'),
                                ),
                              ],
                            ),
                          );
                          if (result == true) {
                            _endCall();
                          }
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: _creditsService.credits,
                        builder: (context, credits, _) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
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
                                Icon(
                                  Icons.monetization_on,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  credits.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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

                // User info and call status
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile picture
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 4,
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

                      const SizedBox(height: 32),

                      // User name
                      Text(
                        widget.user.name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Call status
                      Text(
                        _isRemoteUserJoined
                            ? _formatDuration(_callDuration)
                            : 'Calling...',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),

                      if (!_isRemoteUserJoined && _isInitialized)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Call controls
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Mute button
                      _buildControlButton(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        label: _isMuted ? 'Unmute' : 'Mute',
                        onPressed: _toggleMute,
                        isActive: _isMuted,
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

                      // Speaker button
                      _buildControlButton(
                        icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                        label: _isSpeakerOn ? 'Speaker' : 'Earpiece',
                        onPressed: _toggleSpeaker,
                        isActive: _isSpeakerOn,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isActive = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.green.shade700 : Colors.white,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
        ),
      ],
    );
  }
}
