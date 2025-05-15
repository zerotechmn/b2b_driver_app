import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 66,
        centerTitle: false,
        title: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey? Dulguun',
              style: textTheme(
                context,
              ).headlineSmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              'Эрч хүчтэй байгаарай',
              style: textTheme(
                context,
              ).bodySmall!.copyWith(color: colors(context).labelSecondary),
            ),
          ],
        ),
      ),
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
