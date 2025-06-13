import 'package:b2b_driver_app/modules/main_pages/station_pages/controller.dart';
import 'package:b2b_driver_app/widgets/bottom_sheets/map_branch_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';

class StationMapView extends StatefulWidget {
  const StationMapView({super.key});

  @override
  State<StationMapView> createState() => _StationMapViewState();
}

class _StationMapViewState extends State<StationMapView> {
  TextEditingController searchController = TextEditingController();
  MapController controller = MapController(
    initPosition: GeoPoint(latitude: 47.9094, longitude: 106.8819),
  );

  final stationController = Get.find<StationController>();
  List<GeoPoint> markerPoints = [];

  @override
  void initState() {
    super.initState();
    searchController.text = stationController.searchInput.value;
    searchController.addListener(() {
      stationController.setSearchInput(searchController.text);
    });
    ever(stationController.stations, (stations) async {
      // Remove existing markers if needed
      if (markerPoints.isNotEmpty) {
        await controller.removeMarkers(markerPoints);
      }
      markerPoints.clear();
      // Add new markers
      for (final station in stations) {
        if (station.lat == null ||
            station.lat!.isEmpty ||
            station.long == null ||
            station.long!.isEmpty) {
          continue;
        }
        final point = GeoPoint(
          latitude: double.parse(station.lat!),
          longitude: double.parse(station.long!),
        );
        markerPoints.add(point);
        debugPrint(
          "Adding marker for station: ${station.name} at (${station.lat}, ${station.long})",
        );
        controller.addMarker(
          point,
          markerIcon: MarkerIcon(
            icon: Icon(Icons.local_gas_station, color: Colors.blue, size: 40),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OSMFlutter(
        controller: controller,
        osmOption: OSMOption(
          userTrackingOption: const UserTrackingOption(
            enableTracking: false,
            unFollowUser: false,
          ),
          zoomOption: const ZoomOption(
            initZoom: 10,
            minZoomLevel: 4,
            maxZoomLevel: 19,
            stepZoom: 1.0,
          ),
          userLocationMarker: UserLocationMaker(
            personMarker: const MarkerIcon(
              icon: Icon(
                Icons.location_history_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            directionArrowMarker: const MarkerIcon(
              icon: Icon(Icons.double_arrow, size: 48),
            ),
          ),
          roadConfiguration: const RoadOption(roadColor: Colors.yellowAccent),
        ),
      ),
      bottomSheet: MapBranchSheet(
        onCenterMap: (point) {
          controller.moveTo(point);
        },
      ),
    );
  }
}
