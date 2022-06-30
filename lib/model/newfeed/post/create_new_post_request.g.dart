// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewPostRequest _$CreateNewPostRequestFromJson(
        Map<String, dynamic> json) =>
    CreateNewPostRequest(
      content: json['content'] as String,
      media:
          (json['media'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => TagsRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      uploadMedia: (json['uploadMedia'] as List<dynamic>?)
          ?.map((e) => UploadMediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateNewPostRequestToJson(
        CreateNewPostRequest instance) =>
    <String, dynamic>{
      'content': instance.content,
      'media': instance.media,
      'tags': instance.tags,
      'uploadMedia': instance.uploadMedia,
    };

UploadMediaModel _$UploadMediaModelFromJson(Map<String, dynamic> json) =>
    UploadMediaModel(
      width: json['width'] as int?,
      height: json['height'] as int?,
      url: json['url'] as String,
    );

Map<String, dynamic> _$UploadMediaModelToJson(UploadMediaModel instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };

TagsRequest _$TagsRequestFromJson(Map<String, dynamic> json) => TagsRequest(
      type: json['type'] as String,
      vendor: json['vendor'] as String,
    );

Map<String, dynamic> _$TagsRequestToJson(TagsRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'vendor': instance.vendor,
    };
