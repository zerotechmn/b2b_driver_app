import 'package:b2b_driver_app/data/models/user_model.dart';
import 'package:b2b_driver_app/services/storage_service.dart';
import 'package:get/get.dart';

class HomeLayoutController extends GetxController {
  StorageService storageService = Get.find<StorageService>();

  var currentIndex = 0.obs;
  var currentStationIndex = 0.obs;

  var headerName = "".obs;

  void fetchHeaderName() async {
    final UserModel? user = await storageService.readJson(
      "user",
      UserModel.fromJson,
    );
    if (user != null) {
      headerName.value = user.firstName;
    } else {
      headerName.value = "Хэрэглэгч";
    }
  }
}
