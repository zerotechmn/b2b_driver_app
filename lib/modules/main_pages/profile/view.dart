import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/main_pages/controller.dart';
import 'package:b2b_driver_app/modules/main_pages/profile/controller.dart';
import 'package:b2b_driver_app/routers/routers.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/appbars/home_appbar.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/confirm_sheet.dart';
import 'package:b2b_driver_app/widgets/items/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find<ProfileController>();
    HomeLayoutController layoutController = Get.find<HomeLayoutController>();
    return Scaffold(
      appBar: getHomeAppBar(context),
      backgroundColor: colors(context).backgroundSecondary,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Container(
              height: 70,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colors(context).backgroundPrimary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                spacing: 16,
                children: [
                  CircleAvatar(),
                  Obx(
                    () => Text(
                      layoutController.headerName.value,
                      style: textTheme(
                        context,
                      ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            MenuItem(
              onTap: () {
                Get.toNamed(AppRouters.changePassword);
              },
              title: "Нууц үг солих",
              icon: SvgPicture.asset(AssetConstants.lockIcon),
            ),
            MenuItem(
              onTap:
                  () => showMaterialModalBottomSheet(
                    expand: false,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    backgroundColor: colors(context).backgroundPrimary,
                    builder:
                        (context) => ConfirmSheet(
                          title: "Гарах",
                          description: "Та гарахдаа итгэлтэй байна уу?",
                          confirmText: "Гарах",
                          cancelText: "Болих",
                          onConfirm: () {
                            controller.logout();
                          },
                        ),
                  ),
              title: "Гарах",
              icon: SvgPicture.asset(AssetConstants.logoutIcon),
            ),
          ],
        ),
      ),
    );
  }
}
