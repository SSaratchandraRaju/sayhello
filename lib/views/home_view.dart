import 'package:flutter/material.dart';
import 'dart:ui';
import '../services/agora_service.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/inputs/app_text_field.dart';
import '../widgets/snackbar/app_snackbar.dart';
import 'call_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  final _agora = AgoraService();
  final TextEditingController _channelController = TextEditingController();
  late AnimationController _animationController;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  String? _currentUserName;
  bool _isJoining = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      _currentUserName = args['userName'] as String?;
    }
  }

  @override
  void dispose() {
    _channelController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _joinChannel() async {
    final channelName = _channelController.text.trim();
    if (channelName.isEmpty) {
      AppSnackbar.error(
        message: 'Please enter a channel name',
        title: 'Channel Required',
      );
      return;
    }

    setState(() => _isJoining = true);

    try {
      // Defer Agora initialization until the Call screen has been pushed.
      // This avoids heavy native/plugin init during the Flutter tool attach.
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CallView(
            channelName: channelName,
            agoraService: _agora,
            userName: _currentUserName,
          ),
        ),
      );
      // The CallView will initialize and join the channel shortly after it's shown.
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.error(
        message: 'Failed to join: $e',
        title: 'Join Failed',
      );
    } finally {
      if (mounted) setState(() => _isJoining = false);
    }
  }

  void _createQuickChannel() {
    final quickChannel =
        'room-${DateTime.now().millisecondsSinceEpoch % 10000}';
    _channelController.text = quickChannel;
    _joinChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4F46E5), // Deep Indigo
              Color(0xFF7C3AED), // Purple
              Color(0xFF9D8FF5), // Lavender
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated gradient orbs
            ...List.generate(3, (index) {
              return Positioned(
                top: index == 0 ? -100 : (index == 1 ? 200 : null),
                bottom: index == 2 ? -50 : null,
                left: index == 1 ? -50 : null,
                right: index == 0 || index == 2 ? -50 : null,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            }),
            
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation ?? AlwaysStoppedAnimation<double>(1.0),
                child: SlideTransition(
                  position:
                      _slideAnimation ??
                      AlwaysStoppedAnimation<Offset>(Offset.zero),
                  child: Column(
                    children: [
                      // Premium App Bar
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 24, 32, 0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: AppColors.glassGradient,
                                borderRadius: BorderRadius.circular(16),
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
                              child: Icon(
                                Icons.video_library_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Join Channel',
                              style: AppTextStyles.h2(
                                color: Colors.white,
                                fontWeight: AppTextStyles.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                
                                // Ultra-premium User Info Card
                                Container(
                                  constraints: BoxConstraints(maxWidth: 480),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.25),
                                        Colors.white.withOpacity(0.15),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.4),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 40,
                                        offset: const Offset(0, 20),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(28),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 15,
                                        sigmaY: 15,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(28.0),
                                        child: Row(
                                          children: [
                                            // Premium Avatar
                                            Container(
                                              width: 72,
                                              height: 72,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white.withOpacity(0.3),
                                                    Colors.white.withOpacity(0.2),
                                                  ],
                                                ),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white.withOpacity(0.5),
                                                  width: 3,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.2),
                                                    blurRadius: 15,
                                                    offset: const Offset(0, 8),
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  (_currentUserName?.isNotEmpty ?? false)
                                                      ? _currentUserName![0].toUpperCase()
                                                      : 'U',
                                                  style: AppTextStyles.h2(
                                                    color: Colors.white,
                                                    fontWeight: AppTextStyles.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            // User Info
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _currentUserName ?? 'User',
                                                    style: AppTextStyles.h4(
                                                      color: Colors.white,
                                                      fontWeight: AppTextStyles.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 12,
                                                        height: 12,
                                                        decoration: BoxDecoration(
                                                          color: AppColors.success,
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: AppColors.success
                                                                  .withOpacity(0.6),
                                                              blurRadius: 12,
                                                              spreadRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        'Online',
                                                        style: AppTextStyles.bodyMedium(
                                                          color: Colors.white.withOpacity(0.95),
                                                          fontWeight: AppTextStyles.medium,
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
                                ),

                                const SizedBox(height: 36),

                                // Ultra-premium Channel Input Card
                                Container(
                                  constraints: BoxConstraints(maxWidth: 480),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.25),
                                        Colors.white.withOpacity(0.15),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.4),
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 40,
                                        offset: const Offset(0, 20),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(28),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 15,
                                        sigmaY: 15,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(36.0),
                                        child: Column(
                                          children: [
                                            // Title with icon
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.meeting_room_rounded,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                                const SizedBox(width: 12),
                                                Text(
                                                  'Enter Channel',
                                                  style: AppTextStyles.h3(
                                                    color: Colors.white,
                                                    fontWeight: AppTextStyles.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              'Join an existing room or create a new one',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.bodyMedium(
                                                color: Colors.white.withOpacity(0.9),
                                                fontWeight: AppTextStyles.medium,
                                              ),
                                            ),
                                            const SizedBox(height: 36),

                                            // Premium Channel Input
                                            AppGlassTextField(
                                              controller: _channelController,
                                              hintText: 'Channel Name',
                                              prefixIcon: Icons.tag_rounded,
                                              textInputAction: TextInputAction.done,
                                              onSubmitted: (_) => _joinChannel(),
                                            ),

                                            const SizedBox(height: 24),

                                            // Premium Join Button
                                            AppPrimaryButton(
                                              text: 'Join Channel',
                                              onPressed: _isJoining ? null : _joinChannel,
                                              isLoading: _isJoining,
                                              icon: Icons.video_call_rounded,
                                              width: double.infinity,
                                              height: 60,
                                              gradient: const LinearGradient(
                                                colors: [Colors.white, Colors.white],
                                              ),
                                            ),

                                            const SizedBox(height: 24),

                                            // Elegant Divider
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 1.5,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.white.withOpacity(0.4),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: Text(
                                                    'OR',
                                                    style: AppTextStyles.labelMedium(
                                                      color: Colors.white.withOpacity(0.8),
                                                      fontWeight: AppTextStyles.bold,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 1.5,
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.white.withOpacity(0.4),
                                                          Colors.transparent,
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 24),

                                            // Premium Quick Join Button
                                            AppOutlinedButton(
                                              text: 'Quick Join',
                                              onPressed: _isJoining ? null : _createQuickChannel,
                                              icon: Icons.bolt_rounded,
                                              width: double.infinity,
                                              height: 60,
                                              borderColor: Colors.white.withOpacity(0.6),
                                              textColor: Colors.white,
                                              borderWidth: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 28),

                                // Premium Info Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.share_rounded,
                                        color: Colors.white.withOpacity(0.9),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Share the channel name with others to join',
                                        style: AppTextStyles.captionLarge(
                                          color: Colors.white.withOpacity(0.9),
                                          fontWeight: AppTextStyles.medium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
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
    );
  }
}
