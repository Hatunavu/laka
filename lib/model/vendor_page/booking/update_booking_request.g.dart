// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBookingRequest _$UpdateBookingRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateBookingRequest(
      status: json['status'] as String?,
      orderAt: json['orderAt'] as String?,
      cancelNote: json['cancelNote'] as String?,
    );

Map<String, dynamic> _$UpdateBookingRequestToJson(
        UpdateBookingRequest instance) =>
    <String, dynamic>{
      'status': instance.status,
      'orderAt': instance.orderAt,
      'cancelNote': instance.cancelNote,
    };

CompleteBookingRequest _$CompleteBookingRequestFromJson(
        Map<String, dynamic> json) =>
    CompleteBookingRequest(
      totalPrice: (json['totalPrice'] as num).toDouble(),
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      discountPercent: (json['discountPercent'] as num?)?.toDouble(),
      voucherCode: json['voucherCode'] as String?,
    );

Map<String, dynamic> _$CompleteBookingRequestToJson(
        CompleteBookingRequest instance) =>
    <String, dynamic>{
      'images': instance.images,
      'totalPrice': instance.totalPrice,
      'finalPrice': instance.finalPrice,
      'discountPercent': instance.discountPercent,
      'voucherCode': instance.voucherCode,
    };

UpdateBillOrderRequest _$UpdateBillOrderRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateBillOrderRequest(
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UpdateBillOrderRequestToJson(
        UpdateBillOrderRequest instance) =>
    <String, dynamic>{
      'images': instance.images,
    };

VendorCreateOrderRequest _$VendorCreateOrderRequestFromJson(
        Map<String, dynamic> json) =>
    VendorCreateOrderRequest(
      totalPrice: (json['totalPrice'] as num).toDouble(),
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      discountPercent: (json['discountPercent'] as num?)?.toDouble(),
      voucherId: json['voucherId'] as String?,
      note: json['note'] as String?,
      productId: json['productId'] as String,
    );

Map<String, dynamic> _$VendorCreateOrderRequestToJson(
        VendorCreateOrderRequest instance) =>
    <String, dynamic>{
      'images': instance.images,
      'totalPrice': instance.totalPrice,
      'finalPrice': instance.finalPrice,
      'discountPercent': instance.discountPercent,
      'voucherId': instance.voucherId,
      'productId': instance.productId,
      'note': instance.note,
    };
