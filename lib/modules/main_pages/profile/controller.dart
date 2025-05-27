import 'package:b2b_driver_app/data/repositories/auth_repository.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/services/storage_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  AuthRepository authRepository = AuthRepository();
  final StorageService storageService = Get.find<StorageService>();

  logout() async {
    await storageService.deleteAll();
    Get.offAllNamed(AppRouters.login);
  }
}
