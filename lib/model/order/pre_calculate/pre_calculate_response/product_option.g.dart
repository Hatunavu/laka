// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOption _$ProductOptionFromJson(Map<String, dynamic> json) =>
    ProductOption(
      option: json['option'] == null
          ? null
          : Option.fromJson(json['option'] as Map<String, dynamic>),
      amount: json['amount'] as int?,
    );

Map<String, dynamic> _$ProductOptionToJson(ProductOption instance) =>
    <String, dynamic>{
      'option': instance.option,
      'amount': instance.amount,
    };
