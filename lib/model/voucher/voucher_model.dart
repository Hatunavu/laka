import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/voucher/enum_voucher.dart';
import 'package:client_tggt/model/voucher/enum_voucher_status.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_model.g.dart';

@JsonSerializable()
class VoucherModel {
  @JsonKey(name: '_id')
  final String id;
  final DiscountVoucherModel discount;
  final String title;
  final double? minBasketPrice;
  final double? usageLimitQuantity;
  final double? totalUsed;
  final double? maxVoucherAmount;
  final bool active;
  final String code;
  final DateTime? startDate;
  final DateTime? endDate;

  @JsonKey(
      name: 'status',
      fromJson: stringToVoucherStatusType,
      toJson: voucherStatusTypeToString,
      defaultValue: VoucherStatusType.expireDate)
  final VoucherStatusType status;

  @JsonKey(
      name: 'type',
      fromJson: stringToVoucherType,
      toJson: voucherTypeToString,
      defaultValue: VoucherType.system)
  final VoucherType type;
  final VendorModel? vendor;
  VoucherModel(
      {required this.id,
      required this.discount,
      required this.title,
      this.minBasketPrice,
      this.usageLimitQuantity,
      this.totalUsed,
      this.maxVoucherAmount,
      required this.active,
      required this.code,
      this.startDate,
      this.endDate,
      required this.status,
      required this.type,
      this.vendor});

  String get getDiscountType => discount.type;
  String get getDiscountAmount {
    if (discount.type == "price") {
      return NumberFormat('#k', 'ID').format(discount.amount! / 1000);
    } else if (discount.type == "percent") {
      return '${discount.amount}%';
    }
    return '1k';
  }

  String get getMinBasketPrice =>
      NumberFormat('#k', 'ID').format(minBasketPrice! / 1000);

  String get getMaxVoucherAmount =>
      NumberFormat('#k', 'ID').format(maxVoucherAmount! / 1000);

  String get expireDate {
    final getTime = DateFormat("hh:mm").format(endDate ?? DateTime.now());
    final getDate = DateFormat("dd/M/yyyy").format(endDate ?? DateTime.now());
    return 'Hết hạn: $getTime ngày $getDate';
  }

  String get expireDateWithoutTime {
    final getDate = DateFormat("dd/M/yyyy").format(endDate ?? DateTime.now());
    return 'Ngày hết hạn: $getDate';
  }

  factory VoucherModel.fromJson(Map<String, dynamic> json) =>
      _$VoucherModelFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherModelToJson(this);
}

@JsonSerializable()
class DiscountVoucherModel {
  final int? amount;
  final String type;
  final double? maxVoucherAmount;
  final String? voucherCode;
  final String? title;
  final String? voucherId;
  DiscountVoucherModel(
      {this.amount,
      required this.type,
      this.maxVoucherAmount,
      this.voucherCode,
      this.title,
      this.voucherId});

  factory DiscountVoucherModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountVoucherModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiscountVoucherModelToJson(this);
}
