import 'package:b2b_driver_app/utils/exceptions.dart';
import 'package:flutter/cupertino.dart';

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
