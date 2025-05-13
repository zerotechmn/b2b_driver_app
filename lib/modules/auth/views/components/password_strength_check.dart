import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/auth/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PasswordStrengthCheck extends StatelessWidget {
  const PasswordStrengthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find<AuthController>();
    return Column(
      children: [
        for (var item in Constants.passwordStrengthCheck) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(
              () => Row(
                spacing: 8,
                children: [
                  SvgPicture.asset(
                    AssetConstants.checkCircleIcon,
                    width: 22,
                    height: 22,
                    colorFilter:
                        controller.checkPassword(item['key']!) == true
                            ? ColorFilter.mode(
                              colors(context).primary!,
                              BlendMode.srcIn,
                            )
                            : null,
                  ),
                  Text(
                    item['title']!,
                    style: textTheme(context).bodyMedium!.copyWith(
                      color: colors(context).labelSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
