import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String id;

  final String firstName;
  final String lastName;
  final String phone;
  final String vendorId;
  final String registerNumber;
  final String carNumber;
  final String cardId;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.vendorId,
    required this.registerNumber,
    required this.carNumber,
    required this.cardId,
  });

  /// **Factory method to create `User` from JSON**
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// **Method to convert `User` to JSON**
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Vendor {
  final String id;
  final String name;
  final num balance;
  final String code;
  final String register;
  final String status;

  Vendor({
    required this.name,
    required this.id,
    required this.balance,
    required this.code,
    required this.register,
    required this.status,
  });

  /// **Factory method to create `User` from JSON**
  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);

  /// **Method to convert `Vendor` to JSON**
  Map<String, dynamic> toJson() => _$VendorToJson(this);
}
