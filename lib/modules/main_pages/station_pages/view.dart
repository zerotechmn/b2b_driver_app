import 'package:b2b_driver_app/modules/main_pages/station_pages/controller.dart';
import 'package:b2b_driver_app/modules/main_pages/station_pages/list/view.dart';
import 'package:b2b_driver_app/modules/main_pages/station_pages/map/view.dart';
import 'package:b2b_driver_app/widgets/segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StationLayout extends StatelessWidget {
  StationLayout({super.key});

  final List<Widget> _pages = [StationMapView(), StationListView()];

  @override
  Widget build(BuildContext context) {
    StationController controller = Get.find<StationController>();
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => IndexedStack(
              index: controller.tabIndex.value,
              children: _pages,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 16,
              right: 16,
            ),
            child: Obx(
              () => CustomSegmentedControl(
                segments: ["Газрын зураг", "Жагсаалт"],
                currentIndex: controller.tabIndex.value,
                onChange: (index) {
                  controller.tabIndex.value = index;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
