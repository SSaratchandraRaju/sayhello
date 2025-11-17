import 'package:flutter/material.dart';

/// Centralized color palette for the entire application
/// Change colors here to update them across the entire app
class AppColors {
  AppColors._();

  // Primary Brand Colors - Ultra Premium Gradient Palette
  static const Color primaryStart = Color(0xFF5B4CDB); // Deep Royal Purple
  static const Color primaryMid = Color(0xFF7C6FE8);
  static const Color primaryEnd = Color(0xFF9D8FF5); // Soft Lavender
  
  static const Color secondaryStart = Color(0xFF4F46E5); // Indigo
  static const Color secondaryMid = Color(0xFF7C3AED); // Purple
  static const Color secondaryEnd = Color(0xFFA855F7); // Pink Purple

  // Accent Colors - Luxury & Sophisticated
  static const Color accentGold = Color(0xFFF59E0B); // Amber Gold
  static const Color accentRoseGold = Color(0xFFE8B4B8); // Rose Gold
  static const Color accentTeal = Color(0xFF14B8A6); // Teal
  static const Color accentEmerald = Color(0xFF10B981); // Emerald
  static const Color accentAmber = Color(0xFFFBBF24); // Bright Amber

  // Background Colors - Sophisticated
  static const Color backgroundLight = Color(0xFFFAFAFC); // Soft White
  static const Color backgroundDark = Color(0xFF0A0A12); // Deep Navy Black
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1C1C2E); // Rich Dark Purple

  // Card & Surface Colors - Premium
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF252540); // Deep Purple Gray
  static const Color cardElevatedLight = Color(0xFFFFFFFF);
  static const Color cardElevatedDark = Color(0xFF2E2E4D); // Elevated Dark Purple

  // Text Colors - High Contrast & Sophisticated
  static const Color textPrimaryLight = Color(0xFF0F0F1E); // Almost Black
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textTertiaryLight = Color(0xFF9CA3AF);
  static const Color textPrimaryDark = Color(0xFFFAFAFC); // Soft White
  static const Color textSecondaryDark = Color(0xFFD1D5DB);
  static const Color textTertiaryDark = Color(0xFF9CA3AF);

  // Status Colors - Elegant & Sophisticated (NO harsh reds!)
  static const Color success = Color(0xFF10B981); // Emerald
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF065F46);
  
  static const Color warning = Color(0xFFF59E0B); // Warm Amber
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFF92400E);
  
  static const Color info = Color(0xFF6366F1); // Soft Indigo
  static const Color infoLight = Color(0xFFE0E7FF);
  static const Color infoDark = Color(0xFF4338CA);
  
  // For charges/costs - use elegant gold instead of harsh red
  static const Color cost = Color(0xFFF59E0B); // Amber Gold
  static const Color costLight = Color(0xFFFEF3C7);
  static const Color costDark = Color(0xFFB45309);
  
  // For errors - use softer coral instead of harsh red
  static const Color error = Color(0xFFFF6B6B); // Soft Coral
  static const Color errorLight = Color(0xFFFFE5E5);
  static const Color errorDark = Color(0xFFCC5555);

  // Call Colors - Premium
  static const Color videoCallGradientStart = Color(0xFF5B4CDB);
  static const Color videoCallGradientEnd = Color(0xFF9D8FF5);
  static const Color voiceCallGradientStart = Color(0xFF10B981);
  static const Color voiceCallGradientEnd = Color(0xFF14B8A6);

  // Glassmorphism Colors - Enhanced
  static Color glassLight = Colors.white.withOpacity(0.20); // More opacity
  static Color glassDark = Colors.white.withOpacity(0.12);
  static Color glassBorder = Colors.white.withOpacity(0.35); // More visible
  static Color glassBackground = Colors.white.withOpacity(0.08);
  
  // Overlay Colors - Sophisticated
  static Color overlayLight = Colors.black.withOpacity(0.25);
  static Color overlayDark = Colors.black.withOpacity(0.65);
  static Color shimmerBase = const Color(0xFFE8EAED);
  static Color shimmerHighlight = const Color(0xFFF5F6F8);

  // Border Colors - Refined
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF3F3F5E);

  // Shadow Colors - Premium Depth
  static Color shadowLight = Colors.black.withOpacity(0.06);
  static Color shadowMedium = Colors.black.withOpacity(0.10);
  static Color shadowHeavy = Colors.black.withOpacity(0.20);
  static Color shadowXL = Colors.black.withOpacity(0.30);

  // Gradient Definitions - Ultra Premium
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryStart, primaryMid, primaryEnd],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryStart, secondaryMid, secondaryEnd],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient videoCallGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [videoCallGradientStart, videoCallGradientEnd],
  );

  static const LinearGradient voiceCallGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [voiceCallGradientStart, voiceCallGradientEnd],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  );

  // NEW: Elegant cost gradient (replaces harsh error red)
  static const LinearGradient costGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
  );
  
  // NEW: Sophisticated overlay gradients
  static LinearGradient get glassGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.25),
      Colors.white.withOpacity(0.15),
    ],
  );
}
