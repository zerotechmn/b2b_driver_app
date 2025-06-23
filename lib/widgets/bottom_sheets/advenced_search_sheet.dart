import 'package:b2b_driver_app/config/assets.dart';
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
  double _lastSize = 0.5;

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
            (context, scrollController) => LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  width: double.infinity,
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
                              .clamp(0.5, 0.8);
                          _sheetController.animateTo(
                            newSize,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              DragHandler(),
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
                              Divider(
                                color: colors(context).backgroundSecondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                "ОНЦЛОГУУД",
                                style: textTheme(context).bodySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
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
                                                      .setSelectedService(
                                                        service,
                                                      ),
                                            );
                                          }).toList(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 16),
                              Text(
                                "ТҮЛШНИЙ ТӨРӨЛ",
                                style: textTheme(context).bodySmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 45,
                      //   width: double.infinity,
                      //   child: GetBuilder<StationController>(
                      //     builder: (controller) {
                      //       List<String> services =
                      //           controller.stationServices.value;
                      //       return ListView.separated(
                      //         itemCount: services.length,
                      //         padding: EdgeInsets.symmetric(horizontal: 16),
                      //         scrollDirection: Axis.horizontal,
                      //         itemBuilder: (context, index) {
                      //           return FilterItem(
                      //             name: services[index],
                      //             isSelected:
                      //                 controller.selectedStationService.value ==
                      //                 services[index],
                      //             onTap:
                      //                 () => controller.setSelectedService(
                      //                   services[index],
                      //                 ),
                      //           );
                      //         },
                      //         separatorBuilder:
                      //             (context, index) => SizedBox(width: 8),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // SizedBox(height: 16),
                      // Only the ListView below is scrollable
                      // Expanded(
                      //   child: GetBuilder<StationController>(
                      //     builder: (controller) {
                      //       List<StationModel> stations =
                      //           controller.stations.value;
                      //       if (controller.isLoading.value) {
                      //         return Center(
                      //           child: CircularProgressIndicator(
                      //             color: colors(context).primary,
                      //           ),
                      //         );
                      //       }
                      //       if (stations.isEmpty) {
                      //         return Center(
                      //           child: Text(
                      //             "Салбар олдсонгүй",
                      //             style: Theme.of(context).textTheme.bodyMedium,
                      //           ),
                      //         );
                      //       }
                      //       return RefreshIndicator(
                      //         onRefresh: () async {
                      //           await controller.fetchGasStations();
                      //         },
                      //         child: ListView.separated(
                      //           controller: scrollController,
                      //           padding: EdgeInsets.only(
                      //             left: 16,
                      //             right: 16,
                      //             bottom: 16,
                      //           ),
                      //           itemCount: stations.length,
                      //           itemBuilder: (context, index) {
                      //             return BranchItem(
                      //               station: stations[index],
                      //               onCenterMap: (e) {
                      //                 if (widget.onCenterMap != null) {
                      //                   widget.onCenterMap!(e);
                      //                   _sheetController.animateTo(
                      //                     0.3,
                      //                     duration: Duration(milliseconds: 300),
                      //                     curve: Curves.easeInOut,
                      //                   );
                      //                 }
                      //               },
                      //             );
                      //           },
                      //           separatorBuilder:
                      //               (context, index) => SizedBox(height: 16),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }
}
