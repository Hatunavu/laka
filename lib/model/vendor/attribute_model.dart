import 'package:json_annotation/json_annotation.dart';

part 'attribute_model.g.dart';

@JsonSerializable()
class AttributeModel {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String? image;
  final String? description;
  final int? cost;
  final int? priority;
  final String type;

  AttributeModel(
      {this.id,
      required this.name,
      this.image,
      this.description,
      this.cost,
      this.priority,
      required this.type});
  factory AttributeModel.fromJson(Map<String, dynamic> json) =>
      _$AttributeModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttributeModelToJson(this);
}

@JsonSerializable()
class SpecialAttributeModel {
  final String id;
  final String key;
  final String value;
  final String type;

  SpecialAttributeModel(
      {required this.id,
      required this.key,
      required this.value,
      required this.type});

  factory SpecialAttributeModel.fromJson(Map<String, dynamic> json) =>
      _$SpecialAttributeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialAttributeModelToJson(this);
}
