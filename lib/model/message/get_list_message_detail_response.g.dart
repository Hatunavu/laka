// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_message_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListMessageDetailResponse _$GetListMessageDetailResponseFromJson(
        Map<String, dynamic> json) =>
    GetListMessageDetailResponse(
      data: MessagesDetailData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetListMessageDetailResponseToJson(
        GetListMessageDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

MessagesDetailData _$MessagesDetailDataFromJson(Map<String, dynamic> json) =>
    MessagesDetailData(
      messages:
          MessageeDetailDocs.fromJson(json['messages'] as Map<String, dynamic>),
      roomInfo:
          MessageeRoomInfo.fromJson(json['roomInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessagesDetailDataToJson(MessagesDetailData instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'roomInfo': instance.roomInfo,
    };

MessageeRoomInfo _$MessageeRoomInfoFromJson(Map<String, dynamic> json) =>
    MessageeRoomInfo(
      id: json['_id'] as String,
      accounts: (json['accounts'] as List<dynamic>)
          .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      ref: json['ref'] == null
          ? null
          : BookingItemModel.fromJson(json['ref'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageeRoomInfoToJson(MessageeRoomInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'accounts': instance.accounts,
      'type': instance.type,
      'ref': instance.ref,
    };

MessageeDetailDocs _$MessageeDetailDocsFromJson(Map<String, dynamic> json) =>
    MessageeDetailDocs(
      docs: (json['docs'] as List<dynamic>)
          .map((e) => MessageItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$MessageeDetailDocsToJson(MessageeDetailDocs instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
