// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      priority: json['priority'] as int?,
      type: json['type'] as String?,
      cost: json['cost'] as int?,
      id: json['_id'] as String?,
      isSelect: json['isSelect'] as bool? ?? false,
      quantity: json['quantity'] as int? ?? 0,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'priority': instance.priority,
      'type': instance.type,
      'cost': instance.cost,
      '_id': instance.id,
      'isSelect': instance.isSelect,
      'quantity': instance.quantity,
    };
