// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_attribute_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListAttributeResponse _$GetListAttributeResponseFromJson(
        Map<String, dynamic> json) =>
    GetListAttributeResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AttributeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$GetListAttributeResponseToJson(
        GetListAttributeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
