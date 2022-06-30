// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_reply_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorsReplyReviewResponse _$VendorsReplyReviewResponseFromJson(
        Map<String, dynamic> json) =>
    VendorsReplyReviewResponse(
      data: json['data'] == null
          ? null
          : ReviewModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$VendorsReplyReviewResponseToJson(
        VendorsReplyReviewResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
