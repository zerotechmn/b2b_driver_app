import 'dart:async';

import 'package:b2b_driver_app/data/models/user_model.dart';
import 'package:b2b_driver_app/data/repositories/auth_repository.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/services/storage_service.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/exceptions.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:b2b_driver_app/utils/helpers.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/confirm_sheet.dart';
import 'package:b2b_driver_app/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository = AuthRepository();
  final StorageService storageService = Get.find<StorageService>();

  var phoneNo = "".obs;
  var password = "".obs;
  var newPassword = "".obs;
  var confirmPassword = "".obs;

  var isLoading = false.obs;

  var countdown = 120.obs;
  Timer? _timer;

  void login() async {
    try {
      isLoading.value = true;
      final user = await authRepository.login(phoneNo.value, password.value);
      if (user.cardId == null || user.cardId!.isEmpty) {
        throw AppException(
          "Танд холбогдсон карт байхгүй байна. Та картын холболт хийгдсэн эсэхээ шалгана уу.",
        );
      }
      storageService.writeJson("user", user);
      Get.offNamed(AppRouters.home);
    } on AppException catch (e) {
      e.showSnackbar();
    } finally {
      isLoading.value = false;
    }
  }

  void sendCode() async {
    showLoadingDialog();
    try {
      await authRepository.sendOtp(phoneNo.value);
      hideLoadingDialog();
      Get.snackbar("Амжилттай", "Нэг удаагийн нууц үг илгээгдлээ");
      startCountdown();
      // Navigate to the OTP screen
      // If current route is not OTP, navigate to OTP
      if (Get.currentRoute != AppRouters.otp) {
        Get.toNamed(AppRouters.otp);
      }
    } on AppException catch (e) {
      hideLoadingDialog();
      e.showSnackbar();
    }
  }

  void verifyCode(String code) async {
    if (code.length != 4) {
      return;
    }
    showLoadingDialog();
    try {
      await authRepository.verifyOtp(phoneNo.value, code);
      hideLoadingDialog();
      newPassword.value = "";
      confirmPassword.value = "";
      Get.offNamed(AppRouters.resetPassword);
    } on AppException catch (e) {
      hideLoadingDialog();
      e.showSnackbar();
    }
  }

  void resetPassword() async {
    if (newPassword.value == confirmPassword.value) {
      showLoadingDialog();
      try {
        await authRepository.recoverPassword(phoneNo.value, newPassword.value);
        hideLoadingDialog();
        newPassword.value = "";
        confirmPassword.value = "";
        showMaterialModalBottomSheet(
          expand: false,
          context: Get.context!,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          isDismissible: false,
          backgroundColor: colors(Get.context!).backgroundPrimary,
          builder:
              (context) => ConfirmSheet(
                title: "Амжилттай",
                description: "Нууц үг амжилттай солигдлоо",
                confirmText: "Нэвтрэх",
                onConfirm: () {
                  Get.offAllNamed(AppRouters.login);
                },
                type: ButtonTypes.primary,
              ),
        );
      } on AppException catch (e) {
        hideLoadingDialog();
        e.showSnackbar();
      }
    } else {
      Get.snackbar("Уучлаарай", "Нууц үг таарахгүй байна");
    }
  }

  void toChangePassword() {
    password.value = "";
    newPassword.value = "";
    confirmPassword.value = "";
    Get.toNamed(AppRouters.changePassword);
  }

  void changePassword() async {
    if (password.value == newPassword.value) {
      Get.snackbar("Уучлаарай", "Шинэ нууц үг хуучин нууц үгтэй үжил байна");
      return;
    }
    if (newPassword.value == confirmPassword.value) {
      showLoadingDialog();
      try {
        final UserModel? user = await storageService.readJson<UserModel>(
          "user",
          (json) => UserModel.fromJson(json),
        );
        await authRepository.changePassword(
          user!.id,
          password.value,
          newPassword.value,
        );
        hideLoadingDialog();
        showMaterialModalBottomSheet(
          expand: false,
          context: Get.context!,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          isDismissible: false,
          backgroundColor: colors(Get.context!).backgroundPrimary,
          builder:
              (context) => ConfirmSheet(
                title: "Амжилттай",
                description: "Нууц үг амжилттай солигдлоо",
                confirmText: "Нүүр хуудас",
                onConfirm: () {
                  Get.offAllNamed(AppRouters.home);
                },
                type: ButtonTypes.primary,
              ),
        );
      } on AppException catch (e) {
        hideLoadingDialog();
        e.showSnackbar();
      }
    } else {
      Get.snackbar("Уучлаарай", "Нууц үг таарахгүй байна");
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
    countdown.value = 120;
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
