import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

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
      body: Padding(padding: EdgeInsets.all(16), child: Column(children: [])),
    );
  }
}
