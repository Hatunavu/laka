// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_affiliate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListAffiliateResponse _$GetListAffiliateResponseFromJson(
        Map<String, dynamic> json) =>
    GetListAffiliateResponse(
      data: ListAffiliateData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetListAffiliateResponseToJson(
        GetListAffiliateResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

ListAffiliateData _$ListAffiliateDataFromJson(Map<String, dynamic> json) =>
    ListAffiliateData(
      firstLevels: (json['firstLevels'] as List<dynamic>)
          .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      secondLevels: (json['secondLevels'] as List<dynamic>)
          .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalFirsts: json['totalFirsts'] as int,
      totalSeconds: json['totalSeconds'] as int,
    );

Map<String, dynamic> _$ListAffiliateDataToJson(ListAffiliateData instance) =>
    <String, dynamic>{
      'firstLevels': instance.firstLevels,
      'secondLevels': instance.secondLevels,
      'totalFirsts': instance.totalFirsts,
      'totalSeconds': instance.totalSeconds,
    };
