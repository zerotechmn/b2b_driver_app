import 'dart:math';

import 'package:b2b_driver_app/theme/palette.dart';
import 'package:b2b_driver_app/utils/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

T parseOrThrow<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic>) fromJson,
) {
  try {
    return fromJson(json);
  } catch (e) {
    if (e is Error) {
      debugPrint("Parsing error: $e stack: ${e.stackTrace}");
    }
    throw AppException(
      "Алдаа гарсан тул та хэсэг хугацааны дараа дахин оролдоно уу",
    );
  }
}

List<T> parseListOrThrow<T>(
  List<dynamic> jsonList,
  T Function(Map<String, dynamic>) fromJson,
) {
  try {
    return jsonList
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    if (e is Error) {
      debugPrint("Parsing list error: $e stack: ${e.stackTrace}");
    }
    throw AppException(
      "Алдаа гарсан тул та хэсэг хугацааны дараа дахин оролдоно уу",
    );
  }
}

void showLoadingDialog() {
  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  Future.delayed(Duration.zero, () {
    if (Get.isDialogOpen == false) {
      Get.dialog(
        Center(
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color:
                  brightness == Brightness.dark ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(24),
            child: CircularProgressIndicator(
              color: Palette.primary,
              backgroundColor: Palette.background[200],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      // Auto-close the dialog after 10 seconds if still open
      Future.delayed(const Duration(seconds: 10), () {
        if (Get.isDialogOpen == true) {
          Get.back(); // closes the dialog
        }
      });
    }
  });
}

void hideLoadingDialog() {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
}

double calculateDistanceInKm(
  double lat1,
  double lon1,
  double lat2,
  double lon2,
) {
  const double earthRadius = 6371; // Radius of Earth in kilometers

  final double dLat = _degreesToRadians(lat2 - lat1);
  final double dLon = _degreesToRadians(lon2 - lon1);

  final double a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) *
          cos(_degreesToRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final double distance = earthRadius * c;

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}
