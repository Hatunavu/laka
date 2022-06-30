// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_message_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMessageItemResponse _$AddMessageItemResponseFromJson(
        Map<String, dynamic> json) =>
    AddMessageItemResponse(
      data: MessageItemModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AddMessageItemResponseToJson(
        AddMessageItemResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
