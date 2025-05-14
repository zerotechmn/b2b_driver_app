import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class NearbyStationCard extends StatelessWidget {
  const NearbyStationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 153,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colors(context).backgroundPrimary,
      ),
    );
  }
}
