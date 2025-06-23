import 'package:b2b_driver_app/config/assets.dart';
import 'package:b2b_driver_app/modules/main_pages/station_pages/controller.dart';
import 'package:b2b_driver_app/theme/app_theme.dart';
import 'package:b2b_driver_app/widgets/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class NearbyStationCard extends StatefulWidget {
  const NearbyStationCard({super.key});

  @override
  State<NearbyStationCard> createState() => _NearbyStationCardState();
}

class _NearbyStationCardState extends State<NearbyStationCard> {
  bool isLoading = true;
  bool permissionDenied = false;
  double? distanceKm;
  String? nearestStationName;
  Position? currentPosition;

  final stationController = Get.find<StationController>();
  late Worker stationWorker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getLocation());
    // Listen to station list changes
    stationWorker = ever(stationController.stationList, (_) {
      if (currentPosition != null) {
        findNearestStation();
      }
    });
  }

  @override
  void dispose() {
    stationWorker.dispose();
    super.dispose();
  }

  Future<void> getLocation() async {
    setState(() {
      isLoading = true;
      permissionDenied = false;
    });
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        isLoading = false;
      });
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          permissionDenied = true;
          isLoading = false;
        });
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        permissionDenied = true;
        isLoading = false;
      });
      return;
    }
    var loc = await Geolocator.getCurrentPosition();
    currentPosition = loc;
    findNearestStation();
  }

  void findNearestStation() {
    final stations = stationController.stationList.value;
    if (stations.isEmpty || currentPosition == null) {
      setState(() {
        isLoading = false;
        distanceKm = null;
        nearestStationName = null;
      });
      return;
    }
    double minDistance = double.infinity;
    String? nearestName;
    for (final station in stations) {
      if (station.lat == null || station.long == null) {
        station.distanceKm = null;
        continue;
      }
      final lat = double.tryParse(station.lat!);
      final lng = double.tryParse(station.long!);
      if (lat == null || lng == null) {
        station.distanceKm = null;
        continue;
      }
      final d = Geolocator.distanceBetween(
        currentPosition!.latitude,
        currentPosition!.longitude,
        lat,
        lng,
      );
      station.distanceKm = d.isFinite ? d / 1000 : null;
      if (d < minDistance) {
        minDistance = d;
        nearestName = station.name;
      }
    }
    setState(() {
      isLoading = false;
      distanceKm = minDistance.isFinite ? minDistance / 1000 : null;
      nearestStationName = nearestName;
    });
  }

  Future<void> refresh() async {
    await getLocation();
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
                    spacing: 16,
                    children: [
                      SvgPicture.asset(AssetConstants.locationCrosshairsIcon),
                      Text(
                        "Та байршлын тохиргоог зөвшөөрөөгүй байна",
                        style: textTheme(
                          context,
                        ).bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Button(
                        text: "Байршил заагчийг асаах",
                        onPressed: () async {
                          await Geolocator.openLocationSettings();
                          setState(() {
                            isLoading = true;
                            permissionDenied = false;
                          });
                          await getLocation();
                        },
                      ),
                    ],
                  )
                  : Column(
                    spacing: 16,
                    children: [
                      SvgPicture.asset(AssetConstants.locationCrosshairsIcon),
                      Text(
                        "Танд хамгийн ойр байрлах ШТС 😊",
                        style: textTheme(
                          context,
                        ).bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Row(
                        spacing: 16,
                        children: [
                          Flexible(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: colors(context).backgroundPrimary,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 30,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                spacing: 8,
                                children: [
                                  SvgPicture.asset(
                                    AssetConstants.locationArrowActiveIcon,
                                  ),
                                  Text(
                                    (nearestStationName != null &&
                                            distanceKm != null)
                                        ? "${distanceKm!.toStringAsFixed(1)}км"
                                        : "-",
                                    style: textTheme(context).titleMedium!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: colors(context).backgroundPrimary,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 30,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                spacing: 8,
                                children: [
                                  SvgPicture.asset(
                                    AssetConstants.timeActiveIcon,
                                  ),
                                  Text(
                                    (distanceKm != null)
                                        ? (() {
                                          final mins =
                                              ((distanceKm! / 30) * 60);
                                          if (mins >= 60) {
                                            final hours = mins / 60;
                                            return "~${hours.toStringAsFixed(1)}цаг";
                                          } else {
                                            return "~${mins.round()}мин";
                                          }
                                        })()
                                        : "-",
                                    style: textTheme(context).titleMedium!
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
    );
  }
}
