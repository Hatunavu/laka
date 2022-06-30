// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_chat_room_vendor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetChatRoomVendorResponse _$GetChatRoomVendorResponseFromJson(
        Map<String, dynamic> json) =>
    GetChatRoomVendorResponse(
      data: json['data'] as String?,
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetChatRoomVendorResponseToJson(
        GetChatRoomVendorResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
