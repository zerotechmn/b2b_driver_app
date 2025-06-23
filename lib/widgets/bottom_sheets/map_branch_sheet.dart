import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:b2b_driver_app/modules/main_pages/station_pages/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/advenced_search_sheet.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/drag_handler.dart';
import 'package:b2b_driver_app/widgets/buttons/small_button.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:b2b_driver_app/widgets/items/branch_item.dart';
import 'package:b2b_driver_app/widgets/items/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MapBranchSheet extends StatefulWidget {
  const MapBranchSheet({super.key, this.onCenterMap});

  final void Function(GeoPoint point)? onCenterMap;

  @override
  State<MapBranchSheet> createState() => _MapBranchSheetState();
}

class _MapBranchSheetState extends State<MapBranchSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  // Calculate header heights
  double get _headerHeight {
    // DragHandler: 16 (top) + 4 (drag handle) = 20
    // Search row: 50 (input height) + 16 (bottom margin) = 66
    // Services: 45 (height) + 16 (bottom margin) = 61
    // Total: 20 + 66 + 61 = 147
    return 147;
  }

  double get _calculatedInitialSize {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaHeight = screenHeight - MediaQuery.of(context).padding.top;

    // Header height + threshold for list visibility (at least 100px for list)
    final minRequiredHeight = _headerHeight + 100;
    final calculatedSize = minRequiredHeight / safeAreaHeight;

    // Ensure it's between our min and max bounds, but at least 0.35 for good UX
    return (calculatedSize < 0.35)
        ? 0.35
        : (calculatedSize > 0.5)
        ? 0.5
        : calculatedSize;
  }

  @override
  Widget build(BuildContext context) {
    StationController controller = Get.find<StationController>();
    final initialSize = _calculatedInitialSize;

    return SizedBox(
      width: double.infinity,
      child: DraggableScrollableSheet(
        controller: _sheetController,
        initialChildSize: initialSize,
        minChildSize: initialSize, // Use calculated size as minimum too
        maxChildSize: 0.8,
        expand: false,
        snap: true,
        snapSizes: [initialSize, 0.6, 0.8],
        builder:
            (context, scrollController) => Container(
              decoration: BoxDecoration(
                color: colors(context).backgroundPrimary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  // Fixed header section - not scrollable
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        DragHandler(),
                        Row(
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
                              icon: SvgPicture.asset(AssetConstants.filterIcon),
                              onPressed:
                                  () => showMaterialModalBottomSheet(
                                    expand: false,
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    backgroundColor:
                                        colors(context).backgroundPrimary,
                                    builder: (context) => AdvencedSearchSheet(),
                                  ),
                              width: 50,
                              height: 50,
                              borderRadius: 16,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                  // Services filter section - not scrollable
                  GetBuilder<StationController>(
                    builder: (controller) {
                      List<String> services = controller.stationServices.value;
                      if (services.isEmpty) {
                        return SizedBox(
                          height: 16,
                        ); // Maintain spacing when no services
                      }
                      return Column(
                        children: [
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ListView.separated(
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
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                  // Scrollable content section
                  Expanded(
                    child: GetBuilder<StationController>(
                      builder: (controller) {
                        List<StationModel> stations = controller.stations.value;

                        if (controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: colors(context).primary,
                            ),
                          );
                        }

                        if (stations.isEmpty) {
                          // Empty state that's still scrollable to maintain drag functionality
                          return SingleChildScrollView(
                            controller: scrollController,
                            physics: AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height *
                                  0.3, // More height for better UX
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.location_off_outlined,
                                      size: 48,
                                      color: colors(context).labelSecondary,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "Салбар олдсонгүй",
                                      style: textTheme(
                                        context,
                                      ).bodyMedium?.copyWith(
                                        color: colors(context).labelSecondary,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Та хайлтаа өөрчлөөд дахин оролдоно уу",
                                      style: textTheme(
                                        context,
                                      ).bodySmall?.copyWith(
                                        color: colors(context).labelSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                onCenterMap: (e) {
                                  if (widget.onCenterMap != null) {
                                    widget.onCenterMap!(e);
                                    _sheetController.animateTo(
                                      0.3,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
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
            ),
      ),
    );
  }
}
