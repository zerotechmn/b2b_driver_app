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
      () => RequestOptions(
        baseUrl: Env.baseUrl,
        path: "driver-app/gas-stations",
        method: "GET",
      );
}
