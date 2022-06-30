// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_staff_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateStaffResponse _$CreateStaffResponseFromJson(Map<String, dynamic> json) =>
    CreateStaffResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
      data: json['data'] == null
          ? null
          : StaffModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateStaffResponseToJson(
        CreateStaffResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
