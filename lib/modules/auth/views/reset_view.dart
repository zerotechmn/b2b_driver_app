import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/auth/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/buttons/button.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResetView extends StatefulWidget {
  const ResetView({super.key});

  @override
  State<ResetView> createState() => _ResetViewState();
}

class _ResetViewState extends State<ResetView> {
  late AuthController controller;
  final TextEditingController _phoneNo = TextEditingController();

  @override
  void initState() {
    controller = Get.find<AuthController>();
    if (controller.phoneNo.value.isNotEmpty &&
        controller.phoneNo.value.length == 8) {
      _phoneNo.text = controller.phoneNo.value;
    }
    _phoneNo.addListener(() {
      controller.phoneNo.value = _phoneNo.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _phoneNo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Нууц үг сэргээх',
          style: textTheme(
            context,
          ).titleSmall!.copyWith(fontWeight: FontWeight.bold),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 16),
              Text(
                "Нууц үгээ сэргээхийн тулд бүртгэлтэй утасны дугаараа оруулна уу",
                textAlign: TextAlign.center,
                style: textTheme(context).titleSmall,
              ),
              SizedBox(height: 35),
              Input(
                controller: _phoneNo,
                hint: 'Утасны дугаар',
                keyboardType: TextInputType.number,
                leadingIcon: SvgPicture.asset(
                  AssetConstants.phoneIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Obx(
                  () => Button(
                    text: 'Дараагийн алхам',
                    isEnabled:
                        controller.phoneNo.value.isNotEmpty &&
                        controller.phoneNo.value.length == 8,
                    onPressed: () {
                      // controller.resetPassword();
                    },
                    type: ButtonTypes.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
