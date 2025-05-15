import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/main_pages/home/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AccountTogglePinCard extends StatelessWidget {
  const AccountTogglePinCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colors(context).backgroundPrimary,
      ),
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(AssetConstants.lockIcon),
          Expanded(
            child: GetBuilder<HomeController>(
              builder: (controller) {
                bool showPin = controller.showAccountPin.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 150),
                      style:
                          showPin
                              ? textTheme(context).bodyLarge!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: colors(context).labelSecondary,
                              )
                              : textTheme(context).titleSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                      child: Text(
                        "Картын нууц үг харах",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 150),
                      transitionBuilder:
                          (child, animation) => FadeTransition(
                            opacity: animation,
                            child: SizeTransition(
                              sizeFactor: animation,
                              axis: Axis.vertical,
                              child: child,
                            ),
                          ),
                      child:
                          showPin
                              ? Text(
                                "1234",
                                key: ValueKey("pinVisible"),
                                style: textTheme(context).titleMedium,
                              )
                              : SizedBox.shrink(key: ValueKey("pinHidden")),
                    ),
                  ],
                );
              },
            ),
          ),
          GetBuilder<HomeController>(
            builder: (controller) {
              bool showPin = controller.showAccountPin.value;
              return CupertinoSwitch(
                value: showPin,
                activeTrackColor: colors(context).primary,
                inactiveTrackColor: colors(context).backgroundSecondary,
                thumbColor: colors(context).backgroundPrimary,
                inactiveThumbColor: colors(context).primary,
                onChanged: (e) {
                  controller.toggleAccountPin(e);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
