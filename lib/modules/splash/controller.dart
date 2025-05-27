import 'package:b2b_driver_app/data/models/user_model.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/services/storage_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final StorageService storageService = Get.find<StorageService>();

  void validateAuth() async {
    final UserModel? user = await storageService.readJson<UserModel>(
      "user",
      (json) => UserModel.fromJson(json),
    );
    if (user != null) {
      Get.offNamed(AppRouters.home);
    } else {
      Get.toNamed(AppRouters.login);
    }
  }
}
