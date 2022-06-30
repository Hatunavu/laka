import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vendors_create_order_response.g.dart';

@JsonSerializable()
class VendorsCreateOrderResponse {
  @JsonKey(name: 'data')
  final String? data;
  final int status;
  final String? message;
  final dynamic errors;

  VendorsCreateOrderResponse(
      {this.data, required this.status, this.message, this.errors});
  factory VendorsCreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorsCreateOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorsCreateOrderResponseToJson(this);
}
