import 'package:get/get.dart';

class HomeLayoutController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
    update();
  }

  void onTap(int index) {
    currentIndex.value = index;
    update();
  }
}
