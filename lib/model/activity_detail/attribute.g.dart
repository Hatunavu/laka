// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      priority: json['priority'] as int?,
      type: json['type'] as String?,
      cost: json['cost'] as int?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'priority': instance.priority,
      'type': instance.type,
      'cost': instance.cost,
      '_id': instance.id,
    };
