import 'dart:ui';

import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum ActivityStatus { pending, confirmed, canceled, complete }
ActivityStatus activityStatusParseString(String value) {
  switch (value) {
    case 'pending':
      return ActivityStatus.pending;
    case 'confirmed':
      return ActivityStatus.confirmed;
    case 'completed':
      return ActivityStatus.complete;
    case 'canceled':
      return ActivityStatus.canceled;
    default:
      return ActivityStatus.pending;
  }
}

String activityStatusToString(ActivityStatus status) {
  switch (status) {
    case ActivityStatus.pending:
      return "processing".tr;
    case ActivityStatus.confirmed:
      return "confirm".tr;
    case ActivityStatus.canceled:
      return "cancel".tr;
    case ActivityStatus.complete:
      return "complete".tr;
    default:
      return "processing".tr;
  }
}

extension ActivityStatusExt on ActivityStatus {
  String value() {
    return activityStatusToString(this);
  }

  ActivityStatus parse(String value) {
    return activityStatusParseString(value);
  }

  String display() {
    switch (this) {
      case ActivityStatus.pending:
        return "processing".tr;
      case ActivityStatus.confirmed:
        return "confirm".tr;
      case ActivityStatus.canceled:
        return "cancel".tr;
      case ActivityStatus.complete:
        return "complete".tr;
      default:
        return "processing".tr;
    }
  }

  Color color() {
    switch (this) {
      case ActivityStatus.pending:
        return ThemeServices().isDarkMode
            ? kColorStatusPendingDark
            : kColorStatusPendingLight;
      case ActivityStatus.confirmed:
        return kColorActionConfirm;
      case ActivityStatus.canceled:
        return kColorPrimaryLight;
      case ActivityStatus.complete:
        return kColorActionSuccess;
      default:
        return kColorActionAlert;
    }
  }
}
