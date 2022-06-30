// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_post_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewPostResponse _$CreateNewPostResponseFromJson(
        Map<String, dynamic> json) =>
    CreateNewPostResponse(
      data: json['data'] == null
          ? null
          : PostData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CreateNewPostResponseToJson(
        CreateNewPostResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

PostData _$PostDataFromJson(Map<String, dynamic> json) => PostData(
      content: json['content'] as String?,
      medias: (json['medias'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostDataToJson(PostData instance) => <String, dynamic>{
      'content': instance.content,
      'medias': instance.medias,
    };
