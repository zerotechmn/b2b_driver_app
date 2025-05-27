import 'package:json_annotation/json_annotation.dart';

part 'station_model.g.dart';

@JsonSerializable()
class StationModel {
  final String id;

  final int gasStationId;
  final String shtsCode;
  final String name;
  final String? address;
  final String? lat;
  final String? long;
  final String? phone;
  final String? companyId;
  final bool? isOilCenter;
  final bool? isShtsGas;

  StationModel({
    required this.id,
    required this.gasStationId,
    required this.shtsCode,
    required this.name,
    this.address,
    this.lat,
    this.long,
    this.phone,
    this.companyId,
    this.isOilCenter,
    this.isShtsGas,
  });

  /// **Factory method to create `StationModel` from JSON**
  factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);

  /// **Method to convert `StationModel` to JSON**
  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}
