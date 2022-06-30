import 'dart:ui';

import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum BookingStatus {
  pending,
  confirmed,
  checkedIn,
  canceled,
  completed,
  billPending,
  reviewed
}

// BILL_PENDING: 'bill_pending',
extension BookingStatusExt on BookingStatus {
  String toJsonString() {
    return bookingStatusToString(this);
  }

  BookingStatus parse(String value) {
    return stringToBookingStatus(value);
  }

  String display() {
    switch (this) {
      case BookingStatus.pending:
        return 'processing'.tr;
      case BookingStatus.confirmed:
        return 'confirm'.tr;
      case BookingStatus.canceled:
        return "cancel".tr;
      case BookingStatus.completed:
        return "complete".tr;
      case BookingStatus.checkedIn:
        return "checkedIn".tr;
      case BookingStatus.billPending:
        return "Chờ khách hàng xác nhận";
      case BookingStatus.reviewed:
        return "complete".tr;
    }
  }

  String getType() {
    switch (this) {
      case BookingStatus.pending:
        return "pending";
      case BookingStatus.confirmed:
        return 'confirmed';
      case BookingStatus.checkedIn:
        return "checked-in";
      case BookingStatus.canceled:
        return 'canceled';
      case BookingStatus.completed:
        return "completed";
      case BookingStatus.billPending:
        return "bill_pending";
      case BookingStatus.reviewed:
        return "reviewed";
    }
  }

  Color color() {
    switch (this) {
      case BookingStatus.pending:
        return ThemeServices().isDarkMode
            ? kColorStatusPendingDark
            : kColorStatusPendingLight;
      case BookingStatus.confirmed:
        return kColorActionConfirm;
      case BookingStatus.canceled:
        return kColorPrimaryLight;
      case BookingStatus.completed:
        return kColorActionSuccess;
      case BookingStatus.checkedIn:
        return kColorActionCheckIn;
      case BookingStatus.reviewed:
        return kColorActionSuccess;
      default:
        return kColorActionAlert;
    }
  }
}

BookingStatus stringToBookingStatus(String status) {
  switch (status) {
    case 'pending':
      return BookingStatus.pending;
    case 'confirmed':
      return BookingStatus.confirmed;
    case 'canceled':
      return BookingStatus.canceled;
    case 'completed':
      return BookingStatus.completed;
    case "checked-in":
      return BookingStatus.checkedIn;
    case "bill_pending":
      return BookingStatus.billPending;
    case "reviewed":
      return BookingStatus.reviewed;
    default:
      return BookingStatus.pending;
  }
}

String bookingStatusToString(BookingStatus status) {
  switch (status) {
    case BookingStatus.pending:
      return 'pending';
    case BookingStatus.confirmed:
      return 'confirmed';
    case BookingStatus.completed:
      return 'completed';
    case BookingStatus.canceled:
      return "canceled";
    case BookingStatus.checkedIn:
      return "checked-in";
    case BookingStatus.billPending:
      return "bill_pending";
    case BookingStatus.reviewed:
      return "reviewed";
  }
}

String bookingStatusStringToString(String status) {
  switch (status) {
    case "pending":
      return 'Chờ xác nhận';
    case "confirmed":
      return 'Đã sử dụng';
    case "completed":
      return 'Đã hoàn thành';
    case "canceled":
      return "Đã huỷ";
    case "checkedIn":
      return "Đang sử dụng";
    case "billPending":
      return "Chờ khách hàng xác nhận";
    case "reviewed":
      return "Đã đánh giá";
    case "all":
      return "all".tr;
    default:
      return "";
  }
}
