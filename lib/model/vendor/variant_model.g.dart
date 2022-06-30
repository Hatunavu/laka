// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantModel _$VariantModelFromJson(Map<String, dynamic> json) => VariantModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      category: json['category'] == null
          ? CategoryType.karaoke
          : stringToCategoryType(json['category'] as String),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VariantModelToJson(VariantModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'category': categoryTypeToString(instance.category),
      'image': instance.image,
      'products': instance.products,
    };
