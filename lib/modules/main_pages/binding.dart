import 'package:b2b_driver_app/modules/main_pages/controller.dart';
import 'package:b2b_driver_app/modules/main_pages/history/controller.dart';
import 'package:b2b_driver_app/modules/main_pages/home/controller.dart';
import 'package:b2b_driver_app/modules/main_pages/profile/controller.dart';
import 'package:get/get.dart';

class HomeLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLayoutController>(() => HomeLayoutController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    // Get.lazyPut<MapController>(() => MapController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
