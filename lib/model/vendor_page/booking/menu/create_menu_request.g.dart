// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_menu_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMenuRequest _$CreateMenuRequestFromJson(Map<String, dynamic> json) =>
    CreateMenuRequest(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CreateMenuRequestToJson(CreateMenuRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'description': instance.description,
    };
