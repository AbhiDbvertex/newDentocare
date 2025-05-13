import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:dentocoreauth/controllers/change_password_controller.dart';
import 'package:dentocoreauth/controllers/chat_controller.dart';
import 'package:dentocoreauth/controllers/create_password_controller.dart';
import 'package:dentocoreauth/controllers/forgot_password_controller.dart';
import 'package:dentocoreauth/controllers/notification_controller.dart';
import 'package:dentocoreauth/controllers/otp_controller.dart';
import 'package:dentocoreauth/controllers/profile_controller.dart';
import 'package:dentocoreauth/controllers/signup_controller.dart';
import 'package:dentocoreauth/controllers/user_controller.dart';
import 'package:dentocoreauth/controllers/video_controller.dart';
import 'package:dentocoreauth/data/api/apiclient.dart';
import 'package:dentocoreauth/data/repository/auth_repository/notification_repo.dart';
import 'package:dentocoreauth/data/repository/auth_repository/profile_repository.dart';
import 'package:dentocoreauth/data/repository/auth_repository/user_repo.dart';
import 'package:dentocoreauth/data/repository/auth_repository/video_repo.dart';
import 'package:dentocoreauth/pages/payment_history/payment_history.dart';
import 'package:dentocoreauth/utils/app_constant.dart';

import '../controllers/change_password_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/payment_controller.dart';
import '../data/repository/auth_repository/auth_repository.dart';
import '../data/repository/auth_repository/chat_repo.dart';
import '../data/repository/payment_repository.dart';
import '../utils/GetXNetworkManager.dart';

Future<void> init() async {

  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.BASE_URL));
  Get.lazyPut(() => AuthRepository(apiClient: Get.find()));
  Get.lazyPut(() => ProfileRepository(apiclient: Get.find()));
  Get.lazyPut(() => LoginController(authRepository: Get.find()));
  Get.lazyPut(() => SignupController(authRepository: Get.find()));
  Get.put(GetXNetworkManager());
  Get.put(ApiClient(appBaseUrl: AppConstant.BASE_URL));
  Get.put(UserRepositry(apiclient: Get.find()));
  Get.put(UserController(userRepositry: Get.find()));
  Get.put(PaymentRepository(apiClient: Get.find()));
  Get.put(PaymentController(paymentRepository:Get.find()));
  Get.put(ChatRepository(apiClient: Get.find()));
  Get.put(ChatController(chatRepository: Get.find()));
  Get.put(ChangePasswordController(authRepository: Get.find()));
  Get.put(VideoRepository(apiclient: Get.find()));
  Get.put(VideoController(videoRepository: Get.find()));
  Get.put(AuthRepository(apiClient: Get.find()));
  Get.put(ProfileRepository(apiclient: Get.find()));
  Get.put(NotificationRepository(apiclient: Get.find()));
  Get.put(NotificationController(notificationRepository: Get.find()));
  Get.put(LoginController(authRepository: Get.find()));
  Get.put(SignupController(authRepository: Get.find()));
  Get.put(CreatePasswordController(authRepository: Get.find()));
  Get.put(OtpController(authRepository: Get.find()));
  Get.put(ForgotPasswordController(authRepository: Get.find()));
  Get.put(ProfileController(profileRepository: Get.find()));
}
