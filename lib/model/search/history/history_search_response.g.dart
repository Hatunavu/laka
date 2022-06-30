// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistorySearchResponse _$HistorySearchResponseFromJson(
        Map<String, dynamic> json) =>
    HistorySearchResponse(
      data: json['data'] == null
          ? null
          : HistorySearchData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$HistorySearchResponseToJson(
        HistorySearchResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

HistorySearchData _$HistorySearchDataFromJson(Map<String, dynamic> json) =>
    HistorySearchData(
      searches: (json['searches'] as List<dynamic>?)
          ?.map((e) => HistorySearchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      suggestedVendors: (json['suggestedVendors'] as List<dynamic>)
          .map((e) => VendorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistorySearchDataToJson(HistorySearchData instance) =>
    <String, dynamic>{
      'searches': instance.searches,
      'suggestedVendors': instance.suggestedVendors,
    };

HistorySearchModel _$HistorySearchModelFromJson(Map<String, dynamic> json) =>
    HistorySearchModel(
      id: json['_id'] as String,
      account: json['account'] as String,
      t: json['t'] as String,
    );

Map<String, dynamic> _$HistorySearchModelToJson(HistorySearchModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'account': instance.account,
      't': instance.t,
    };
