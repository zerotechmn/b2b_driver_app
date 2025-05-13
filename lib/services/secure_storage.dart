import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageService extends GetxService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Read a string value
  Future<String?> readString(String key) async {
    return await storage.read(key: key);
  }

  /// Read an integer value
  Future<int?> readInt(String key) async {
    String? value = await storage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  /// Read a boolean value
  Future<bool> readBool(String key) async {
    String? value = await storage.read(key: key);
    return value == "true";
  }

  /// Save JSON model data
  Future<void> writeJson<T>(String key, T model) async {
    String jsonString = jsonEncode(model);
    await storage.write(key: key, value: jsonString);
  }

  /// Read JSON model data
  Future<T?> readJson<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    String? jsonString = await storage.read(key: key);
    if (jsonString == null) return null;
    return fromJson(jsonDecode(jsonString));
  }

  /// Write a string value
  Future<void> writeString(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  /// Write an integer value
  Future<void> writeInt(String key, int value) async {
    await storage.write(key: key, value: value.toString());
  }

  /// Write a boolean value
  Future<void> writeBool(String key, bool value) async {
    await storage.write(key: key, value: value.toString());
  }

  /// Delete all stored values
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
