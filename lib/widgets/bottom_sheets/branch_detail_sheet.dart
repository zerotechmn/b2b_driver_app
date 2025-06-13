import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/utils/extension.dart';
import 'package:b2b_driver_app/utils/helpers.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/drag_handler.dart';
import 'package:b2b_driver_app/widgets/items/branch_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BranchDetailSheet extends StatelessWidget {
  const BranchDetailSheet({super.key, required this.station});

  final StationModel station;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors(context).backgroundPrimary,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DragHandler(),
              SizedBox(height: 16),
              BranchItem(station: station, disableTap: true),
              SizedBox(height: 16),
              if (station.lat != null && station.long != null)
                Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Material(
                        color: colors(context).backgroundPrimary,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap:
                              () => openMapApp(
                                double.parse(station.lat!),
                                double.parse(station.long!),
                              ),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: colors(context).backgroundSecondary!,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AssetConstants.locationPinSimpleIcon,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (station.lat != null && station.long != null)
                SizedBox(height: 16),
              Column(
                children: [
                  for (var i = 0; i < (station.products?.length ?? 0); i++)
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color:
                            i % 2 == 0
                                ? colors(context).backgroundSecondary
                                : colors(context).backgroundPrimary,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: _colorFromName(
                                station.products![i].productName,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              station.products![i].productName,
                              style: textTheme(context).titleSmall,
                            ),
                          ),
                          Text(
                            "${station.products![i].price.toInt().toCurrency()} төг",
                            style: textTheme(
                              context,
                            ).titleSmall!.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Divider(height: 1, color: colors(context).backgroundSecondary),
            ],
          ),
        ),
      ),
    );
  }

  Color _colorFromName(String name) {
    final hash = name.hashCode;
    final r = (hash & 0xFF0000) >> 16;
    final g = (hash & 0x00FF00) >> 8;
    final b = (hash & 0x0000FF);
    return Color.fromARGB(255, r, g, b);
  }
}
