import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BranchItem extends StatelessWidget {
  const BranchItem({super.key, required this.station});

  final StationModel station;

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
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        station.name,
                        style: textTheme(
                          context,
                        ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        station.address ?? "Хаяг байхгүй",
                        style: textTheme(context).bodyMedium!.copyWith(
                          color: colors(context).labelSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      spacing: 4,
                      children: [
                        SvgPicture.asset(AssetConstants.timeSmallIcon),
                        Flexible(
                          child: Text(
                            station.additionalInfo?.workingHours ?? "NaN",
                            style: textTheme(
                              context,
                            ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(AssetConstants.locationArrowSmallIcon),
                      Text(
                        station.distanceKm != null
                            ? "${station.distanceKm!.toStringAsFixed(1)} km"
                            : "-",
                        style: textTheme(
                          context,
                        ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  // Flexible(
                  //   child: Text(
                  //     "Түр ажиллахгүй",
                  //     style: textTheme(context).titleSmall!.copyWith(
                  //       fontWeight: FontWeight.w500,
                  //       color: colors(context).primary,
                  //     ),
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
