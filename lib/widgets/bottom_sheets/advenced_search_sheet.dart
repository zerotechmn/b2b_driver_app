import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:b2b_driver_app/modules/main_pages/station_pages/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/drag_handler.dart';
import 'package:b2b_driver_app/widgets/inputs/select.dart';
import 'package:b2b_driver_app/widgets/items/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
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
                    child: // In your widget, replace the Select widgets with:
                        GetBuilder<StationController>(
                      builder: (controller) {
                        return Column(
                          children: [
                            SizedBox(height: 16),
                            DragHandler(),
                            // Province Select
                            Select(
                              hint: "Хот аймаг",
                              controller: controller.searchProvinceController,
                              selectedValue:
                                  controller.selectedProvinceCode.value,
                              options:
                                  controller.provinces.value.map((province) {
                                    return SelectOption(
                                      value: province.code ?? '',
                                      label: province.name,
                                    );
                                  }).toList(),
                              onChanged: (value, label) {
                                controller.onProvinceSelected(value, label);
                              },
                            ),

                            SizedBox(height: 16),

                            // District Select
                            Select(
                              hint: "Дүүрэг сум",
                              controller: controller.searchDistrictController,
                              selectedValue:
                                  controller.selectedDistrictCode.value,
                              options:
                                  controller.districts.value.map((district) {
                                    return SelectOption(
                                      value: district.code ?? '',
                                      label: district.name,
                                    );
                                  }).toList(),
                              onChanged: (value, label) {
                                controller.onDistrictSelected(value, label);
                              },
                            ),
                          ],
                        );
                      },
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
                          SizedBox(height: 16),
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
                              List<StationProductModel> productTypes =
                                  controller.stationProducts.value;
                              return SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children:
                                      productTypes.map((productType) {
                                        return FilterItem(
                                          name: productType.productName,
                                          isSelected:
                                              controller
                                                  .selectedProductType
                                                  .value ==
                                              productType.productCode,
                                          onTap:
                                              () => controller
                                                  .setSelectedProductType(
                                                    productType.productCode,
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
