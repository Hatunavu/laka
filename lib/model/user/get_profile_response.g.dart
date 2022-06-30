// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileResponse _$GetProfileResponseFromJson(Map<String, dynamic> json) =>
    GetProfileResponse(
      data: json['data'] == null
          ? null
          : GetProfileData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$GetProfileResponseToJson(GetProfileResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

GetProfileData _$GetProfileDataFromJson(Map<String, dynamic> json) =>
    GetProfileData(
      account: json['account'] == null
          ? null
          : AccountModel.fromJson(json['account'] as Map<String, dynamic>),
      countPendingOrders: json['countPendingOrders'] as int?,
      countUnreadNotifications: json['countUnreadNotifications'] as int?,
      currentOrder: json['currentOrder'] == null
          ? null
          : BookingItemModel.fromJson(
              json['currentOrder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetProfileDataToJson(GetProfileData instance) =>
    <String, dynamic>{
      'account': instance.account,
      'countPendingOrders': instance.countPendingOrders,
      'countUnreadNotifications': instance.countUnreadNotifications,
      'currentOrder': instance.currentOrder,
    };
