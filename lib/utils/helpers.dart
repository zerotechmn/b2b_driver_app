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
