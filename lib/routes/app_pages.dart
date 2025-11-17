import 'package:get/get.dart';
import 'app_routes.dart';
import '../views/phone_login_view.dart';
import '../views/otp_view.dart';
import '../views/user_selection_view.dart';
import '../views/preferences_view.dart';
import '../views/users_list_view.dart';
import '../views/voice_call_view.dart';
import '../views/video_call_view.dart';
import '../views/profile_setup_screen.dart';
import '../views/chat_view.dart';
import '../views/conversations_list_view.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../views/call_view.dart';
import '../services/agora_service.dart';
import '../models/user_model.dart';

class AppPages {
  static final pages = [
    // New App Flow
    GetPage(name: Routes.PHONE_LOGIN, page: () => const PhoneLoginView()),
    GetPage(name: Routes.OTP, page: () => const OtpVerificationView()),
    GetPage(name: Routes.USER_SELECTION, page: () => const UserSelectionView()),
    GetPage(name: Routes.PREFERENCES, page: () => const PreferencesView()),
    GetPage(name: Routes.USERS_LIST, page: () => const UsersListView()),
    GetPage(name: Routes.PROFILE_SETUP, page: () => const ProfileSetupScreen()),
    GetPage(
      name: Routes.CONVERSATIONS,
      page: () => const ConversationsListView(),
    ),

    // Chat route
    GetPage(
      name: Routes.CHAT,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final user = args['user'] as UserModel;
        return ChatView(otherUser: user);
      },
    ),

    // Voice and Video Call routes
    GetPage(
      name: Routes.VOICE_CALL,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final user = args['user'] as UserModel;
        final channelName = args['channelName'] as String;
        return VoiceCallView(user: user, channelName: channelName);
      },
    ),
    GetPage(
      name: Routes.VIDEO_CALL,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final user = args['user'] as UserModel;
        final channelName = args['channelName'] as String;
        return VideoCallView(user: user, channelName: channelName);
      },
    ),

    // Old routes (backward compatibility)
    GetPage(name: Routes.LOGIN, page: () => const LoginView()),
    GetPage(name: Routes.USERS, page: () => const HomeView()),
    GetPage(
      name: Routes.CALL,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final channelName = args?['channelName'] as String? ?? '';
        final agoraService =
            (args?['agoraService'] as AgoraService?) ?? AgoraService();
        final userName = args?['userName'] as String?;
        return CallView(
          channelName: channelName,
          agoraService: agoraService,
          userName: userName,
        );
      },
    ),
  ];
}
