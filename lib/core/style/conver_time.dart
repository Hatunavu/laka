import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TimeAgo {
  static String timeAgoSinceDate(DateTime notificationDate,
      {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);
    if (difference.inDays > 365) {
      return "last year";
    } else if ((difference.inDays / 30).floor() >= 1) {
      return '${(difference.inDays / 30).floor()} ${"month".tr}';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return '${(difference.inDays / 7).floor()} ${"week".tr}';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} ${"days".tr}';
    } else if (difference.inDays >= 1) {
      return '1 ${"day".tr}';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} ${"hours".tr}';
    } else if (difference.inHours >= 1) {
      return '1  ${"hour".tr}';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} ${"minutes".tr}';
    } else if (difference.inMinutes >= 1) {
      return '1 ${"minute".tr}';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} ${"seconds".tr}';
    } else {
      return "justNow".tr;
    }
  }
}
