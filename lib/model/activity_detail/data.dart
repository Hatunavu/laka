import 'package:client_tggt/model/review/list_review_response/gallery.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:json_annotation/json_annotation.dart';

import 'product.dart';
import 'vendor.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: '_id')
  final String? id;
  final Product? product;
  final List<ProductOptionModel>? productOptions;
  final Vendor? vendor;
  final int? totalPeople;
  @JsonKey(
    name: 'status',
    fromJson: stringToBookingStatus,
    toJson: bookingStatusToString,
  )
  final BookingStatus status;
  final String? orderAt;
  final String? note;
  final int? totalPrice;
  final String? createdAt;
  final String? updatedAt;
  final String? orderId;
  final String? chatRoomId;
  final ReviewModel? review;
  final ReceiptModel? receipt;

  Data({
    this.id,
    this.product,
    this.productOptions,
    this.vendor,
    this.totalPeople,
    required this.status,
    this.orderAt,
    this.note,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.orderId,
    this.chatRoomId,
    this.review,
    this.receipt,
  });

  Data.empty() : this(status: BookingStatus.pending);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class ReviewModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? content;
  final String? reviewer;
  final double? rating;
  final String? createdAt;
  final List<GalleryModel>? gallery;

  ReviewModel({
    this.createdAt,
    this.id,
    this.content,
    this.reviewer,
    this.rating,
    this.gallery,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

// @JsonSerializable()
// class ProductOptionModel {
//   ProductOptionModel({
//     this.option,
//     this.amount,
//   });

//   final OptionModel? option;
//   final int? amount;

//   factory ProductOptionModel.fromJson(Map<String, dynamic> json) =>
//       _$ProductOptionModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ProductOptionModelToJson(this);
// }

// @JsonSerializable()
// class OptionModel {
//   OptionModel({
//     this.name,
//     this.description,
//     this.image,
//     this.priority,
//     this.type,
//     this.cost,
//     this.id,
//   });

//   final String? name;
//   final String? description;
//   final String? image;
//   final int? priority;
//   final String? type;
//   final int? cost;
//   final String? id;

//   factory OptionModel.fromJson(Map<String, dynamic> json) =>
//       _$OptionModelFromJson(json);

//   Map<String, dynamic> toJson() => _$OptionModelToJson(this);
// }
