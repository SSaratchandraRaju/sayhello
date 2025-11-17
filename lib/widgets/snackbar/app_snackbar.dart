import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Custom snackbar system with professional styling
/// Use AppSnackbar.show() methods to display snackbars throughout the app
class AppSnackbar {
  AppSnackbar._();

  /// Show success snackbar
  static void success({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    Get.snackbar(
      title ?? 'Success',
      message,
      backgroundColor: AppColors.success,
      colorText: Colors.white,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 500),
      boxShadows: [
        BoxShadow(
          color: AppColors.success.withOpacity(0.3),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyles.labelLarge(
                color: Colors.white,
                fontWeight: AppTextStyles.bold,
              ),
            )
          : null,
      messageText: Text(
        message,
        style: AppTextStyles.bodyMedium(color: Colors.white),
      ),
      onTap: (_) => onTap?.call(),
    );
  }

  /// Show error snackbar
  static void error({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onTap,
  }) {
    Get.snackbar(
      title ?? 'Error',
      message,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.error_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 500),
      boxShadows: [
        BoxShadow(
          color: AppColors.error.withOpacity(0.3),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyles.labelLarge(
                color: Colors.white,
                fontWeight: AppTextStyles.bold,
              ),
            )
          : null,
      messageText: Text(
        message,
        style: AppTextStyles.bodyMedium(color: Colors.white),
      ),
      onTap: (_) => onTap?.call(),
    );
  }

  /// Show warning snackbar
  static void warning({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    Get.snackbar(
      title ?? 'Warning',
      message,
      backgroundColor: AppColors.warning,
      colorText: Colors.white,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.warning_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 500),
      boxShadows: [
        BoxShadow(
          color: AppColors.warning.withOpacity(0.3),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyles.labelLarge(
                color: Colors.white,
                fontWeight: AppTextStyles.bold,
              ),
            )
          : null,
      messageText: Text(
        message,
        style: AppTextStyles.bodyMedium(color: Colors.white),
      ),
      onTap: (_) => onTap?.call(),
    );
  }

  /// Show info snackbar
  static void info({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    Get.snackbar(
      title ?? 'Info',
      message,
      backgroundColor: AppColors.info,
      colorText: Colors.white,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.info_rounded,
          color: Colors.white,
          size: 24,
        ),
      ),
      shouldIconPulse: false,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 500),
      boxShadows: [
        BoxShadow(
          color: AppColors.info.withOpacity(0.3),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyles.labelLarge(
                color: Colors.white,
                fontWeight: AppTextStyles.bold,
              ),
            )
          : null,
      messageText: Text(
        message,
        style: AppTextStyles.bodyMedium(color: Colors.white),
      ),
      onTap: (_) => onTap?.call(),
    );
  }

  /// Show custom snackbar with custom colors
  static void custom({
    required String message,
    String? title,
    required Color backgroundColor,
    Color textColor = Colors.white,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    Get.snackbar(
      title ?? '',
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: icon != null
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: textColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: textColor,
                size: 24,
              ),
            )
          : null,
      shouldIconPulse: false,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 500),
      boxShadows: [
        BoxShadow(
          color: backgroundColor.withOpacity(0.3),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
      titleText: title != null && title.isNotEmpty
          ? Text(
              title,
              style: AppTextStyles.labelLarge(
                color: textColor,
                fontWeight: AppTextStyles.bold,
              ),
            )
          : null,
      messageText: Text(
        message,
        style: AppTextStyles.bodyMedium(color: textColor),
      ),
      onTap: (_) => onTap?.call(),
    );
  }
}
