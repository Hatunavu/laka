// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttributeModel _$AttributeModelFromJson(Map<String, dynamic> json) =>
    AttributeModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      image: json['image'] as String?,
      description: json['description'] as String?,
      cost: json['cost'] as int?,
      priority: json['priority'] as int?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$AttributeModelToJson(AttributeModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'cost': instance.cost,
      'priority': instance.priority,
      'type': instance.type,
    };

SpecialAttributeModel _$SpecialAttributeModelFromJson(
        Map<String, dynamic> json) =>
    SpecialAttributeModel(
      id: json['id'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$SpecialAttributeModelToJson(
        SpecialAttributeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
    };
