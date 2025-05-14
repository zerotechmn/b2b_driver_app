import 'package:b2b_driver_app/modules/main_pages/home/components/account_limit_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/account_toggle_pin_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/allowed_petrol_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/allowed_stations_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/nearby_station_card.dart';
import 'package:b2b_driver_app/modules/main_pages/home/components/user_card.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 66,
        centerTitle: false,
        title: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey? Dulguun',
              style: textTheme(
                context,
              ).headlineSmall!.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              'Эрч хүчтэй байгаарай',
              style: textTheme(
                context,
              ).bodySmall!.copyWith(color: colors(context).labelSecondary),
            ),
          ],
        ),
      ),
      backgroundColor: colors(context).backgroundSecondary,
      body: SafeArea(
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
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: colors(context).backgroundPrimary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Өнөөдөр хийсэн гүйлгээ",
                        style: textTheme(context).bodySmall!.copyWith(
                          color: colors(context).labelSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
