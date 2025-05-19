import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

AppBar getHomeAppBar(BuildContext context, String name) {
  return AppBar(
    leading: Container(),
    leadingWidth: 0,
    toolbarHeight: 66,
    centerTitle: false,
    title: Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hey? $name',
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
  );
}
