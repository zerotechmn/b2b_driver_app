import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/main_pages/controller.dart';
import 'package:b2b_driver_app/modules/main_pages/history/view.dart';
import 'package:b2b_driver_app/modules/main_pages/home/view.dart';
import 'package:b2b_driver_app/modules/main_pages/profile/view.dart';
import 'package:b2b_driver_app/modules/main_pages/station_pages/view.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with TickerProviderStateMixin {
  late TabController tabController;
  late HomeLayoutController controller;

  final List<Widget> _pages = [
    HomeView(),
    HistoryView(),
    StationLayout(),
    ProfileView(),
  ];

  final List<Map<String, String>> _bottomNavigations = [
    {"icon": AssetConstants.homeIcon},
    {"icon": AssetConstants.timePastIcon},
    {"icon": AssetConstants.mapLocationIcon},
    {"icon": AssetConstants.userSquareIcon},
  ];

  @override
  void initState() {
    super.initState();
    controller = Get.find<HomeLayoutController>();
    tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    tabController.addListener(() {
      controller.currentIndex.value = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: Material(
        elevation: 1,
        color: colors(context).backgroundPrimary,
        child: Obx(
          () => TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            controller: tabController,
            indicator: TopIndicator(),
            tabs:
                _bottomNavigations.map((item) {
                  return Tab(
                    icon: SvgPicture.asset(
                      item["icon"]!,
                      colorFilter:
                          controller.currentIndex.value ==
                                  _bottomNavigations.indexOf(item)
                              ? ColorFilter.mode(
                                colors(context).primary!,
                                BlendMode.srcIn,
                              )
                              : null,
                    ),
                    height: 70,
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

class TopIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox();
  }
}

class _TopIndicatorBox extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint paint =
        Paint()
          ..color = Palette.primary
          ..strokeWidth = 2
          ..isAntiAlias = true;

    canvas.drawLine(
      Offset(offset.dx, offset.dy + 1),
      Offset(cfg.size!.width + offset.dx, 1),
      paint,
    );
  }
}
