import 'package:b2b_driver_app/modules/main_pages/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar getHomeAppBar(BuildContext context) {
  HomeLayoutController controller = Get.find<HomeLayoutController>();
  controller.fetchHeaderName();
  return AppBar(
    leading: Container(),
    leadingWidth: 0,
    toolbarHeight: 66,
    centerTitle: false,
    title: Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            'Hey? ${controller.headerName.value}',
            style: textTheme(
              context,
            ).headlineSmall!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          'Эрч хүчтэй байгаарай',
          style: textTheme(
            context,
          ).bodySmall!.copyWith(color: colors(context).labelSecondary),
        ),
      ],
    ),
  );
}
