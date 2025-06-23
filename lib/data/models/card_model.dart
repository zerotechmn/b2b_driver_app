import 'package:b2b_driver_app/data/models/station_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel {
  final String id;

  final String? vendorId;
  final String driverId;
  final String cardholderName;
  final String cardNumber;
  final num balance;
  final num currentLimit;
  final num maxLimit;
  final int pin;
  final List<String> products;
  final List<String> gasStationCodes;
  final List<StationModel> gasStations;

  CardModel({
    required this.id,
    required this.vendorId,
    required this.driverId,
    required this.cardholderName,
    required this.cardNumber,
    required this.balance,
    required this.currentLimit,
    required this.maxLimit,
    required this.pin,
    required this.products,
    required this.gasStationCodes,
    required this.gasStations,
  });

  /// **Factory method to create `CardModel` from JSON**
  factory CardModel.fromJson(Map<String, dynamic> json) =>
      _$CardModelFromJson(json);

  /// **Method to convert `CardModel` to JSON**
  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}
