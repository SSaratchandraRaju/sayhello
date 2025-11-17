import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'services/agora_service.dart';
import 'config/app_config.dart';
import 'config/environment_config.dart';
import 'core/network/api_client.dart';
import 'core/di/dependency_injection.dart';
import 'utils/agora_token_builder.dart';
// screens are imported by the route definitions in `app_pages.dart`

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment configuration
  await EnvironmentConfig.init();
  EnvironmentConfig.printConfig();

  // Initialize API client
  await ApiClient().init();

  // Initialize dependency injection
  await DependencyInjection.init();

  // Wire automatic token generation for Agora
  // This will generate tokens on-the-fly for ANY channel name
  // Perfect for Quick Join and custom channel names!
  AgoraService().tokenProvider = (String channel, int uid) async {
    debugPrint('[TOKEN] Generating token for channel: $channel, UID: $uid');

    // Option 1: If App Certificate is set, generate token locally (BEST for production)
    if (AppConfig.agoraCertificate != null &&
        AppConfig.agoraCertificate!.isNotEmpty) {
      try {
        final token = AgoraTokenBuilder.buildTokenWithUid(
          appId: AppConfig.agoraAppId,
          appCertificate: AppConfig.agoraCertificate!,
          channelName: channel,
          uid: uid,
          role: AgoraTokenBuilder.rolePublisher,
          privilegeExpiredTs:
              (DateTime.now().millisecondsSinceEpoch ~/ 1000) +
              86400, // 24 hours
        );
        debugPrint(
          '[TOKEN] ✅ Generated token locally: ${token.substring(0, 30)}...',
        );
        return token;
      } catch (e) {
        debugPrint('[TOKEN] ❌ Error generating token: $e');
      }
    }

    // Option 2: Try token server if configured
    final url = AppConfig.tokenServerUrl;
    if (url != null && url.isNotEmpty) {
      const int maxAttempts = 3;
      int attempt = 0;
      int backoffMs = 500;

      while (attempt < maxAttempts) {
        attempt++;
        try {
          final uri = Uri.parse(url);
          final headers = <String, String>{
            HttpHeaders.contentTypeHeader: 'application/json',
          };
          if (AppConfig.tokenServerAuthHeaderName != null &&
              AppConfig.tokenServerAuthHeaderValue != null) {
            headers[AppConfig.tokenServerAuthHeaderName!] =
                AppConfig.tokenServerAuthHeaderValue!;
          }

          final resp = await http
              .post(
                uri,
                headers: headers,
                body: jsonEncode({'channel': channel, 'uid': uid}),
              )
              .timeout(const Duration(seconds: 6));

          if (resp.statusCode == 200) {
            final body = jsonDecode(resp.body) as Map<String, dynamic>;
            final token = body['token'] as String?;
            if (token != null && token.isNotEmpty) {
              debugPrint('[TOKEN] ✅ Fetched from server');
              return token;
            }
          } else {
            debugPrint('[TOKEN] Server returned ${resp.statusCode}');
          }
        } catch (e) {
          debugPrint('[TOKEN] Server error (attempt $attempt): $e');
        }

        await Future.delayed(Duration(milliseconds: backoffMs));
        backoffMs *= 2;
      }
    }

    // Option 3: Fall back to temp token (if available)
    if (AppConfig.tempToken != null && AppConfig.tempToken!.isNotEmpty) {
      debugPrint('[TOKEN] ⚠️  Using fallback tempToken');
      return AppConfig.tempToken;
    }

    // No token available - will use empty string (only works if App Certificate is disabled)
    debugPrint(
      '[TOKEN] ⚠️  No token generation method available - using empty token',
    );
    return '';
  };

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Say Hello!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      navigatorKey: navigatorKey,
      initialRoute: Routes.PHONE_LOGIN,
      getPages: AppPages.pages,
    );
  }
}
