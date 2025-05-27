import 'package:b2b_driver_app/modules/main_pages/home/components/account_history_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/account_limit_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/account_toggle_pin_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/allowed_petrol_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/allowed_stations_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/nearby_station_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/user_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/appbars/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    return Scaffold(
      appBar: getHomeAppBar(context),
      backgroundColor: colors(context).backgroundSecondary,
      body: RefreshIndicator(
        onRefresh: () => controller.fetchCardDetail(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              children: [
                UserCard(),
                NearbyStationCard(),
                AccountTogglePinCard(),
                AccountLimitCard(),
                AllowedPetrolCard(),
                AllowedStationsCard(),
                AccountHistoryCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
