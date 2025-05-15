import 'package:get/get.dart';

class HomeController extends GetxController {
  var accountHistory = [].obs;
  var showAccountPin = false.obs;

  toggleAccountPin(bool value) {
    showAccountPin.value = value;
    update();
  }
}
