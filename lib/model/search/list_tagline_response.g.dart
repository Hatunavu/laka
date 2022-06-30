// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_tagline_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListTagLinesResponse _$ListTagLinesResponseFromJson(
        Map<String, dynamic> json) =>
    ListTagLinesResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => TaglineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$ListTagLinesResponseToJson(
        ListTagLinesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
