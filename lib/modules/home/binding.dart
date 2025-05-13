import 'package:b2b_driver_app/modules/home/controller.dart';
import 'package:get/get.dart';

class HomeLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLayoutController>(() => HomeLayoutController());
  }
}
