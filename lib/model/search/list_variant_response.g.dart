// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_variant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListVariantResponse _$ListVariantResponseFromJson(Map<String, dynamic> json) =>
    ListVariantResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => VariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$ListVariantResponseToJson(
        ListVariantResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
