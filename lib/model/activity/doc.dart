import 'package:client_tggt/model/activity_detail/data.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:json_annotation/json_annotation.dart';

import 'product.dart';
import 'vendor.dart';

part 'doc.g.dart';

@JsonSerializable()
class Doc {
  @JsonKey(name: '_id')
  String? id;
  Product? product;
  Vendor? vendor;
  int? totalPeople;
  @JsonKey(
    name: 'status',
    fromJson: stringToBookingStatus,
    toJson: bookingStatusToString,
  )
  final BookingStatus status;
  String? orderAt;
  String? note;
  int? totalPrice;
  String? createdAt;
  String? updatedAt;
  String? orderId;
  final List<GalleryModel>? receiptImages;
  final ReviewModel? review;

  Doc({
    this.id,
    this.product,
    this.vendor,
    this.totalPeople,
    required this.status,
    this.orderAt,
    this.note,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.receiptImages,
    this.review,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => _$DocFromJson(json);

  Map<String, dynamic> toJson() => _$DocToJson(this);
}
