// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_menu_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMenuInOrderRequest _$UpdateMenuInOrderRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateMenuInOrderRequest(
      items: (json['items'] as List<dynamic>)
          .map((e) => UpdateMenuInOrderData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateMenuInOrderRequestToJson(
        UpdateMenuInOrderRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

UpdateMenuInOrderData _$UpdateMenuInOrderDataFromJson(
        Map<String, dynamic> json) =>
    UpdateMenuInOrderData(
      id: json['id'] as String,
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$UpdateMenuInOrderDataToJson(
        UpdateMenuInOrderData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
    };
