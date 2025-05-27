import 'dart:async';

import 'package:b2b_driver_app/config/apis.dart';
import 'package:b2b_driver_app/data/models/user_model.dart';
import 'package:b2b_driver_app/services/api_service.dart';
import 'package:b2b_driver_app/utils/helpers.dart';
import 'package:get/get.dart';

class AuthRepository {
  final ApiService apiService = Get.find<ApiService>();

  Future<UserModel> login(phoneNo, password) async {
    final res = await apiService.call(
      Apis.login().copyWith(data: {"phone": phoneNo, "password": password}),
    );
    return parseOrThrow(res.data, UserModel.fromJson);
  }
}
