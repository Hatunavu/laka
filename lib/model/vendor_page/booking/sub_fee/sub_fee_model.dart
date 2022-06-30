import 'package:json_annotation/json_annotation.dart';

part 'sub_fee_model.g.dart';

@JsonSerializable()
class SubFeeModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final double price;
  String? note;

  SubFeeModel({
    required this.id,
    required this.name,
    required this.price,
    this.note,
  });

  factory SubFeeModel.fromJson(Map<String, dynamic> json) =>
      _$SubFeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubFeeModelToJson(this);
}
