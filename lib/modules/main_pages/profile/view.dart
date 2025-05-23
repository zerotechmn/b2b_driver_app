import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/appbars/home_appbar.dart';
import 'package:b2b_driver_app/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHomeAppBar(context, "Dulguun"),
      backgroundColor: colors(context).backgroundSecondary,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            MenuItem(
              onTap: () {
                Get.toNamed(AppRouters.changePassword);
              },
              title: "Нууц үг солих",
              icon: SvgPicture.asset(AssetConstants.lockIcon),
            ),
            MenuItem(
              onTap: () {},
              title: "Гарах",
              icon: SvgPicture.asset(AssetConstants.lockIcon),
            ),
          ],
        ),
      ),
    );
  }
}
