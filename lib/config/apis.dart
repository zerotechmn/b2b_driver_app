import 'package:b2b_driver_app/config/environment.dart';
import 'package:dio/dio.dart';

class Apis {
  // Auth
  static var login =
      () => RequestOptions(baseUrl: Env.baseUrl, path: "login", method: "POST");
}
