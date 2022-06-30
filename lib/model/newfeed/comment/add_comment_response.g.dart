// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentResponse _$AddCommentResponseFromJson(Map<String, dynamic> json) =>
    AddCommentResponse(
      data: AddCommentData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AddCommentResponseToJson(AddCommentResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

AddCommentData _$AddCommentDataFromJson(Map<String, dynamic> json) =>
    AddCommentData(
      post: json['post'] == null
          ? null
          : AddCommentDataPost.fromJson(json['post'] as Map<String, dynamic>),
      comment: CommentItem.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddCommentDataToJson(AddCommentData instance) =>
    <String, dynamic>{
      'post': instance.post,
      'comment': instance.comment,
    };

AddCommentDataPost _$AddCommentDataPostFromJson(Map<String, dynamic> json) =>
    AddCommentDataPost(
      id: json['_id'] as String?,
      totalComments: json['totalComments'] as int?,
    );

Map<String, dynamic> _$AddCommentDataPostToJson(AddCommentDataPost instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'totalComments': instance.totalComments,
    };
