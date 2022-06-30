import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_screen_response.g.dart';

@JsonSerializable()
class ActivityScreenResponse {
  DataListActivity? data;
  int? status;
  String? message;
  dynamic errors;

  ActivityScreenResponse({
    this.data,
    this.status,
    this.message,
    this.errors,
  });

  factory ActivityScreenResponse.fromJson(Map<String, dynamic> json) {
    return _$ActivityScreenResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActivityScreenResponseToJson(this);
}

@JsonSerializable()
class DataListActivity {
  List<BookingItemModel>? docs;
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;
  int? totalOrderActive;
  int? waitingReviews;

  DataListActivity(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPages,
      this.page,
      this.pagingCounter,
      this.hasPrevPage,
      this.hasNextPage,
      this.prevPage,
      this.nextPage,
      this.totalOrderActive,
      this.waitingReviews});

  factory DataListActivity.fromJson(Map<String, dynamic> json) =>
      _$DataListActivityFromJson(json);

  Map<String, dynamic> toJson() => _$DataListActivityToJson(this);
}
