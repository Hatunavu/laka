// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      productOptions: (json['productOptions'] as List<dynamic>?)
          ?.map((e) => ProductOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      vendor: json['vendor'] as String?,
      productId: json['productId'] as String?,
      customer: json['customer'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      totalPeople: json['totalPeople'] as int?,
      note: json['note'] as String?,
      orderAt: json['orderAt'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'product': instance.product,
      'productOptions': instance.productOptions,
      'vendor': instance.vendor,
      'productId': instance.productId,
      'customer': instance.customer,
      'totalPrice': instance.totalPrice,
      'totalPeople': instance.totalPeople,
      'note': instance.note,
      'orderAt': instance.orderAt,
    };
