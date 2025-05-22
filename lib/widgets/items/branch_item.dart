import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BranchItem extends StatelessWidget {
  const BranchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors(context).backgroundSecondary,
        border: Border.all(
          width: 2,
          color: colors(context).backgroundSecondary!,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              spacing: 16,
              children: [
                SvgPicture.asset(AssetConstants.locationPinIcon),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "№23 Зайсан салбар",
                      style: textTheme(
                        context,
                      ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "ХУД, 8-р хороо, Зайсан толгой",
                      style: textTheme(context).bodyMedium!.copyWith(
                        color: colors(context).labelSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 120 - 70,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              color: colors(context).backgroundPrimary,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(AssetConstants.timeSmallIcon),
                    Text(
                      "24/7",
                      style: textTheme(
                        context,
                      ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(AssetConstants.locationArrowSmallIcon),
                    Text(
                      "5.8 km",
                      style: textTheme(
                        context,
                      ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Flexible(
                  child: Text(
                    "Түр ажиллахгүй",
                    style: textTheme(context).titleSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colors(context).primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
