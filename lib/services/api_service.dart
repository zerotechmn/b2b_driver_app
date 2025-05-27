import 'dart:io';

import 'package:b2b_driver_app/config/environment.dart';
import 'package:b2b_driver_app/data/models/api_model.dart';
import 'package:b2b_driver_app/utils/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  late Dio dio;

  @override
  void onInit() {
    super.onInit();

    // Initialize Dio with BaseOptions
    dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        validateStatus: (status) => true, // Accept all responses
      ),
    );
  }

  Future<ApiModel> call(RequestOptions request) async {
    try {
      final response = await dio.fetch(request);

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return ApiModel.fromJson(response.data);
      }

      throw AppException(
        "Алдаа гарлаа: ${response.statusCode}",
        code: response.statusCode.toString(),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        throw AppException(
          "Та интернэт холботоо шалгана уу",
          code: "no_connection",
        );
      }
      if (e.response?.data["message"] != null) {
        throw AppException(
          e.response?.data["message"],
          code: e.response?.statusCode.toString(),
        );
      }
      if (e.response?.data["success"] == false) {
        throw AppException(
          e.response?.data["error"]["issues"]?[0]["message"] ?? "Алдаа гарлаа",
          code: e.response?.statusCode.toString(),
        );
      }
      throw AppException("Алдаа гарлаа");
    } catch (e) {
      throw AppException("Алдаа гарлаа");
    }
  }
}
