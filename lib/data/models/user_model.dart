import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;

  final String firstName;
  final String lastName;
  final String phone;
  final String vendorId;
  final String registerNumber;
  final String carNumber;
  final String? cardId;
  final VendorModel? vendor;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.vendorId,
    required this.registerNumber,
    required this.carNumber,
    this.cardId,
    this.vendor,
  });

  /// **Factory method to create `UserModel` from JSON**
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// **Method to convert `UserModel` to JSON**
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class VendorModel {
  final String id;
  final String name;
  final num balance;
  final String code;
  final String register;
  final String status;

  VendorModel({
    required this.name,
    required this.id,
    required this.balance,
    required this.code,
    required this.register,
    required this.status,
  });

  /// **Factory method to create `VendorModel` from JSON**
  factory VendorModel.fromJson(Map<String, dynamic> json) =>
      _$VendorModelFromJson(json);

  /// **Method to convert `VendorModel` to JSON**
  Map<String, dynamic> toJson() => _$VendorModelToJson(this);
}
