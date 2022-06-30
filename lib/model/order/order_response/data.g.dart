// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      vendor: json['vendor'] as String?,
      productId: json['productId'] as String?,
      customer: json['customer'] as String?,
      totalPeople: json['totalPeople'] as int?,
      status: json['status'] as String?,
      orderAt: json['orderAt'] as String?,
      note: json['note'] as String?,
      totalPrice: json['totalPrice'] as int?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      orderId: json['orderId'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'product': instance.product,
      'vendor': instance.vendor,
      'productId': instance.productId,
      'customer': instance.customer,
      'totalPeople': instance.totalPeople,
      'status': instance.status,
      'orderAt': instance.orderAt,
      'note': instance.note,
      'totalPrice': instance.totalPrice,
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'orderId': instance.orderId,
    };
