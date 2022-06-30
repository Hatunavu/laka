// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReviewResponse _$CreateReviewResponseFromJson(
        Map<String, dynamic> json) =>
    CreateReviewResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$CreateReviewResponseToJson(
        CreateReviewResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
