import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class StationMapView extends StatelessWidget {
  const StationMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: OSMFlutter(
          controller: MapController(
            initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
          ),
          osmOption: OSMOption(
            userTrackingOption: const UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
            ),
            zoomOption: const ZoomOption(
              initZoom: 8,
              minZoomLevel: 3,
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
      ),
    );
  }
}
