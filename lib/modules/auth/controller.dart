import 'dart:async';

import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/services/secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final StorageService storageService = Get.find<StorageService>();

  var phoneNo = "".obs;
  var password = "".obs;

  var countdown = 60.obs;
  Timer? _timer;

  void resetPassword() async {
    // Implement password reset logic here
    // For example, send OTP to the user's phone number
    // await storageService.setPhoneNo(phoneNo.value);
    startCountdown();
    Get.toNamed(AppRouters.otp);
  }

  void resendCode() {
    // Implement resend code logic here
    // For example, send a new OTP to the user's phone number
    startCountdown();
  }

  void verifyCode(String code) {
    // Implement OTP verification logic here
    // For example, check if the entered code matches the sent OTP
    if (code == "1234") {
      // Example condition
      Get.offNamed(AppRouters.home);
    } else {
      Get.snackbar("Error", "Invalid OTP");
    }
  }

  void startCountdown() {
    countdown.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  bool get isCountdownActive => countdown.value > 0;
}
