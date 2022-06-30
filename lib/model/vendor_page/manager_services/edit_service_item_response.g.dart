// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_service_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditServiceItemResponse _$EditServiceItemResponseFromJson(
        Map<String, dynamic> json) =>
    EditServiceItemResponse(
      data: json['data'] == null
          ? null
          : ServicesModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$EditServiceItemResponseToJson(
        EditServiceItemResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
