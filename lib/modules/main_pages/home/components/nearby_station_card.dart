import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NearbyStationCard extends StatefulWidget {
  const NearbyStationCard({super.key});

  @override
  State<NearbyStationCard> createState() => _NearbyStationCardState();
}

class _NearbyStationCardState extends State<NearbyStationCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getLocation());
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    var loc = await Geolocator.getCurrentPosition();
    debugPrint(loc.latitude.toString());
  }

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
