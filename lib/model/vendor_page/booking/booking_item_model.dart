import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:client_tggt/model/vendor_page/booking/sub_fee/sub_fee_model.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:client_tggt/model/review/review_model.dart';
import 'package:client_tggt/extensions/date_formatting.dart';

part 'booking_item_model.g.dart';

@JsonSerializable()
class BookingItemModel {
  @JsonKey(name: '_id')
  final String? id;
  final ServicesModel? product;
  final VendorModel? vendor;
  final List<ProductOptionModel>? productOptions;
  final AccountModel? customer;
  @JsonKey(
      name: 'status',
      fromJson: stringToBookingStatus,
      toJson: bookingStatusToString,
      defaultValue: BookingStatus.pending)
  final BookingStatus status;
  final int? totalPeople;
  final DateTime? orderAt;
  final String? note;
  final String? cancelNote;
  final double? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderId;
  final ReceiptModel? receipt;
  final DiscountVoucherModel? voucherDiscount;
  final String? chatRoomId;
  final ReviewModel? review;
  double totalStaffPrice;
  double? totalMenuPrice;
  double? totalSubFeePrice;
  List<StaffModel>? staffs;
  final List<SelectedMenuItemModel>? menuItems;
  final List<SubFeeModel>? subFees;

  BookingItemModel(
      {this.id,
      this.product,
      this.productOptions,
      this.customer,
      this.vendor,
      required this.status,
      this.totalPeople,
      this.orderAt,
      this.note,
      this.cancelNote,
      this.totalPrice,
      this.orderId,
      this.receipt,
      this.voucherDiscount,
      this.createdAt,
      this.chatRoomId,
      this.updatedAt,
      this.totalStaffPrice = 0,
      this.totalMenuPrice,
      this.staffs,
      this.review,
      this.menuItems,
      this.totalSubFeePrice,
      this.subFees});

  double? get getTotalPrice {
    if (receipt == null) return totalPrice;
    return receipt!.totalPrice + totalStaffPrice;
  }

  double? get getDiscountPercent {
    if (receipt == null) return 0;
    return receipt!.discountPercent;
  }

  double? get getFinalPrice {
    if (receipt == null) {
      if (menuItems != null) {
        if (totalMenuPrice == null) {
          return (totalPrice ?? 0) + (totalSubFeePrice ?? 0);
        } else {
          return (totalPrice ?? 0) +
              (totalMenuPrice ?? 0) +
              (totalSubFeePrice ?? 0);
        }
      }
      {
        return (totalPrice ?? 0) + (totalSubFeePrice ?? 0);
      }
    }

    return receipt!.finalPrice;
  }

  String get bookingTime {
    final getDate = createdAt?.tohhmmddMMyyyy() ?? '';
    return getDate;
  }

  String get getOrderTimeUpdate {
    final getDate = updatedAt?.tohhmmddMMyyyy() ?? '';
    return getDate;
  }

  String get getOrderTime {
    // final getDate =
    //     DateFormat("hh:mm dd-MM-yyyy").format(orderAt ?? DateTime.now());
    final getDate = orderAt?.tohhmmddMMyyyy() ?? '';
    return getDate;
  }

  String get bookingCode => orderId ?? "";

  String? get statusPayment {
    if (receipt == null) return "Chưa thanh toán";
    if (status == BookingStatus.billPending) return "Chờ khách hàng xác nhận";
    return "Đã thanh toán";
  }

  double get getPrePriceWithDiscount {
    if (voucherDiscount != null) {
      final voucher = voucherDiscount;
      final prePrice = totalPrice ?? 0;
      if (voucher!.type == "percent") {
        final preCalculatePriceWithDiscount =
            prePrice - ((prePrice / 100) * (voucher.amount)!.toDouble());
        return preCalculatePriceWithDiscount;
      } else if (voucher.type == "price") {
        return prePrice - (voucher.amount)!.toDouble();
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  String get getDiscountAmount {
    if (voucherDiscount != null) {
      if (voucherDiscount!.type == "percent") {
        return '${voucherDiscount!.amount}%';
      } else if (voucherDiscount!.type == "price") {
        return '${voucherDiscount!.amount}k';
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  String get customerGetOrderTime {
    return orderAt?.tohhmmddMMyyyy() ?? '';
  }

  factory BookingItemModel.fromJson(Map<String, dynamic> json) =>
      _$BookingItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingItemModelToJson(this);
}

@JsonSerializable()
class ReceiptModel {
  @JsonKey(name: 'totalPrice', defaultValue: 0)
  final double totalPrice;
  @JsonKey(name: 'finalPrice', defaultValue: 0)
  final double finalPrice;
  @JsonKey(name: 'discountPercent', defaultValue: 0)
  final double discountPercent;
  @JsonKey(name: 'images', defaultValue: [])
  final List<GalleryModel>? images;
  ReceiptModel({
    required this.totalPrice,
    required this.finalPrice,
    required this.discountPercent,
    this.images,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptModelToJson(this);
}

@JsonSerializable()
class ProductOptionModel {
  ProductOptionModel({
    this.option,
    this.amount,
  });

  final OptionModel? option;
  final int? amount;

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionModelToJson(this);
}

@JsonSerializable()
class OptionModel {
  OptionModel({
    this.name,
    this.description,
    this.image,
    this.priority,
    this.type,
    this.cost,
    this.id,
  });

  final String? name;
  final String? description;
  final String? image;
  final int? priority;
  final String? type;
  final int? cost;
  final String? id;

  factory OptionModel.fromJson(Map<String, dynamic> json) =>
      _$OptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionModelToJson(this);
}
