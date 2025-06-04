import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/auth/controller.dart';
import 'package:b2b_driver_app/modules/auth/views/components/otp_input.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/buttons/small_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OtpView extends StatelessWidget {
  OtpView({super.key});

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Нууц үг сэргээх',
          style: textTheme(
            context,
          ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
        ),
        leadingWidth: 40 + 16,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: SizedBox(
            width: 40,
            height: 40,
            child: Material(
              color: colors(context).backgroundSecondary,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  AssetConstants.arrowLeftIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: Text(
                    "Таны ${controller.phoneNo.value} дугаарт илгээсэн нууц кодыг оруулна уу.",
                    textAlign: TextAlign.center,
                    style: textTheme(context).titleSmall,
                  ),
                ),
                OTPInput(
                  onFinished: (p0) {
                    controller.verifyCode(p0);
                  },
                ),
                Obx(
                  () => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          "${(controller.countdown.value ~/ 60).toString().padLeft(2, '0')}:${(controller.countdown.value % 60).toString().padLeft(2, '0')}",
                          style: textTheme(
                            context,
                          ).titleSmall!.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      SmallButton(
                        text: "Дахин илгээх",
                        width: 116,
                        isEnabled: !controller.isCountdownActive,
                        onPressed: () {
                          controller.sendCode();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
