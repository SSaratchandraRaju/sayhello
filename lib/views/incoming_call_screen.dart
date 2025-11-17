import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/agora_rtm_service.dart';
import '../services/ringtone_service.dart';
import '../models/user_model.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
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
            gradient: widget.isVideo
                ? AppColors.videoCallGradient
                : AppColors.voiceCallGradient,
          ),
          child: Stack(
            children: [
              // Animated background particles effect
              ...List.generate(20, (index) {
                return Positioned(
                  top: (index * 50.0) % MediaQuery.of(context).size.height,
                  left: (index * 80.0) % MediaQuery.of(context).size.width,
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: 0.1 + (_pulseController.value * 0.05),
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              
              SafeArea(
                child: Column(
                  children: [
                    // Enhanced Header with blur
                    Container(
                      margin: const EdgeInsets.all(24),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            widget.isVideo ? Icons.videocam_rounded : Icons.phone,
                            color: Colors.white,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Incoming ${widget.isVideo ? 'Video' : 'Voice'} Call',
                            style: AppTextStyles.h6(
                              color: Colors.white,
                              fontWeight: AppTextStyles.semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Premium Caller Avatar with enhanced pulse animation
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer glow ring
                            Container(
                              width: 220 + (_pulseController.value * 40),
                              height: 220 + (_pulseController.value * 40),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.0),
                                    Colors.white.withOpacity(0.1),
                                    Colors.white.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                            // Middle ring
                            Container(
                              width: 200 + (_pulseController.value * 30),
                              height: 200 + (_pulseController.value * 30),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.08),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.2),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                            ),
                            // Avatar container
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(0.3),
                                    Colors.white.withOpacity(0.2),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  widget.callerName[0].toUpperCase(),
                                  style: AppTextStyles.display1(
                                    color: Colors.white,
                                    fontWeight: AppTextStyles.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 48),

                    // Enhanced Caller Name with shadow
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        children: [
                          Text(
                            widget.callerName,
                            style: AppTextStyles.display2(
                              color: Colors.white,
                              fontWeight: AppTextStyles.bold,
                            ).copyWith(
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Premium ringing indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'is calling you...',
                            style: AppTextStyles.bodyLarge(
                              color: Colors.white,
                              fontWeight: AppTextStyles.semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Premium Action Buttons
                    Padding(
                      padding: const EdgeInsets.fromLTRB(48, 0, 48, 48),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Decline Button - Elegant coral, not harsh red
                          _PremiumCallButton(
                            icon: Icons.call_end_rounded,
                            onPressed: _declineCall,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.error,
                                AppColors.error.withOpacity(0.8),
                              ],
                            ),
                            label: 'Decline',
                            size: 80,
                          ),

                          // Accept Button - Success gradient
                          _PremiumCallButton(
                            icon: widget.isVideo
                                ? Icons.videocam_rounded
                                : Icons.phone_rounded,
                            onPressed: _acceptCall,
                            gradient: AppColors.successGradient,
                            label: 'Accept',
                            size: 80,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Ultra-premium call button with gradient and animations
class _PremiumCallButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Gradient gradient;
  final String label;
  final double size;

  const _PremiumCallButton({
    required this.icon,
    this.onPressed,
    required this.gradient,
    required this.label,
    required this.size,
  });

  @override
  State<_PremiumCallButton> createState() => _PremiumCallButtonState();
}

class _PremiumCallButtonState extends State<_PremiumCallButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 1.0 - (_controller.value * 0.1);
          return Transform.scale(
            scale: scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    gradient: widget.gradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: -5,
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                    size: widget.size * 0.45,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.label,
                  style: AppTextStyles.labelLarge(
                    color: Colors.white,
                    fontWeight: AppTextStyles.bold,
                  ).copyWith(
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
