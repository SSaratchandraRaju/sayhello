import 'package:get/get.dart';
import 'app_routes.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../views/call_view.dart';
import '../services/agora_service.dart';

class AppPages {
  static final pages = [
  GetPage(name: Routes.LOGIN, page: () => const LoginView()),
  GetPage(name: Routes.USERS, page: () => const HomeView()),
    GetPage(
      name: Routes.CALL,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final channelName = args?['channelName'] as String? ?? '';
        final agoraService = (args?['agoraService'] as AgoraService?) ?? AgoraService();
        return CallView(channelName: channelName, agoraService: agoraService);
      },
    ),
  ];
}
