// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_get_list_review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorsGetListReviewsResponse _$VendorsGetListReviewsResponseFromJson(
        Map<String, dynamic> json) =>
    VendorsGetListReviewsResponse(
      data: json['data'] == null
          ? null
          : VendorsGetListReviewsData.fromJson(
              json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$VendorsGetListReviewsResponseToJson(
        VendorsGetListReviewsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

VendorsGetListReviewsData _$VendorsGetListReviewsDataFromJson(
        Map<String, dynamic> json) =>
    VendorsGetListReviewsData(
      ratings: RatingModel.fromJson(json['ratings'] as Map<String, dynamic>),
      reviews: VendorsListReviewData.fromJson(
          json['reviews'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VendorsGetListReviewsDataToJson(
        VendorsGetListReviewsData instance) =>
    <String, dynamic>{
      'ratings': instance.ratings,
      'reviews': instance.reviews,
    };

VendorsListReviewData _$VendorsListReviewDataFromJson(
        Map<String, dynamic> json) =>
    VendorsListReviewData(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$VendorsListReviewDataToJson(
        VendorsListReviewData instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
