import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_subfee_order_response.g.dart';

@JsonSerializable()
class UpdateSubFeeOrderResponse {
  int? status;
  String? message;
  dynamic errors;
  BookingItemModel? data;

  UpdateSubFeeOrderResponse(
      {this.status, this.message, this.errors, this.data});

  factory UpdateSubFeeOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$UpdateSubFeeOrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateSubFeeOrderResponseToJson(this);
}
