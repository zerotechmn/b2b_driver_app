import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class NearbyStationCard extends StatefulWidget {
  const NearbyStationCard({super.key});

  @override
  State<NearbyStationCard> createState() => _NearbyStationCardState();
}

class _NearbyStationCardState extends State<NearbyStationCard> {
  bool isLoading = true;
  bool permissionDenied = false;

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
        permissionDenied = true;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      permissionDenied = true;
    }

    var loc = await Geolocator.getCurrentPosition();
    debugPrint(loc.latitude.toString());
    debugPrint(loc.longitude.toString());
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
      padding: EdgeInsets.all(16),
      child:
          isLoading
              ? Center(
                child: CircularProgressIndicator(
                  color: colors(context).primary,
                ),
              )
              : (permissionDenied
                  ? Column(
                    children: [
                      Text("Та байршлын тохиргоог зөвшөөрөөгүй байна"),
                    ],
                  )
                  : null),
    );
  }
}
