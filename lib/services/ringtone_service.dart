import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

/// Service to manage ringtone and vibration for incoming calls
///
/// Features:
/// - Plays notification sound in loop
/// - Uses Flutter's built-in haptic feedback
/// - Auto-stops after timeout
/// - Handles cleanup properly
class RingtoneService {
  // Singleton pattern
  RingtoneService._internal();
  static final RingtoneService _instance = RingtoneService._internal();
  factory RingtoneService() => _instance;

  // State
  bool _isPlaying = false;
  Timer? _hapticTimer;
  Timer? _autoStopTimer;
  AudioPlayer? _audioPlayer;

  // Haptic feedback interval (vibrate every 1.5 seconds)
  static const Duration _hapticInterval = Duration(milliseconds: 1500);

  // Auto-stop after 30 seconds (matches call timeout)
  static const Duration _autoStopDuration = Duration(seconds: 30);

  /// Start playing ringtone and vibration
  Future<void> start() async {
    if (_isPlaying) {
      debugPrint('[RINGTONE] ⚠️ Already playing');
      return;
    }

    try {
      debugPrint('[RINGTONE] 🔔 Starting ringtone and haptic feedback');
      _isPlaying = true;

      // Start notification sound
      await _startSound();

      // Start haptic feedback
      _startHapticFeedback();

      // Auto-stop after timeout
      _autoStopTimer = Timer(_autoStopDuration, () {
        debugPrint('[RINGTONE] ⏱️ Auto-stop timeout reached');
        stop();
      });

      debugPrint('[RINGTONE] ✅ Started successfully');
    } catch (e) {
      debugPrint('[RINGTONE] ❌ Error starting: $e');
      _isPlaying = false;
    }
  }

  /// Start playing notification sound
  Future<void> _startSound() async {
    try {
      _audioPlayer = AudioPlayer();
      _audioPlayer!.setReleaseMode(ReleaseMode.loop); // Loop the sound
      _audioPlayer!.setVolume(1.0); // Max volume

      // Play system notification sound using SystemSound (cross-platform)
      try {
        // Set up a timer to repeat the system sound
        Timer.periodic(const Duration(seconds: 2), (timer) {
          if (!_isPlaying) {
            timer.cancel();
            return;
          }
          SystemSound.play(SystemSoundType.alert);
        });

        // Play immediately
        SystemSound.play(SystemSoundType.alert);

        debugPrint('[RINGTONE] 🔊 Sound started');
      } catch (e) {
        debugPrint('[RINGTONE] ⚠️ System sound error: $e');
      }
    } catch (e) {
      debugPrint('[RINGTONE] ❌ Error starting sound: $e');
    }
  }

  /// Start haptic feedback pattern using Flutter's built-in HapticFeedback
  void _startHapticFeedback() {
    try {
      // Provide immediate haptic feedback
      HapticFeedback.heavyImpact();

      // Set up periodic haptic feedback
      _hapticTimer = Timer.periodic(_hapticInterval, (timer) {
        if (!_isPlaying) {
          timer.cancel();
          return;
        }

        try {
          // Use heavy impact for incoming calls (strong vibration)
          HapticFeedback.heavyImpact();
        } catch (e) {
          debugPrint('[RINGTONE] ⚠️ Haptic feedback error: $e');
        }
      });

      debugPrint('[RINGTONE] 📳 Haptic feedback started');
    } catch (e) {
      debugPrint('[RINGTONE] ❌ Error starting haptic feedback: $e');
    }
  }

  /// Stop playing ringtone and haptic feedback
  Future<void> stop() async {
    if (!_isPlaying) {
      return;
    }

    try {
      debugPrint('[RINGTONE] 🛑 Stopping ringtone and haptic feedback');
      _isPlaying = false;

      // Stop sound
      await _stopSound();

      // Stop haptic feedback
      _stopHapticFeedback();

      // Cancel timers
      _hapticTimer?.cancel();
      _hapticTimer = null;
      _autoStopTimer?.cancel();
      _autoStopTimer = null;

      debugPrint('[RINGTONE] ✅ Stopped successfully');
    } catch (e) {
      debugPrint('[RINGTONE] ❌ Error stopping: $e');
    }
  }

  /// Stop sound
  Future<void> _stopSound() async {
    try {
      await _audioPlayer?.stop();
      await _audioPlayer?.dispose();
      _audioPlayer = null;
      debugPrint('[RINGTONE] 🔇 Sound stopped');
    } catch (e) {
      debugPrint('[RINGTONE] ⚠️ Error stopping sound: $e');
    }
  }

  /// Stop haptic feedback
  void _stopHapticFeedback() {
    try {
      _hapticTimer?.cancel();
      _hapticTimer = null;
      debugPrint('[RINGTONE] 🚫 Haptic feedback stopped');
    } catch (e) {
      debugPrint('[RINGTONE] ⚠️ Error stopping haptic feedback: $e');
    }
  }

  /// Check if currently playing
  bool get isPlaying => _isPlaying;

  /// Play a short haptic feedback (for button feedback)
  Future<void> playShortVibration() async {
    try {
      await HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('[RINGTONE] ⚠️ Short haptic feedback error: $e');
    }
  }

  /// Cleanup all resources
  Future<void> dispose() async {
    await stop();
    debugPrint('[RINGTONE] 🧹 Disposed');
  }
}
