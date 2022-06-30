// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_option_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailOptionResponse _$DetailOptionResponseFromJson(
        Map<String, dynamic> json) =>
    DetailOptionResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$DetailOptionResponseToJson(
        DetailOptionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
