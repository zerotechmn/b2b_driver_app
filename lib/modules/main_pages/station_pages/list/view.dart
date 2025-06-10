import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:b2b_driver_app/modules/main_pages/station_pages/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/buttons/small_button.dart';
import 'package:b2b_driver_app/widgets/inputs/input.dart';
import 'package:b2b_driver_app/widgets/items/branch_item.dart';
import 'package:b2b_driver_app/widgets/items/filter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StationListView extends StatelessWidget {
  const StationListView({super.key});

  @override
  Widget build(BuildContext context) {
    StationController controller = Get.find<StationController>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 41 + 16 * 2,
        ),
        child: Column(
          spacing: 16,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Input(
                      hint: "Салбар хайх",
                      controller: controller.searchController,
                      leadingIcon: SvgPicture.asset(AssetConstants.searchIcon),
                    ),
                  ),
                  SmallButton(
                    icon: SvgPicture.asset(AssetConstants.filterIcon),
                    width: 50,
                    height: 50,
                    borderRadius: 16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: GetBuilder<StationController>(
                builder: (controller) {
                  List<String> services = controller.stationServices.value;
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
                            () =>
                                controller.setSelectedService(services[index]),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 8),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GetBuilder<StationController>(
                  builder: (controller) {
                    List<StationModel> stations = controller.stations.value;
                    return controller.isLoading.value
                        ? Center(
                          child: CircularProgressIndicator(
                            color: colors(context).primary,
                          ),
                        )
                        : RefreshIndicator(
                          onRefresh: () async {
                            await controller.fetchGasStations();
                          },
                          child: ListView.separated(
                            padding: EdgeInsets.only(bottom: 16),
                            itemCount: stations.isEmpty ? 1 : stations.length,
                            itemBuilder: (context, index) {
                              if (stations.isNotEmpty) {
                                return BranchItem(station: stations[index]);
                              }
                              // If there are no stations, return an empty BranchItem
                              return Text(
                                "Салбар олдсонгүй",
                                style: Theme.of(context).textTheme.bodyMedium,
                              );
                            },
                            separatorBuilder:
                                (context, index) => SizedBox(height: 16),
                          ),
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
