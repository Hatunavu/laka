import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_staff_order_response.g.dart';

@JsonSerializable()
class UpdateStaffOrderResponse {
  int? status;
  String? message;
  dynamic errors;
  BookingItemModel? data;

  UpdateStaffOrderResponse({this.status, this.message, this.errors, this.data});

  factory UpdateStaffOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$UpdateStaffOrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateStaffOrderResponseToJson(this);
}
