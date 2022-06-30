// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WardResponse _$WardResponseFromJson(Map<String, dynamic> json) => WardResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WardData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$WardResponseToJson(WardResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
