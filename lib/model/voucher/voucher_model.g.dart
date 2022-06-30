// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherModel _$VoucherModelFromJson(Map<String, dynamic> json) => VoucherModel(
      id: json['_id'] as String,
      discount: DiscountVoucherModel.fromJson(
          json['discount'] as Map<String, dynamic>),
      title: json['title'] as String,
      minBasketPrice: (json['minBasketPrice'] as num?)?.toDouble(),
      usageLimitQuantity: (json['usageLimitQuantity'] as num?)?.toDouble(),
      totalUsed: (json['totalUsed'] as num?)?.toDouble(),
      maxVoucherAmount: (json['maxVoucherAmount'] as num?)?.toDouble(),
      active: json['active'] as bool,
      code: json['code'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      status: json['status'] == null
          ? VoucherStatusType.expireDate
          : stringToVoucherStatusType(json['status'] as String),
      type: json['type'] == null
          ? VoucherType.system
          : stringToVoucherType(json['type'] as String),
      vendor: json['vendor'] == null
          ? null
          : VendorModel.fromJson(json['vendor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoucherModelToJson(VoucherModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'discount': instance.discount,
      'title': instance.title,
      'minBasketPrice': instance.minBasketPrice,
      'usageLimitQuantity': instance.usageLimitQuantity,
      'totalUsed': instance.totalUsed,
      'maxVoucherAmount': instance.maxVoucherAmount,
      'active': instance.active,
      'code': instance.code,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'status': voucherStatusTypeToString(instance.status),
      'type': voucherTypeToString(instance.type),
      'vendor': instance.vendor,
    };

DiscountVoucherModel _$DiscountVoucherModelFromJson(
        Map<String, dynamic> json) =>
    DiscountVoucherModel(
      amount: json['amount'] as int?,
      type: json['type'] as String,
      maxVoucherAmount: (json['maxVoucherAmount'] as num?)?.toDouble(),
      voucherCode: json['voucherCode'] as String?,
      title: json['title'] as String?,
      voucherId: json['voucherId'] as String?,
    );

Map<String, dynamic> _$DiscountVoucherModelToJson(
        DiscountVoucherModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'type': instance.type,
      'maxVoucherAmount': instance.maxVoucherAmount,
      'voucherCode': instance.voucherCode,
      'title': instance.title,
      'voucherId': instance.voucherId,
    };
