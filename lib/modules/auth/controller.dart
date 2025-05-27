import 'dart:async';

import 'package:b2b_driver_app/data/repositories/auth_repository.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/services/storage_service.dart';
import 'package:b2b_driver_app/utils/exceptions.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  final StorageService storageService = Get.find<StorageService>();

  var phoneNo = "".obs;
  var password = "".obs;
  var newPassword = "".obs;
  var confirmPassword = "".obs;

  var isLoading = false.obs;

  var countdown = 60.obs;
  Timer? _timer;

  void login() async {
    try {
      isLoading.value = true;
      final user = await authRepository.login(phoneNo.value, password.value);
      storageService.writeJson("user", user);
      Get.offNamed(AppRouters.home);
    } on AppException catch (e) {
      e.showSnackbar();
    } finally {
      isLoading.value = false;
    }
  }

  void sendCode() {
    // Implement send & resend code logic here
    // For example, send a new OTP to the user's phone number
    startCountdown();
    // Navigate to the OTP screen
    // If current route is not OTP, navigate to OTP
    if (Get.currentRoute != AppRouters.otp) {
      Get.toNamed(AppRouters.otp);
    }
  }

  void verifyCode(String code) {
    // Implement OTP verification logic here
    // For example, check if the entered code matches the sent OTP
    if (code == "1234") {
      // Example condition
      newPassword.value = "";
      confirmPassword.value = "";
      Get.offNamed(AppRouters.resetPassword);
    } else {
      Get.snackbar("Error", "Invalid OTP");
    }
  }

  void resetPassword() async {
    // Implement password reset logic here
    // For example, call an API to reset the password
    // and show a success bottom sheet
    if (newPassword.value == confirmPassword.value) {
      // Example condition
      // Get.offNamed(AppRouters.login);
    } else {
      Get.snackbar("Error", "Passwords do not match");
    }
  }

  void toChangePassword() {
    // Implement navigation to change password screen
    // For example, navigate to the change password screen
    // and clear the password fields
    password.value = "";
    newPassword.value = "";
    confirmPassword.value = "";
    Get.toNamed(AppRouters.changePassword);
  }

  void changePassword() async {
    // Implement password change logic here
    // For example, call an API to change the password
    if (newPassword.value == confirmPassword.value) {
      // Example condition
      // Get.offNamed(AppRouters.home);
    } else {
      Get.snackbar("Error", "Passwords do not match");
    }
  }

  bool checkPassword(String key) {
    // Implement password strength check logic here
    // For example, check if the password meets certain criteria
    switch (key) {
      case 'length':
        return newPassword.value.length >= 8 && newPassword.value.length <= 16;
      case 'uppercase':
        return newPassword.value.contains(RegExp(r'[A-Z]'));
      case 'lowercase':
        return newPassword.value.contains(RegExp(r'[a-z]'));
      case 'number':
        return newPassword.value.contains(RegExp(r'[0-9]'));
      case 'special':
        return newPassword.value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      default:
        return false;
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
