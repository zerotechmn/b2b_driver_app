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
  final List<StationProductModel>? products;
  final StationAdditionalInfoModel? additionalInfo;

  @JsonKey(ignore: true)
  double? distanceKm;

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
    this.products,
    this.additionalInfo,
  });

  /// **Factory method to create `StationModel` from JSON**
  factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);

  /// **Method to convert `StationModel` to JSON**
  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}

@JsonSerializable()
class StationProductModel {
  final String type;
  final String productId;
  final String productCode;
  final String productName;
  final num price;
  final String barcode;

  StationProductModel({
    required this.type,
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.price,
    required this.barcode,
  });

  /// **Factory method to create `StationProductModel` from JSON**
  factory StationProductModel.fromJson(Map<String, dynamic> json) =>
      _$StationProductModelFromJson(json);

  /// **Method to convert `StationProductModel` to JSON**
  Map<String, dynamic> toJson() => _$StationProductModelToJson(this);
}

@JsonSerializable()
class StationAdditionalInfoModel {
  final String workingHours;
  final String additionalServices;
  final String? aimagHot;
  final String? duuregSum;

  StationAdditionalInfoModel({
    required this.workingHours,
    required this.additionalServices,
    this.aimagHot,
    this.duuregSum,
  });

  /// **Factory method to create `StationAdditionalInfoModel` from JSON**
  factory StationAdditionalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$StationAdditionalInfoModelFromJson(json);

  /// **Method to convert `StationAdditionalInfoModel` to JSON**
  Map<String, dynamic> toJson() => _$StationAdditionalInfoModelToJson(this);
}
