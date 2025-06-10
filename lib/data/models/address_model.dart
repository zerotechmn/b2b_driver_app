import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final String? code;
  final String name;
  final List<AddressModel>? children;

  AddressModel({required this.code, required this.name, this.children});

  /// **Factory method to create `AddressModel` from JSON**
  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  /// **Method to convert `AddressModel` to JSON**
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
