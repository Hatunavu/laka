import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_list_booking_response.g.dart';

@JsonSerializable()
class GetListBookingResponse {
  @JsonKey(name: 'data')
  final ListBooking? data;
  final int status;
  final String? message;
  final dynamic errors;

  GetListBookingResponse(
      {this.data, required this.status, this.message, this.errors});
  factory GetListBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListBookingResponseToJson(this);
}

@JsonSerializable()
class ListBooking {
  @JsonKey(name: 'docs')
  final List<BookingItemModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  ListBooking(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory ListBooking.fromJson(Map<String, dynamic> json) =>
      _$ListBookingFromJson(json);

  Map<String, dynamic> toJson() => _$ListBookingToJson(this);
}
