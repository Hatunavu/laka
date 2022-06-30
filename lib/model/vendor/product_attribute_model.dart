import 'package:json_annotation/json_annotation.dart';

part 'product_attribute_model.g.dart';

@JsonSerializable()
class ProductAttributeModel {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String description;
  final String type;

  ProductAttributeModel(
      {this.id,
      required this.name,
      required this.description,
      required this.type});

  factory ProductAttributeModel.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAttributeModelToJson(this);
}
