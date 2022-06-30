// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doc _$DocFromJson(Map<String, dynamic> json) => Doc(
      id: json['_id'] as String?,
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
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
      receiptImages: (json['receiptImages'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      review: json['review'] == null
          ? null
          : ReviewModel.fromJson(json['review'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DocToJson(Doc instance) => <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'vendor': instance.vendor,
      'totalPeople': instance.totalPeople,
      'status': bookingStatusToString(instance.status),
      'orderAt': instance.orderAt,
      'note': instance.note,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'orderId': instance.orderId,
      'receiptImages': instance.receiptImages,
      'review': instance.review,
    };
