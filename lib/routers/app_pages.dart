import 'package:b2b_driver_app/modules/auth/binding.dart';
import 'package:b2b_driver_app/modules/auth/views/change_password_view.dart';
import 'package:b2b_driver_app/modules/auth/views/login_view.dart';
import 'package:b2b_driver_app/modules/auth/views/otp_view.dart';
import 'package:b2b_driver_app/modules/auth/views/reset_password_view.dart';
import 'package:b2b_driver_app/modules/auth/views/reset_view.dart';
import 'package:b2b_driver_app/modules/main_pages/binding.dart';
import 'package:b2b_driver_app/modules/main_pages/view.dart';
import 'package:b2b_driver_app/modules/splash/binding.dart';
import 'package:b2b_driver_app/modules/splash/view.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRouters.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRouters.login,
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRouters.reset,
      page: () => ResetView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRouters.otp,
      page: () => OtpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRouters.resetPassword,
      page: () => ResetPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRouters.changePassword,
      page: () => ChangePasswordView(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRouters.home,
      page: () => HomeLayout(),
      binding: HomeLayoutBinding(),
    ),
  ];
}
