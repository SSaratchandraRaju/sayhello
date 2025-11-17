import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/app_text_styles.dart';
import '../widgets/buttons/app_buttons.dart';
import '../widgets/inputs/app_text_field.dart';
import '../widgets/snackbar/app_snackbar.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _joinRoom() async {
    final userName = _nameController.text.trim();
    if (userName.isEmpty) {
      AppSnackbar.error(
        message: 'Please enter your name to continue',
        title: 'Name Required',
      );
      return;
    }

    setState(() => _isConnecting = true);

    // Simulate connection delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      '/users',
      arguments: {'userName': userName},
    );
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
              Color(0xFF7C3AED), // Purple
              Color(0xFF4F46E5), // Indigo
              Color(0xFF2E1065), // Deep Purple
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated gradient orbs
            ...List.generate(4, (index) {
              return Positioned(
                top: index == 0
                    ? -80
                    : (index == 1
                        ? 150
                        : null),
                bottom: index == 2 || index == 3 ? -100 : null,
                left: index == 1 || index == 3 ? -80 : null,
                right: index == 0 || index == 2 ? -80 : null,
                child: Container(
                  width: index == 3 ? 250 : 350,
                  height: index == 3 ? 250 : 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(index == 3 ? 0.08 : 0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            }),

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Ultra-premium glass morphism card
                          Container(
                            constraints: BoxConstraints(maxWidth: 480),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.28),
                                  Colors.white.withOpacity(0.18),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.45),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 50,
                                  offset: const Offset(0, 25),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                child: Container(
                                  padding: const EdgeInsets.all(44.0),
                                  child: Column(
                                    children: [
                                      // Ultra-Premium Logo with glow
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // Outer glow
                                          Container(
                                            width: 130,
                                            height: 130,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white.withOpacity(0.35),
                                                  blurRadius: 50,
                                                  spreadRadius: 8,
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Logo container
                                          Container(
                                            width: 110,
                                            height: 110,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Colors.white.withOpacity(0.35),
                                                  Colors.white.withOpacity(0.25),
                                                ],
                                              ),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white.withOpacity(0.5),
                                                width: 4,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.2),
                                                  blurRadius: 30,
                                                  offset: const Offset(0, 15),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              Icons.videocam_rounded,
                                              size: 56,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black.withOpacity(0.3),
                                                  blurRadius: 12,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 44),

                                      // Premium Title
                                      Text(
                                        'Welcome',
                                        style: AppTextStyles.display1(
                                          color: Colors.white,
                                          fontWeight: AppTextStyles.bold,
                                        ).copyWith(
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withOpacity(0.3),
                                              blurRadius: 15,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 14),

                                      // Premium Subtitle
                                      Text(
                                        'Enter your details to join the video call',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.bodyLarge(
                                          color: Colors.white.withOpacity(0.95),
                                          fontWeight: AppTextStyles.medium,
                                        ),
                                      ),
                                      const SizedBox(height: 48),

                                      // Premium Name Input Field
                                      AppGlassTextField(
                                        controller: _nameController,
                                        hintText: 'Your Name',
                                        prefixIcon: Icons.badge_rounded,
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (_) => _joinRoom(),
                                      ),
                                      const SizedBox(height: 32),

                                      // Ultra-Premium Join Button
                                      AppPrimaryButton(
                                        text: 'Join Call',
                                        onPressed: _isConnecting ? null : _joinRoom,
                                        isLoading: _isConnecting,
                                        width: double.infinity,
                                        height: 62,
                                        icon: Icons.video_call_rounded,
                                        gradient: const LinearGradient(
                                          colors: [Colors.white, Colors.white],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Premium security badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.15),
                                  Colors.white.withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.35),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.security_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Text(
                                  'Secure • Encrypted • Private',
                                  style: AppTextStyles.bodyMedium(
                                    color: Colors.white.withOpacity(0.95),
                                    fontWeight: AppTextStyles.semiBold,
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
