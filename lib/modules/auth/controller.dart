import 'package:b2b_driver_app/services/secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final StorageService storageService = Get.find<StorageService>();

  var phoneNo = "".obs;
  var password = "".obs;
}
