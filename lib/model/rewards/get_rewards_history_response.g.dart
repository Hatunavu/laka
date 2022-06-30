// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_rewards_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListRewardsHistoryResponse _$GetListRewardsHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    GetListRewardsHistoryResponse(
      data: ListRewardsHistory.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$GetListRewardsHistoryResponseToJson(
        GetListRewardsHistoryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

ListRewardsHistory _$ListRewardsHistoryFromJson(Map<String, dynamic> json) =>
    ListRewardsHistory(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => RewardsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$ListRewardsHistoryToJson(ListRewardsHistory instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
