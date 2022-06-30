// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_screen_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorsScreenResponse _$VendorsScreenResponseFromJson(
        Map<String, dynamic> json) =>
    VendorsScreenResponse(
      data: VendorsScreenResponseData.fromJson(
          json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$VendorsScreenResponseToJson(
        VendorsScreenResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

VendorsScreenResponseData _$VendorsScreenResponseDataFromJson(
        Map<String, dynamic> json) =>
    VendorsScreenResponseData(
      hotVendors: (json['hotVendors'] as List<dynamic>)
          .map((e) => VendorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      suggestedVendors: (json['suggestedVendors'] as List<dynamic>)
          .map((e) => VendorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VendorsScreenResponseDataToJson(
        VendorsScreenResponseData instance) =>
    <String, dynamic>{
      'hotVendors': instance.hotVendors,
      'suggestedVendors': instance.suggestedVendors,
    };
