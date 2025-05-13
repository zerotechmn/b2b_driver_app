import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/auth/controller.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/buttons/button.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthController controller;
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    controller = Get.find<AuthController>();
    _phoneNo.addListener(() {
      controller.phoneNo.value = _phoneNo.text;
    });
    _password.addListener(() {
      controller.password.value = _password.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _phoneNo.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Spacer(),
              SvgPicture.asset(AssetConstants.logo),
              const SizedBox(height: 45),
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
              const SizedBox(height: 12),
              Input(
                controller: _password,
                hint: 'Нууц үг',
                isPassword: true,
                showClearIcon: true,
                leadingIcon: SvgPicture.asset(
                  AssetConstants.lockIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(height: 32),
              GestureDetector(
                onTap: () => Get.toNamed(AppRouters.reset),
                child: RichText(
                  text: TextSpan(
                    style: textTheme(context).bodyMedium!.copyWith(
                      color: colors(context).labelSecondary,
                    ),
                    children: [
                      TextSpan(text: "Нууц үгээ мартсан уу? "),
                      TextSpan(
                        text: "Сэргээх",
                        style: textTheme(context).bodyMedium!.copyWith(
                          color: colors(context).labelSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Button(
                text: 'Нэвтрэх',
                onPressed: () {
                  // controller.login();
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
