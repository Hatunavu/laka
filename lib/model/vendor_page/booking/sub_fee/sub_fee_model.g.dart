// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_fee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubFeeModel _$SubFeeModelFromJson(Map<String, dynamic> json) => SubFeeModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$SubFeeModelToJson(SubFeeModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'note': instance.note,
    };
