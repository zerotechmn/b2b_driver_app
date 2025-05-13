import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/services/secure_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final StorageService storageService = Get.find<StorageService>();

  void validateAuth() async {
    Get.toNamed(AppRouters.login);
  }
}
