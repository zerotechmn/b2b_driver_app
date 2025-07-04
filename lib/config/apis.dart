import 'package:b2b_driver_app/config/environment.dart';
import 'package:dio/dio.dart';

class Apis {
  // Auth
  static var login =
      () => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/login",
        method: "POST",
      );
  static var changePassword =
      () => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/change-password",
        method: "POST",
      );

  static var sendOtp =
      () => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/send-otp",
        method: "POST",
      );
  static var verifyOtp =
      () => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/verify-otp",
        method: "POST",
      );
  static var recoverPassword =
      () => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/recover-password",
        method: "POST",
      );

  static var fetchCardDetail =
      (String id) => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/card/$id",
        method: "GET",
      );

  static var fetchCardStatements =
      (String id, from, to) => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/statements/$id",
        method: "GET",
        queryParameters: {"from": from, "to": to},
      );

  static var fetchGasStations =
      ({String? province, String? district}) => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/gas-stations",
        method: "GET",
        queryParameters: {"aimagHot": province, "duuregSum": district},
      );

  static var fetchAddresses =
      () => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/address-list",
        method: "GET",
      );
}
