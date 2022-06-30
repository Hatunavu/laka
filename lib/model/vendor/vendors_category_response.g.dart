// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorListCategoryResponse _$VendorListCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    VendorListCategoryResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => VendorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$VendorListCategoryResponseToJson(
        VendorListCategoryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
