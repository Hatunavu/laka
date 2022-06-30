// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_vendor_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVendorProfileResponse _$GetVendorProfileResponseFromJson(
        Map<String, dynamic> json) =>
    GetVendorProfileResponse(
      data: json['data'] == null
          ? null
          : GetProfileData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$GetVendorProfileResponseToJson(
        GetVendorProfileResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

GetProfileData _$GetProfileDataFromJson(Map<String, dynamic> json) =>
    GetProfileData(
      account: json['account'] == null
          ? null
          : VendorInfoModel.fromJson(json['account'] as Map<String, dynamic>),
      countPendingOrders: json['countPendingOrders'] as int?,
      countUnreadNotifications: json['countUnreadNotifications'] as int?,
    );

Map<String, dynamic> _$GetProfileDataToJson(GetProfileData instance) =>
    <String, dynamic>{
      'account': instance.account,
      'countPendingOrders': instance.countPendingOrders,
      'countUnreadNotifications': instance.countUnreadNotifications,
    };
