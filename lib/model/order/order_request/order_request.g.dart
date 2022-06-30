// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      productId: json['productId'] as String?,
      totalPeople: json['totalPeople'] as int?,
      note: json['note'] as String?,
      orderAt: json['orderAt'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      voucherId: json['voucherId'] as String?,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'totalPeople': instance.totalPeople,
      'note': instance.note,
      'orderAt': instance.orderAt,
      'options': instance.options,
      'voucherId': instance.voucherId,
    };
