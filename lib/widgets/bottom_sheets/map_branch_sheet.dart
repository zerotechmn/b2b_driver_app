import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:b2b_driver_app/modules/main_pages/station_pages/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/drag_handler.dart';
import 'package:b2b_driver_app/widgets/buttons/small_button.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:b2b_driver_app/widgets/items/branch_item.dart';
import 'package:b2b_driver_app/widgets/items/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MapBranchSheet extends StatefulWidget {
  const MapBranchSheet({super.key, this.onCenterMap});

  final void Function(GeoPoint point)? onCenterMap;

  @override
  State<MapBranchSheet> createState() => _MapBranchSheetState();
}

class _MapBranchSheetState extends State<MapBranchSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  double _lastSize = 0.3;

  @override
  Widget build(BuildContext context) {
    StationController controller = Get.find<StationController>();
    return SizedBox(
      width: double.infinity,
      child: DraggableScrollableSheet(
        controller: _sheetController,
        initialChildSize: 0.3,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        expand: false,
        snap: true,
        snapSizes: [0.3, 0.5, 0.8],
        builder:
            (context, scrollController) => LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  child: Column(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onVerticalDragStart: (details) {
                          _lastSize = _sheetController.size;
                        },
                        onVerticalDragUpdate: (details) {
                          final newSize =
                              (_lastSize -
                                  details.primaryDelta! /
                                      MediaQuery.of(context).size.height);
                          _lastSize = newSize;
                          _sheetController.jumpTo(newSize);
                        },
                        onVerticalDragEnd: (details) {
                          final newSize = (_lastSize -
                                  details.primaryVelocity! /
                                      MediaQuery.of(context).size.height)
                              .clamp(0.3, 0.8);
                          _sheetController.animateTo(
                            newSize,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Column(
                          children: [
                            SizedBox(height: 16),
                            DragHandler(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                spacing: 16,
                                children: [
                                  Expanded(
                                    child: Input(
                                      hint: "Салбар хайх",
                                      controller: controller.searchController,
                                      leadingIcon: SvgPicture.asset(
                                        AssetConstants.searchIcon,
                                      ),
                                    ),
                                  ),
                                  SmallButton(
                                    icon: SvgPicture.asset(
                                      AssetConstants.filterIcon,
                                    ),
                                    width: 50,
                                    height: 50,
                                    borderRadius: 16,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: GetBuilder<StationController>(
                          builder: (controller) {
                            List<String> services =
                                controller.stationServices.value;
                            return ListView.separated(
                              itemCount: services.length,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return FilterItem(
                                  name: services[index],
                                  isSelected:
                                      controller.selectedStationService.value ==
                                      services[index],
                                  onTap:
                                      () => controller.setSelectedService(
                                        services[index],
                                      ),
                                );
                              },
                              separatorBuilder:
                                  (context, index) => SizedBox(width: 8),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      // Only the ListView below is scrollable
                      Expanded(
                        child: GetBuilder<StationController>(
                          builder: (controller) {
                            List<StationModel> stations =
                                controller.stations.value;
                            if (controller.isLoading.value) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: colors(context).primary,
                                ),
                              );
                            }
                            if (stations.isEmpty) {
                              return Center(
                                child: Text(
                                  "Салбар олдсонгүй",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              );
                            }
                            return RefreshIndicator(
                              onRefresh: () async {
                                await controller.fetchGasStations();
                              },
                              child: ListView.separated(
                                controller: scrollController,
                                padding: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 16,
                                ),
                                itemCount: stations.length,
                                itemBuilder: (context, index) {
                                  return BranchItem(
                                    station: stations[index],
                                    onCenterMap: widget.onCenterMap,
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 16),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }
}
