// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardsModel _$RewardsModelFromJson(Map<String, dynamic> json) => RewardsModel(
      id: json['_id'] as String?,
      order: BookingItemModel.fromJson(json['order'] as Map<String, dynamic>),
      account: json['account'] as String?,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$RewardsModelToJson(RewardsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'order': instance.order,
      'account': instance.account,
      'amount': instance.amount,
      'type': instance.type,
    };
