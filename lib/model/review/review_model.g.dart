// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['_id'] as String?,
      content: json['content'] as String?,
      order: json['order'] == null
          ? null
          : ReviewOrderModel.fromJson(json['order'] as Map<String, dynamic>),
      reviewer: json['reviewer'] == null
          ? null
          : AccountModel.fromJson(json['reviewer'] as Map<String, dynamic>),
      rating: (json['rating'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      response: json['response'] == null
          ? null
          : ReplyResponseModel.fromJson(
              json['response'] as Map<String, dynamic>),
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'order': instance.order,
      'reviewer': instance.reviewer,
      'rating': instance.rating,
      'gallery': instance.gallery,
      'response': instance.response,
      'createdAt': instance.createdAt.toIso8601String(),
    };

ReviewOrderModel _$ReviewOrderModelFromJson(Map<String, dynamic> json) =>
    ReviewOrderModel(
      id: json['_id'] as String?,
      status: stringToBookingStatus(json['status'] as String),
      orderId: json['orderId'] as String,
      product:
          OrderProductModel.fromJson(json['product'] as Map<String, dynamic>),
      chatRoomId: json['chatRoomId'] as String,
    );

Map<String, dynamic> _$ReviewOrderModelToJson(ReviewOrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'orderId': instance.orderId,
      'status': bookingStatusToString(instance.status),
      'product': instance.product,
      'chatRoomId': instance.chatRoomId,
    };

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
    };

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
      star_1: json['1'] as int,
      star_2: json['2'] as int,
      star_3: json['3'] as int,
      star_4: json['4'] as int,
      star_5: json['5'] as int,
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      '1': instance.star_1,
      '2': instance.star_2,
      '3': instance.star_3,
      '4': instance.star_4,
      '5': instance.star_5,
    };

ReplyResponseModel _$ReplyResponseModelFromJson(Map<String, dynamic> json) =>
    ReplyResponseModel(
      id: json['_id'] as String?,
      content: json['content'] as String,
      by: VendorInfoModel.fromJson(json['by'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReplyResponseModelToJson(ReplyResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'by': instance.by,
    };
