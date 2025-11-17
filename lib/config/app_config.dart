// import 'dart:io'; // Uncomment if using platform-specific URLs

class AppConfig {
  // Agora configuration
  // Get these from: https://console.agora.io
  // NEW PROJECT - Testing Mode (No Certificate Required)
  static const String agoraAppId = '8835dde6db374e02808c2fcbfeb2534a';

  // App Certificate - REQUIRED for automatic token generation
  // To get this: Agora Console → Project → Edit → Enable App Certificate
  // TESTING MODE - No certificate needed for this project
  static const String? agoraCertificate = null;

  static const String tempChannelName = 'sayhello';

  // Fallback token (only used if agoraCertificate is null or token generation fails)
  // Leave as null if using automatic token generation
  // TESTING MODE - No token needed
  static const String? tempToken = null; // Token server URL
  // IMPORTANT: For production, you MUST set up your own token server
  // Set to null to use tempToken instead (for testing only)
  // Your server should accept POST with {"channel": "xxx", "uid": 123}
  // and return JSON: {"token": "007eJx..."}
  static const String? tokenServerUrl =
      null; // Set to null to use tempToken for now

  // Optional authentication for the token server. Leave null to send no auth header.
  // Example: headerName = 'Authorization', headerValue = 'Bearer <API_KEY>'
  static const String? tokenServerAuthHeaderName = null;
  static const String? tokenServerAuthHeaderValue = null;

  // App configuration
  static const String appName = 'Say Hello!';

  static const int serverPort = 3000;
}
