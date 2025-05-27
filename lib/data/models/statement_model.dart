import 'package:json_annotation/json_annotation.dart';

part 'statement_model.g.dart';

@JsonSerializable()
class StatementModel {
  final String id;

  final String cardId;
  final String? userId;
  final String vendorId;
  final String statementTypeEnum;
  final num amount;
  final num from;
  final num to;
  final DateTime createdAt;

  StatementModel({
    required this.id,
    required this.cardId,
    this.userId,
    required this.vendorId,
    required this.statementTypeEnum,
    required this.amount,
    required this.from,
    required this.to,
    required this.createdAt,
  });

  /// **Factory method to create `StatementModel` from JSON**
  factory StatementModel.fromJson(Map<String, dynamic> json) =>
      _$StatementModelFromJson(json);

  /// **Method to convert `StatementModel` to JSON**
  Map<String, dynamic> toJson() => _$StatementModelToJson(this);
}
