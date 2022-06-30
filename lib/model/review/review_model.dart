import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? content;
  final ReviewOrderModel? order;
  final AccountModel? reviewer;
  final double rating;
  final List<GalleryModel>? gallery;
  final ReplyResponseModel? response;
  final DateTime createdAt;

  ReviewModel(
      {this.id,
      this.content,
      required this.order,
      required this.reviewer,
      required this.rating,
      required this.createdAt,
      this.response,
      this.gallery});

  String get urlUserAvatar => reviewer!.profile!.avatar!.path ?? '';
  String get reviewerName => reviewer!.profile!.fullName ?? '';
  String get reviewContent => content ?? "";
  String get orderId => order!.orderId;
  String get reviewTime {
    final getDate = DateFormat("hh:mm dd-MM-yyyy").format(createdAt);
    return getDate;
  }

  String get getProductName => order!.product.name;
  List<GalleryModel> get listGallery => gallery ?? [];

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class ReviewOrderModel {
  @JsonKey(name: '_id')
  final String? id;
  final String orderId;
  @JsonKey(
    name: 'status',
    fromJson: stringToBookingStatus,
    toJson: bookingStatusToString,
  )
  final BookingStatus status;
  final OrderProductModel product;
  final String chatRoomId;

  ReviewOrderModel({
    this.id,
    required this.status,
    required this.orderId,
    required this.product,
    required this.chatRoomId,
  });

  factory ReviewOrderModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewOrderModelToJson(this);
}

@JsonSerializable()
class OrderProductModel {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final double price;

  OrderProductModel({
    this.id,
    required this.name,
    required this.price,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      _$OrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}

@JsonSerializable()
class RatingModel {
  @JsonKey(name: '1')
  final int star_1;
  @JsonKey(name: '2')
  final int star_2;
  @JsonKey(name: '3')
  final int star_3;
  @JsonKey(name: '4')
  final int star_4;
  @JsonKey(name: '5')
  final int star_5;

  RatingModel(
      {required this.star_1,
      required this.star_2,
      required this.star_3,
      required this.star_4,
      required this.star_5});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}

@JsonSerializable()
class ReplyResponseModel {
  @JsonKey(name: '_id')
  final String? id;
  final String content;
  final VendorInfoModel by;

  ReplyResponseModel({
    this.id,
    required this.content,
    required this.by,
  });

  factory ReplyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyResponseModelToJson(this);
}
