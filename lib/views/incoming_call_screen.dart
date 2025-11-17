import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/agora_rtm_service.dart';
import '../services/ringtone_service.dart';
import '../models/user_model.dart';
import 'dart:async';

class IncomingCallScreen extends StatefulWidget {
  final String callerId;
  final String callerName;
  final bool isVideo;
  final String channelName;

  const IncomingCallScreen({
    Key? key,
    required this.callerId,
    required this.callerName,
    required this.isVideo,
    required this.channelName,
  }) : super(key: key);

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen>
    with SingleTickerProviderStateMixin {
  final AgoraRtmService _rtmService = AgoraRtmService();
  final RingtoneService _ringtoneService = RingtoneService();
  late AnimationController _pulseController;
  Timer? _autoDeclineTimer;

  @override
  void initState() {
    super.initState();

    // Start ringtone and vibration
    _ringtoneService.start();

    // Pulse animation for the avatar
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    // Auto-decline after 30 seconds if no response
    _autoDeclineTimer = Timer(const Duration(seconds: 30), () {
      if (mounted) {
        _declineCall();
      }
    });
  }

  @override
  void dispose() {
    // Stop ringtone and vibration
    _ringtoneService.stop();
    _pulseController.dispose();
    _autoDeclineTimer?.cancel();
    super.dispose();
  }

  Future<void> _acceptCall() async {
    _autoDeclineTimer?.cancel();

    // Stop ringtone and vibration
    await _ringtoneService.stop();

    // Play short vibration feedback
    await _ringtoneService.playShortVibration();

    // Send accept signal via RTM
    await _rtmService.sendCallAccepted(
      callerId: widget.callerId,
      channelName: widget.channelName,
    );

    // Navigate to call screen
    if (!mounted) return;

    final routeName = widget.isVideo ? '/video-call' : '/voice-call';

    // Create a UserModel for the caller with minimal info
    final callerUser = UserModel(
      id: widget.callerId,
      name: widget.callerName,
      age: 0, // Unknown for incoming call
      gender: 'unknown',
      location: 'Unknown',
      isOnline: true,
      agoraUid: widget.callerId, // Use same as user ID
    );

    // Close this screen and navigate to call
    Get.back();
    Get.toNamed(
      routeName,
      arguments: {
        'user': callerUser,
        'channelName': widget.channelName,
        'isIncoming': true,
      },
    );
  }

  Future<void> _declineCall() async {
    _autoDeclineTimer?.cancel();

    // Stop ringtone and vibration
    await _ringtoneService.stop();

    // Play short vibration feedback
    await _ringtoneService.playShortVibration();

    // Send decline signal via RTM
    await _rtmService.sendCallDeclined(callerId: widget.callerId);

    // Close this screen
    if (mounted) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back button - must explicitly decline
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
              colors: widget.isVideo
                  ? [const Color(0xFF667eea), const Color(0xFF764ba2)]
                  : [Colors.green.shade700, Colors.green.shade900],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Incoming ${widget.isVideo ? 'Video' : 'Voice'} Call',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),

                const Spacer(),

                // Caller Avatar with pulse animation
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 160 + (_pulseController.value * 20),
                      height: 160 + (_pulseController.value * 20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.2),
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: Center(
                            child: Text(
                              widget.callerName[0].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Caller Name
                Text(
                  widget.callerName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                // Ringing text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.isVideo ? Icons.videocam : Icons.phone,
                      color: Colors.white.withOpacity(0.9),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'is calling you...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Decline Button
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _declineCall,
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
                          const SizedBox(height: 12),
                          Text(
                            'Decline',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      // Accept Button
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _acceptCall,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                widget.isVideo ? Icons.videocam : Icons.phone,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Accept',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
}
