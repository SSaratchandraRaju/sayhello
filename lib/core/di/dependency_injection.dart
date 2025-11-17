import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/wallet_controller.dart';
import '../../controllers/call_controller.dart';
import '../../controllers/user_controller.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/wallet_repository.dart';
import '../../repositories/call_repository.dart';
import '../../repositories/user_repository.dart';
import '../network/api_client.dart';

/// Dependency Injection - Initialize all controllers and dependencies
class DependencyInjection {
  static Future<void> init() async {
    // Initialize API Client (already done in main, but ensure it's available)
    final apiClient = ApiClient();

    // Register Repositories
    Get.lazyPut<AuthRepository>(() => AuthRepository(apiClient: apiClient));
    Get.lazyPut<WalletRepository>(() => WalletRepository(apiClient: apiClient));
    Get.lazyPut<CallRepository>(() => CallRepository(apiClient: apiClient));
    Get.lazyPut<UserRepository>(() => UserRepository(apiClient: apiClient));

    // Register Controllers
    Get.lazyPut<AuthController>(
      () => AuthController(authRepository: Get.find<AuthRepository>()),
    );

    Get.lazyPut<WalletController>(
      () => WalletController(walletRepository: Get.find<WalletRepository>()),
    );

    Get.lazyPut<CallController>(
      () => CallController(callRepository: Get.find<CallRepository>()),
    );

    Get.lazyPut<UserController>(
      () => UserController(userRepository: Get.find<UserRepository>()),
    );
  }

  /// Initialize controllers that need to be loaded immediately
  static void initializeEssentialControllers() {
    // Force instantiation of essential controllers
    Get.find<AuthController>();
  }
}
