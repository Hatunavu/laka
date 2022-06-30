import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  BookingItemModel? data;
  int? status;
  String? message;
  dynamic errors;

  OrderResponse({this.data, this.status, this.message, this.errors});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return _$OrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
