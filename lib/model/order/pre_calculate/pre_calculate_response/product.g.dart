// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      vendor: json['vendor'] == null
          ? null
          : VendorModel.fromJson(json['vendor'] as Map<String, dynamic>),
      details: json['details'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      price: json['price'] as int?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      active: json['active'] as bool?,
      status: json['status'] as String?,
      quantity: json['quantity'] as int?,
      gallery: json['gallery'] as List<dynamic>?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'vendor': instance.vendor,
      'details': instance.details,
      'thumbnail': instance.thumbnail,
      'price': instance.price,
      'attributes': instance.attributes,
      'active': instance.active,
      'status': instance.status,
      'quantity': instance.quantity,
      'gallery': instance.gallery,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
