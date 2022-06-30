import 'package:json_annotation/json_annotation.dart';
part 'admin_update_order_request.g.dart';

@JsonSerializable()
class AdminUpdateOrdersRequest {
  final String status;
  AdminUpdateOrdersRequest({required this.status});

  factory AdminUpdateOrdersRequest.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateOrdersRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AdminUpdateOrdersRequestToJson(this);
}

// @JsonSerializable()
// class CompleteBookingRequest {
//   final List<String> images;
//   final double totalPrice;
//   final double? finalPrice;
//   final double? discountPercent;
//   final String? voucherCode;
//   CompleteBookingRequest(
//       {required this.totalPrice,
//       this.finalPrice,
//       required this.images,
//       this.discountPercent,
//       this.voucherCode});

//   factory CompleteBookingRequest.fromJson(Map<String, dynamic> json) =>
//       _$CompleteBookingRequestFromJson(json);
//   Map<String, dynamic> toJson() => _$CompleteBookingRequestToJson(this);
// }


