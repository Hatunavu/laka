// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageItemModel _$MessageItemModelFromJson(Map<String, dynamic> json) =>
    MessageItemModel(
      id: json['_id'] as String,
      content: json['content'] as String?,
      by: AccountModel.fromJson(json['by'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isSender: json['isSender'] as bool?,
    );

Map<String, dynamic> _$MessageItemModelToJson(MessageItemModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'by': instance.by,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isSender': instance.isSender,
    };

SocketMessageResponse _$SocketMessageResponseFromJson(
        Map<String, dynamic> json) =>
    SocketMessageResponse(
      message:
          MessageItemModel.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SocketMessageResponseToJson(
        SocketMessageResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
