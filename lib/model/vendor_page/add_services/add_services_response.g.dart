// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_services_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddServiceResponse _$AddServiceResponseFromJson(Map<String, dynamic> json) =>
    AddServiceResponse(
      data: json['data'] == null
          ? null
          : ServicesModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$AddServiceResponseToJson(AddServiceResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
