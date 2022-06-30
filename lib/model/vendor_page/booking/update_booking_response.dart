import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'update_booking_response.g.dart';

@JsonSerializable()
class UpdateBookingResponse {
  @JsonKey(name: 'data')
  final BookingItemModel? data;
  final int status;
  final String? message;
  final dynamic errors;

  UpdateBookingResponse(
      {this.data, required this.status, this.message, this.errors});
  factory UpdateBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateBookingResponseToJson(this);
}
