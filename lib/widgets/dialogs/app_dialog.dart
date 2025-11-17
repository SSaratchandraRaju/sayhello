import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Custom dialog system with ultra-premium glassmorphism styling
class AppDialog {
  AppDialog._();

  /// Show alert dialog
  static Future<void> alert({
    required String message,
    String? title,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
    IconData? icon,
    Color? iconColor,
  }) async {
    return Get.dialog(
      _BaseDialog(
        title: title ?? 'Alert',
        message: message,
        icon: icon ?? Icons.info_rounded,
        iconColor: iconColor ?? AppColors.info,
        confirmText: confirmText,
        onConfirm: onConfirm,
      ),
      barrierDismissible: false,
    );
  }

  /// Show elegant charge confirmation dialog (NO HARSH RED!)
  static Future<bool> chargeConfirm({
    required String title,
    required String message,
    required String amount,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) async {
    bool? result = await Get.dialog<bool>(
      _ChargeDialog(
        title: title,
        message: message,
        amount: amount,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
      barrierDismissible: false,
    );
    return result ?? false;
  }

  /// Show confirmation dialog with Yes/No options
  static Future<bool> confirm({
    required String message,
    String? title,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    IconData? icon,
    Color? iconColor,
  }) async {
    bool? result = await Get.dialog<bool>(
      _ConfirmDialog(
        title: title ?? 'Confirm',
        message: message,
        icon: icon ?? Icons.help_rounded,
        iconColor: iconColor ?? AppColors.warning,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
      barrierDismissible: false,
    );
    return result ?? false;
  }

  /// Show success dialog
  static Future<void> success({
    required String message,
    String? title,
    String confirmText = 'Great!',
    VoidCallback? onConfirm,
  }) async {
    return alert(
      message: message,
      title: title ?? 'Success',
      confirmText: confirmText,
      onConfirm: onConfirm,
      icon: Icons.check_circle_rounded,
      iconColor: AppColors.success,
    );
  }

  /// Show error dialog
  static Future<void> error({
    required String message,
    String? title,
    String confirmText = 'Got it',
    VoidCallback? onConfirm,
  }) async {
    return alert(
      message: message,
      title: title ?? 'Error',
      confirmText: confirmText,
      onConfirm: onConfirm,
      icon: Icons.error_rounded,
      iconColor: AppColors.error,
    );
  }

  /// Show custom dialog
  static Future<T?> custom<T>({
    required Widget child,
    bool barrierDismissible = true,
  }) async {
    return Get.dialog<T>(
      child,
      barrierDismissible: barrierDismissible,
    );
  }
}

/// Base dialog widget with glassmorphism effect
class _BaseDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final String confirmText;
  final VoidCallback? onConfirm;

  const _BaseDialog({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.confirmText,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.cardDark.withOpacity(0.95)
              : AppColors.cardLight.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? AppColors.borderDark.withOpacity(0.5)
                : AppColors.borderLight.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 36,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  Text(
                    title,
                    style: AppTextStyles.h4(
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Message
                  Text(
                    message,
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onConfirm?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: iconColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        confirmText,
                        style: AppTextStyles.buttonMedium(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Confirmation dialog with two buttons
class _ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const _ConfirmDialog({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.confirmText,
    required this.cancelText,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.cardDark.withOpacity(0.95)
              : AppColors.cardLight.withOpacity(0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? AppColors.borderDark.withOpacity(0.5)
                : AppColors.borderLight.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 36,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  Text(
                    title,
                    style: AppTextStyles.h4(
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Message
                  Text(
                    message,
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Buttons
                  Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: OutlinedButton(
                            onPressed: () {
                              Get.back(result: false);
                              onCancel?.call();
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              side: BorderSide(
                                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              cancelText,
                              style: AppTextStyles.buttonMedium(
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Confirm Button
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back(result: true);
                              onConfirm?.call();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: iconColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              confirmText,
                              style: AppTextStyles.buttonMedium(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Elegant charge confirmation dialog with premium gold styling
class _ChargeDialog extends StatelessWidget {
  final String title;
  final String message;
  final String amount;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const _ChargeDialog({
    required this.title,
    required this.message,
    required this.amount,
    required this.confirmText,
    required this.cancelText,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark
                  ? AppColors.cardDark.withOpacity(0.98)
                  : AppColors.cardLight.withOpacity(0.98),
              isDark
                  ? AppColors.cardElevatedDark.withOpacity(0.95)
                  : AppColors.cardElevatedLight.withOpacity(0.95),
            ],
          ),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isDark
                ? AppColors.borderDark.withOpacity(0.6)
                : AppColors.borderLight.withOpacity(0.6),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowXL,
              blurRadius: 50,
              offset: const Offset(0, 25),
            ),
            BoxShadow(
              color: AppColors.accentGold.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Elegant icon with gold accent
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGold.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Title
                  Text(
                    title,
                    style: AppTextStyles.h3(
                      color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      fontWeight: AppTextStyles.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Message
                  Text(
                    message,
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),

                  // Elegant charge amount display
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accentGold.withOpacity(0.15),
                          AppColors.accentAmber.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.accentGold.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGold.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.diamond_rounded,
                          color: AppColors.accentGold,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          amount,
                          style: AppTextStyles.h2(
                            color: AppColors.accentGold,
                            fontWeight: AppTextStyles.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'credits',
                          style: AppTextStyles.labelLarge(
                            color: AppColors.cost,
                            fontWeight: AppTextStyles.medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Buttons
                  Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: SizedBox(
                          height: 58,
                          child: OutlinedButton(
                            onPressed: () {
                              Get.back(result: false);
                              onCancel?.call();
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                              side: BorderSide(
                                color: isDark ? AppColors.borderDark : AppColors.borderLight,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Text(
                              cancelText,
                              style: AppTextStyles.buttonMedium(
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                fontWeight: AppTextStyles.semiBold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Confirm Button with gold gradient
                      Expanded(
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                            gradient: AppColors.goldGradient,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentGold.withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back(result: true);
                              onConfirm?.call();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Text(
                              confirmText,
                              style: AppTextStyles.buttonMedium(
                                color: Colors.white,
                                fontWeight: AppTextStyles.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
