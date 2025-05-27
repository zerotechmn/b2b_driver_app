import 'package:json_annotation/json_annotation.dart';

part 'api_model.g.dart';

@JsonSerializable()
class ApiModel {
  final dynamic data;
  final String? message;
  final String? code;

  ApiModel({this.data, this.message, this.code});

  factory ApiModel.fromJson(Map<String, dynamic> json) =>
      _$ApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiModelToJson(this);
}
