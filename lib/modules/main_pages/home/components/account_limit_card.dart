import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/main_pages/home/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AccountLimitCard extends StatelessWidget {
  const AccountLimitCard({super.key});

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
          SvgPicture.asset(AssetConstants.creditCardConvertIcon),
          GetBuilder<HomeController>(
            builder: (controller) {
              bool isLoading = controller.isLoading.value;
              num limit = controller.cardDetail.value?.maxLimit ?? 0;
              return Skeletonizer(
                enabled: isLoading,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Картын лимит",
                      style: textTheme(context).bodyLarge!.copyWith(
                        color: colors(context).labelSecondary,
                      ),
                    ),
                    Text(
                      limit.toInt().toCurrency(),
                      style: textTheme(context).bodyLarge,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
