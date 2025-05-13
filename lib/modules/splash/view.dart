import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/splash/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<SplashController>();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.validateAuth(),
    );
  }

  getCurrentYear() {
    return DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Center(
              child: SizedBox(
                width: 200,
                child: SvgPicture.asset(AssetConstants.logo),
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                'v 0.1.0',
                style: textTheme(
                  context,
                ).bodyMedium!.copyWith(color: colors(context).labelSecondary),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                'Copyright ${getCurrentYear()} “Shunkhlai” LLC.',
                style: textTheme(
                  context,
                ).bodyMedium!.copyWith(color: colors(context).labelSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
