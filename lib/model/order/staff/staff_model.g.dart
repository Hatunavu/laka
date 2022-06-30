// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffModel _$StaffModelFromJson(Map<String, dynamic> json) => StaffModel(
      id: json['_id'] as String,
      image: json['image'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$StaffModelToJson(StaffModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'status': instance.status,
      'description': instance.description,
    };
