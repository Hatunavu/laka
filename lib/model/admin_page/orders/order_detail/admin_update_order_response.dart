import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'admin_update_order_response.g.dart';

@JsonSerializable()
class AdminUpdateOrdersResponse {
  @JsonKey(name: 'data')
  final BookingItemModel? data;
  final int status;
  final String? message;
  final dynamic errors;

  AdminUpdateOrdersResponse(
      {this.data, required this.status, this.message, this.errors});
  factory AdminUpdateOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminUpdateOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUpdateOrdersResponseToJson(this);
}
