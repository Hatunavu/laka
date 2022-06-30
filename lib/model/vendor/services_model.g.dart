// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesModel _$ServicesModelFromJson(Map<String, dynamic> json) =>
    ServicesModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      details: json['details'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      note: json['note'] as String?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => AttributeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      active: json['active'] as bool?,
      status: json['status'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : ImageModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$ServicesModelToJson(ServicesModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'details': instance.details,
      'price': instance.price,
      'note': instance.note,
      'attributes': instance.attributes,
      'active': instance.active,
      'status': instance.status,
      'thumbnail': instance.thumbnail,
      'gallery': instance.gallery,
      'quantity': instance.quantity,
    };

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      path: json['path'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'path': instance.path,
      'type': instance.type,
    };
