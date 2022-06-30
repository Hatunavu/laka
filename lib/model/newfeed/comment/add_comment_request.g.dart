// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCommentRequest _$AddCommentRequestFromJson(Map<String, dynamic> json) =>
    AddCommentRequest(
      content: json['content'] as String?,
      media:
          (json['media'] as List<dynamic>?)?.map((e) => e as String).toList(),
      parent: json['parent'] as String?,
    );

Map<String, dynamic> _$AddCommentRequestToJson(AddCommentRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'media': instance.media,
      'parent': instance.parent,
    };
