import 'package:b2b_driver_app/config/environment.dart';
import 'package:dio/dio.dart';

class Apis {
  // App
  static var fetchAppInfo =
      () => RequestOptions(baseUrl: Env.baseUrl, path: "avdar/v1/app");

  // Auth
  static var login =
      () => RequestOptions(
        baseUrl: Env.authBaseUrl,
        path: "main/v1/auth/user/login-and-create-step-1",
        method: "POST",
      );
}
