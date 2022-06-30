import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_menu_order_response.g.dart';

@JsonSerializable()
class UpdateMenuOrderResponse {
  int? status;
  String? message;
  dynamic errors;
  BookingItemModel? data;

  UpdateMenuOrderResponse({this.status, this.message, this.errors, this.data});

  factory UpdateMenuOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$UpdateMenuOrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateMenuOrderResponseToJson(this);
}
