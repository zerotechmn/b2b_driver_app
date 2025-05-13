import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/auth/controller.dart';
import 'package:b2b_driver_app/modules/auth/views/components/password_strength_check.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/buttons/button.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late AuthController controller;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void initState() {
    controller = Get.find<AuthController>();
    _password.addListener(() {
      controller.password.value = _password.text;
    });
    _newPassword.addListener(() {
      controller.newPassword.value = _newPassword.text;
    });
    _confirmPassword.addListener(() {
      controller.confirmPassword.value = _confirmPassword.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _newPassword.dispose();
    _confirmPassword.dispose();
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 32),
              Text(
                "Та цааш нэвтрэх нууц үгээ үүсгэнэ үү.",
                textAlign: TextAlign.center,
                style: textTheme(context).titleSmall,
              ),
              SizedBox(height: 35),
              Input(
                controller: _password,
                hint: 'Хуучин нууц үг',
                isPassword: true,
                showClearIcon: true,
                leadingIcon: SvgPicture.asset(
                  AssetConstants.lockIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
                maxLength: 16,
              ),
              SizedBox(height: 12),
              Input(
                controller: _newPassword,
                hint: 'Шинэ нууц үг',
                isPassword: true,
                showClearIcon: true,
                leadingIcon: SvgPicture.asset(
                  AssetConstants.lockIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
                maxLength: 16,
              ),
              SizedBox(height: 12),
              Input(
                controller: _confirmPassword,
                hint: 'Нууц үг давтах',
                isPassword: true,
                showClearIcon: true,
                leadingIcon: SvgPicture.asset(
                  AssetConstants.lockIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
                maxLength: 16,
              ),
              SizedBox(height: 32),
              PasswordStrengthCheck(),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Obx(
                  () => Button(
                    text: 'Нууц үг солих',
                    isEnabled:
                        controller.password.value.isNotEmpty &&
                        controller.newPassword.value.isNotEmpty &&
                        controller.confirmPassword.value.isNotEmpty &&
                        controller.checkPassword('length') == true &&
                        controller.checkPassword('uppercase') == true &&
                        controller.checkPassword('lowercase') == true &&
                        controller.checkPassword('number') == true &&
                        controller.checkPassword('special') == true,
                    onPressed: () {
                      controller.changePassword();
                    },
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
