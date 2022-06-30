import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variant_model.g.dart';

@JsonSerializable()
class VariantModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(
      name: 'category',
      fromJson: stringToCategoryType,
      toJson: categoryTypeToString,
      defaultValue: CategoryType.karaoke)
  final CategoryType category;
  final String? image;
  final List<ServicesModel>? products;

  VariantModel(
      {required this.id,
      required this.name,
      this.image,
      required this.category,
      this.products});
  factory VariantModel.fromJson(Map<String, dynamic> json) =>
      _$VariantModelFromJson(json);

  Map<String, dynamic> toJson() => _$VariantModelToJson(this);
}
