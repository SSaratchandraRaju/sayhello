import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles for the entire application
/// Modify these to update text styling across the entire app
class AppTextStyles {
  AppTextStyles._();

  // Base Font Family
  static const String fontFamily = 'SF Pro Display'; // iOS-inspired premium font
  
  // Font Weights - More sophisticated range
  static const FontWeight thin = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // ========== HEADINGS ==========
  
  /// Display 1 - Extra Large Display Text (48-56px)
  static TextStyle display1({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 56,
    fontWeight: fontWeight ?? extraBold,
    color: color,
    letterSpacing: -0.5,
    height: 1.1,
  );

  /// Display 2 - Large Display Text (40-48px)
  static TextStyle display2({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 48,
    fontWeight: fontWeight ?? extraBold,
    color: color,
    letterSpacing: -0.5,
    height: 1.2,
  );

  /// Heading 1 - Page Titles (32-36px)
  static TextStyle h1({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 36,
    fontWeight: fontWeight ?? bold,
    color: color,
    letterSpacing: -0.3,
    height: 1.2,
  );

  /// Heading 2 - Section Titles (28-32px)
  static TextStyle h2({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 32,
    fontWeight: fontWeight ?? bold,
    color: color,
    letterSpacing: -0.2,
    height: 1.25,
  );

  /// Heading 3 - Subsection Titles (24-28px)
  static TextStyle h3({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 28,
    fontWeight: fontWeight ?? semiBold,
    color: color,
    letterSpacing: 0,
    height: 1.3,
  );

  /// Heading 4 - Card Titles (20-24px)
  static TextStyle h4({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 24,
    fontWeight: fontWeight ?? semiBold,
    color: color,
    letterSpacing: 0,
    height: 1.3,
  );

  /// Heading 5 - Small Titles (18-20px)
  static TextStyle h5({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 20,
    fontWeight: fontWeight ?? semiBold,
    color: color,
    letterSpacing: 0.1,
    height: 1.4,
  );

  /// Heading 6 - Tiny Titles (16-18px)
  static TextStyle h6({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 18,
    fontWeight: fontWeight ?? medium,
    color: color,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // ========== BODY TEXT ==========

  /// Body Large - Main Content Text (16-18px)
  static TextStyle bodyLarge({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 18,
    fontWeight: fontWeight ?? regular,
    color: color,
    letterSpacing: 0.2,
    height: 1.6,
  );

  /// Body Medium - Standard Body Text (14-16px)
  static TextStyle bodyMedium({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 16,
    fontWeight: fontWeight ?? regular,
    color: color,
    letterSpacing: 0.15,
    height: 1.5,
  );

  /// Body Small - Secondary Body Text (13-14px)
  static TextStyle bodySmall({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 14,
    fontWeight: fontWeight ?? regular,
    color: color,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // ========== LABELS & CAPTIONS ==========

  /// Label Large - Prominent Labels (14-16px)
  static TextStyle labelLarge({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 16,
    fontWeight: fontWeight ?? medium,
    color: color,
    letterSpacing: 0.5,
    height: 1.4,
  );

  /// Label Medium - Standard Labels (13-14px)
  static TextStyle labelMedium({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 14,
    fontWeight: fontWeight ?? medium,
    color: color,
    letterSpacing: 0.5,
    height: 1.4,
  );

  /// Label Small - Small Labels (12-13px)
  static TextStyle labelSmall({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 13,
    fontWeight: fontWeight ?? medium,
    color: color,
    letterSpacing: 0.5,
    height: 1.4,
  );

  /// Caption Large - Larger Captions (13-14px)
  static TextStyle captionLarge({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 14,
    fontWeight: fontWeight ?? regular,
    color: color,
    letterSpacing: 0.3,
    height: 1.4,
  );

  /// Caption Medium - Standard Captions (12-13px)
  static TextStyle captionMedium({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 13,
    fontWeight: fontWeight ?? regular,
    color: color,
    letterSpacing: 0.3,
    height: 1.4,
  );

  /// Caption Small - Small Helper Text (11-12px)
  static TextStyle captionSmall({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 12,
    fontWeight: fontWeight ?? regular,
    color: color,
    letterSpacing: 0.3,
    height: 1.3,
  );

  // ========== BUTTON TEXT ==========

  /// Button Large - Large Button Text (16-18px)
  static TextStyle buttonLarge({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 18,
    fontWeight: fontWeight ?? semiBold,
    color: color,
    letterSpacing: 0.5,
    height: 1.2,
  );

  /// Button Medium - Standard Button Text (15-16px)
  static TextStyle buttonMedium({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 16,
    fontWeight: fontWeight ?? semiBold,
    color: color,
    letterSpacing: 0.5,
    height: 1.2,
  );

  /// Button Small - Small Button Text (13-14px)
  static TextStyle buttonSmall({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 14,
    fontWeight: fontWeight ?? semiBold,
    color: color,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // ========== OVERLINE TEXT ==========

  /// Overline - Uppercase Labels (10-12px)
  static TextStyle overline({Color? color, FontWeight? fontWeight}) => TextStyle(
    fontSize: 12,
    fontWeight: fontWeight ?? semiBold,
    color: color,
    letterSpacing: 1.5,
    height: 1.2,
  );

  // ========== THEME-AWARE HELPERS ==========

  /// Get text color based on theme brightness
  static Color getTextColor(BuildContext context, {bool secondary = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (secondary) {
      return isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    }
    return isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
  }

  /// Get tertiary text color based on theme brightness
  static Color getTertiaryTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight;
  }
}
