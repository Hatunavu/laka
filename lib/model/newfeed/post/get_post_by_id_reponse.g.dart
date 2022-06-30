// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_by_id_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostByIdResponse _$GetPostByIdResponseFromJson(Map<String, dynamic> json) =>
    GetPostByIdResponse(
      data: PostModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetPostByIdResponseToJson(
        GetPostByIdResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
