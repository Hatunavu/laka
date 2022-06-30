// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['_id'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      productOptions: (json['productOptions'] as List<dynamic>?)
          ?.map((e) => ProductOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      vendor: json['vendor'] == null
          ? null
          : Vendor.fromJson(json['vendor'] as Map<String, dynamic>),
      totalPeople: json['totalPeople'] as int?,
      status: stringToBookingStatus(json['status'] as String),
      orderAt: json['orderAt'] as String?,
      note: json['note'] as String?,
      totalPrice: json['totalPrice'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      orderId: json['orderId'] as String?,
      chatRoomId: json['chatRoomId'] as String?,
      review: json['review'] == null
          ? null
          : ReviewModel.fromJson(json['review'] as Map<String, dynamic>),
      receipt: json['receipt'] == null
          ? null
          : ReceiptModel.fromJson(json['receipt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'productOptions': instance.productOptions,
      'vendor': instance.vendor,
      'totalPeople': instance.totalPeople,
      'status': bookingStatusToString(instance.status),
      'orderAt': instance.orderAt,
      'note': instance.note,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'orderId': instance.orderId,
      'chatRoomId': instance.chatRoomId,
      'review': instance.review,
      'receipt': instance.receipt,
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      createdAt: json['createdAt'] as String?,
      id: json['_id'] as String?,
      content: json['content'] as String?,
      reviewer: json['reviewer'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'reviewer': instance.reviewer,
      'rating': instance.rating,
      'createdAt': instance.createdAt,
      'gallery': instance.gallery,
    };
