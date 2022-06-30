import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'booking_detail_response.g.dart';

@JsonSerializable()
class GetBookingDetailResponse {
  @JsonKey(name: 'data')
  final BookingItemModel? data;
  final int status;
  final String? message;
  final dynamic errors;

  GetBookingDetailResponse(
      {this.data, required this.status, this.message, this.errors});
  factory GetBookingDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBookingDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookingDetailResponseToJson(this);
}
