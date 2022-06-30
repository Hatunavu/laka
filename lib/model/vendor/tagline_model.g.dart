// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tagline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaglineModel _$TaglineModelFromJson(Map<String, dynamic> json) => TaglineModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      priority: json['priority'] as int?,
      type: json['type'] as String,
    );

Map<String, dynamic> _$TaglineModelToJson(TaglineModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'priority': instance.priority,
      'type': instance.type,
    };
