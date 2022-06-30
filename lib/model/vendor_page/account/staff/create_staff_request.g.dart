// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_staff_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateStaffRequest _$CreateStaffRequestFromJson(Map<String, dynamic> json) =>
    CreateStaffRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
      image: json['image'] as String,
    );

Map<String, dynamic> _$CreateStaffRequestToJson(CreateStaffRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
    };
