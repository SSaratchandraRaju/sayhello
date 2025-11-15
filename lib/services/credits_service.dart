import 'dart:async';
import 'package:flutter/foundation.dart';

class CreditsService {
  CreditsService._internal();
  static final CreditsService _instance = CreditsService._internal();
  factory CreditsService() => _instance;

  // User credits
  final ValueNotifier<int> credits = ValueNotifier<int>(1000);
  
  // Call rates per minute
  static const int voiceCallRate = 40;  // 40 credits per minute
  static const int videoCallRate = 80;  // 80 credits per minute
  
  // Timer for deducting credits during call
  Timer? _deductionTimer;
  bool _isInCall = false;
  
  // Callback when credits run out
  Function()? onCreditsExhausted;

  int get currentCredits => credits.value;

  // Check if user has enough credits for a call
  bool canMakeCall(bool isVideo) {
    final rate = isVideo ? videoCallRate : voiceCallRate;
    return credits.value >= rate;
  }

  // Get remaining call time in seconds
  int getRemainingCallTime(bool isVideo) {
    final rate = isVideo ? videoCallRate : voiceCallRate;
    if (rate == 0) return 0;
    // Credits per minute, convert to seconds
    final minutesRemaining = credits.value / rate;
    return (minutesRemaining * 60).floor();
  }

  // Start deducting credits during a call
  void startCall(bool isVideo) {
    if (_isInCall) return;
    
    _isInCall = true;
    
    final rate = isVideo ? videoCallRate : voiceCallRate;
    
    debugPrint('[CREDITS] Starting ${isVideo ? "video" : "voice"} call');
    debugPrint('[CREDITS] Rate: $rate credits/minute');
    debugPrint('[CREDITS] Current balance: ${credits.value}');
    
    // Deduct credits every second (rate/60 per second)
    final perSecondRate = rate / 60.0;
    
    _deductionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (credits.value > 0) {
        // Deduct fractional credits
        final newCredits = (credits.value - perSecondRate).floor();
        credits.value = newCredits.clamp(0, 999999);
        
        if (credits.value <= 0) {
          debugPrint('[CREDITS] ⚠️  Credits exhausted!');
          stopCall();
          onCreditsExhausted?.call();
        }
      } else {
        debugPrint('[CREDITS] No credits remaining');
        stopCall();
        onCreditsExhausted?.call();
      }
    });
  }

  // Stop deducting credits
  void stopCall() {
    if (!_isInCall) return;
    
    debugPrint('[CREDITS] Ending call');
    debugPrint('[CREDITS] Final balance: ${credits.value}');
    
    _deductionTimer?.cancel();
    _deductionTimer = null;
    _isInCall = false;
  }

  // Manually deduct credits (for testing or other features)
  void deductCredits(int amount) {
    if (amount <= 0) return;
    credits.value = (credits.value - amount).clamp(0, 999999);
    debugPrint('[CREDITS] Deducted $amount credits. New balance: ${credits.value}');
  }

  // Add credits (for purchases or rewards)
  void addCredits(int amount) {
    if (amount <= 0) return;
    credits.value = (credits.value + amount).clamp(0, 999999);
    debugPrint('[CREDITS] Added $amount credits. New balance: ${credits.value}');
  }

  // Reset credits (for testing)
  void resetCredits() {
    credits.value = 1000;
    debugPrint('[CREDITS] Reset to 1000');
  }

  // Get formatted credits string
  String getFormattedCredits() {
    return credits.value.toString();
  }

  // Get call duration estimate
  String getCallDurationEstimate(bool isVideo) {
    final seconds = getRemainingCallTime(isVideo);
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    
    if (minutes > 0) {
      return '$minutes min ${remainingSeconds}s';
    } else {
      return '${remainingSeconds}s';
    }
  }

  void dispose() {
    _deductionTimer?.cancel();
    credits.dispose();
  }
}
