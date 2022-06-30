// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      details: json['details'] as String?,
      gallery: json['gallery'] as List<dynamic>?,
      price: json['price'] as int?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      active: json['active'] as bool?,
      status: json['status'] as String?,
      quantity: json['quantity'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'details': instance.details,
      'gallery': instance.gallery,
      'price': instance.price,
      'attributes': instance.attributes,
      'active': instance.active,
      'status': instance.status,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
