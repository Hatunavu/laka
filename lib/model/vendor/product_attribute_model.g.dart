// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAttributeModel _$ProductAttributeModelFromJson(
        Map<String, dynamic> json) =>
    ProductAttributeModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$ProductAttributeModelToJson(
        ProductAttributeModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
    };
