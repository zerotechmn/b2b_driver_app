import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:b2b_driver_app/modules/main_pages/station_pages/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/drag_handler.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:b2b_driver_app/widgets/items/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AdvencedSearchSheet extends StatefulWidget {
  const AdvencedSearchSheet({super.key, this.onCenterMap});

  final void Function(GeoPoint point)? onCenterMap;

  @override
  State<AdvencedSearchSheet> createState() => _AdvencedSearchSheetState();
}

class _AdvencedSearchSheetState extends State<AdvencedSearchSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    StationController controller = Get.find<StationController>();
    return SizedBox(
      width: double.infinity,
      child: DraggableScrollableSheet(
        controller: _sheetController,
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.8,
        expand: false,
        snap: true,
        snapSizes: [0.5, 0.8],
        builder:
            (context, scrollController) => Container(
              decoration: BoxDecoration(
                color: colors(context).backgroundPrimary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  // Header with drag handle - not scrollable
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        DragHandler(),
                        SizedBox(height: 16),
                        Input(
                          hint: "Салбар хайх",
                          controller: controller.searchController,
                          trailingIcon: SvgPicture.asset(
                            AssetConstants.arrowDownCircleIcon,
                          ),
                          isReadOnly: true,
                        ),
                        SizedBox(height: 16),
                        Input(
                          hint: "Салбар хайх",
                          controller: controller.searchController,
                          trailingIcon: SvgPicture.asset(
                            AssetConstants.arrowDownCircleIcon,
                          ),
                          isReadOnly: true,
                        ),
                        SizedBox(height: 16),
                        Divider(color: colors(context).backgroundSecondary),
                      ],
                    ),
                  ),
                  // Scrollable content
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            "ОНЦЛОГУУД",
                            style: textTheme(
                              context,
                            ).bodySmall!.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 16),
                          GetBuilder<StationController>(
                            builder: (controller) {
                              List<String> services =
                                  controller.stationServices.value;
                              return SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children:
                                      services.map((service) {
                                        return FilterItem(
                                          name: service,
                                          isSelected:
                                              controller
                                                  .selectedStationService
                                                  .value ==
                                              service,
                                          onTap:
                                              () => controller
                                                  .setSelectedService(service),
                                        );
                                      }).toList(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            "ТҮЛШНИЙ ТӨРӨЛ",
                            style: textTheme(
                              context,
                            ).bodySmall!.copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 16),
                          GetBuilder<StationController>(
                            builder: (controller) {
                              List<StationProductModel> fuelTypes =
                                  controller.stationProducts.value;
                              return SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children:
                                      fuelTypes.map((fuelType) {
                                        return FilterItem(
                                          name: fuelType.productName,
                                          isSelected:
                                              controller
                                                  .selectedFuelType
                                                  .value ==
                                              fuelType.productCode,
                                          onTap:
                                              () => controller.selectedFuelType(
                                                fuelType.productCode,
                                              ),
                                        );
                                      }).toList(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
