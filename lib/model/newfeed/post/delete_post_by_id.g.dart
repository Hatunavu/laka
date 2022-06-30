// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_post_by_id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeletePostByIdResponse _$DeletePostByIdResponseFromJson(
        Map<String, dynamic> json) =>
    DeletePostByIdResponse(
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeletePostByIdResponseToJson(
        DeletePostByIdResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
