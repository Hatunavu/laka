// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_menu_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMenuResponse _$CreateMenuResponseFromJson(Map<String, dynamic> json) =>
    CreateMenuResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
      data: json['data'] == null
          ? null
          : MenuModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateMenuResponseToJson(CreateMenuResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
