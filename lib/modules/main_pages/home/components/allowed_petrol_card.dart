import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/main_pages/home/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllowedPetrolCard extends StatelessWidget {
  const AllowedPetrolCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colors(context).backgroundPrimary,
      ),
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(AssetConstants.lockViewFinderIcon),
          GetBuilder<HomeController>(
            builder: (controller) {
              String? products = controller.cardDetail.value?.products.join(
                ", ",
              );
              if (products == null || products.isEmpty) {
                products = "Бүгд";
              }
              return Flexible(
                child: Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Түгжсэн бүтээгдэхүүн",
                        style: textTheme(context).bodyLarge!.copyWith(
                          color: colors(context).labelSecondary,
                        ),
                      ),
                      Text(
                        products,
                        softWrap: true,
                        style: textTheme(context).bodyLarge,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
