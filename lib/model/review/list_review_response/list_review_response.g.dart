// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListReviewResponse _$ListReviewResponseFromJson(Map<String, dynamic> json) =>
    ListReviewResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$ListReviewResponseToJson(ListReviewResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
