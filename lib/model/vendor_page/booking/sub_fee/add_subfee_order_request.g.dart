// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_subfee_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSubFeeOrderRequest _$UpdateSubFeeOrderRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateSubFeeOrderRequest(
      items: (json['items'] as List<dynamic>)
          .map((e) =>
              UpdateSubFeeInOrderData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateSubFeeOrderRequestToJson(
        UpdateSubFeeOrderRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

UpdateSubFeeInOrderData _$UpdateSubFeeInOrderDataFromJson(
        Map<String, dynamic> json) =>
    UpdateSubFeeInOrderData(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$UpdateSubFeeInOrderDataToJson(
        UpdateSubFeeInOrderData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'note': instance.note,
    };
