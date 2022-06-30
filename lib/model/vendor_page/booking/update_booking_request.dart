import 'package:json_annotation/json_annotation.dart';
part 'update_booking_request.g.dart';

@JsonSerializable()
class UpdateBookingRequest {
  final String? status;
  final String? orderAt;
  final String? cancelNote;
  UpdateBookingRequest({this.status, this.orderAt, this.cancelNote});

  factory UpdateBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBookingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateBookingRequestToJson(this);
}

@JsonSerializable()
class CompleteBookingRequest {
  final List<String>? images;
  final double totalPrice;
  final double? finalPrice;
  final double? discountPercent;
  final String? voucherCode;
  CompleteBookingRequest(
      {required this.totalPrice,
      this.finalPrice,
      this.images,
      this.discountPercent,
      this.voucherCode});

  factory CompleteBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteBookingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CompleteBookingRequestToJson(this);
}

@JsonSerializable()
class UpdateBillOrderRequest {
  final List<String>? images;
  UpdateBillOrderRequest({required this.images});

  factory UpdateBillOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateBillOrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateBillOrderRequestToJson(this);
}

@JsonSerializable()
class VendorCreateOrderRequest {
  final List<String> images;
  final double totalPrice;
  final double? finalPrice;
  final double? discountPercent;
  final String? voucherId;
  final String productId;
  final String? note;
  VendorCreateOrderRequest(
      {required this.totalPrice,
      this.finalPrice,
      required this.images,
      this.discountPercent,
      this.voucherId,
      this.note,
      required this.productId});

  factory VendorCreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$VendorCreateOrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VendorCreateOrderRequestToJson(this);
}
