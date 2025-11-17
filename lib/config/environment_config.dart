import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration class to manage all environment variables
class EnvironmentConfig {
  // Private constructor to prevent instantiation
  EnvironmentConfig._();

  /// Initialize environment configuration
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  /// Get base URL for API
  static String get apiBaseUrl {
    return dotenv.get('API_BASE_URL', fallback: 'https://api.sayhello.com');
  }

  /// Get API version
  static String get apiVersion {
    return dotenv.get('API_VERSION', fallback: '/api');
  }

  /// Get full API URL
  static String get apiUrl => '$apiBaseUrl$apiVersion';

  /// Get API timeout in seconds
  static int get apiTimeout {
    return int.tryParse(dotenv.get('API_TIMEOUT', fallback: '30')) ?? 30;
  }

  /// Get debug mode status
  static bool get isDebugMode {
    return dotenv.get('DEBUG_MODE', fallback: 'true').toLowerCase() == 'true';
  }

  /// Get environment name
  static String get environment {
    return dotenv.get('ENVIRONMENT', fallback: 'development');
  }

  /// Check if running in production
  static bool get isProduction => environment == 'production';

  /// Check if running in development
  static bool get isDevelopment => environment == 'development';

  /// Get Agora App ID (optional, can be fetched from backend)
  static String? get agoraAppId {
    return dotenv.maybeGet('AGORA_APP_ID');
  }

  /// Print configuration (for debugging)
  static void printConfig() {
    if (isDebugMode) {
      print('=== Environment Configuration ===');
      print('API Base URL: $apiBaseUrl');
      print('API Version: $apiVersion');
      print('Full API URL: $apiUrl');
      print('API Timeout: ${apiTimeout}s');
      print('Environment: $environment');
      print('Debug Mode: $isDebugMode');
      print('================================');
    }
  }
}
