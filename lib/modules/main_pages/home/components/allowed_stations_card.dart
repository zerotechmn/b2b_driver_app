import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/main_pages/home/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllowedStationsCard extends StatelessWidget {
  const AllowedStationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colors(context).backgroundPrimary,
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(AssetConstants.locationPinOutlinedIcon),
          GetBuilder<HomeController>(
            builder: (controller) {
              String stations = (controller.cardDetail.value?.gasStations ?? [])
                  .map((item) => item.name)
                  .join(", ");
              return Flexible(
                child: Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Авах боломжтой салбар",
                        style: textTheme(context).bodyLarge!.copyWith(
                          color: colors(context).labelSecondary,
                        ),
                      ),
                      Text(
                        stations.isEmpty ? "Салбар байхгүй" : stations,
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
