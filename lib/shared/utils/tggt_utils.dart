import 'dart:io';

import 'package:client_tggt/services/account_services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:timeago/timeago.dart' as timeago;

class TGGTUtils {
  String formatDateFromString(String date) {
    DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm');
    DateTime dateTime = dateFormat.parseUTC(date).toLocal();
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
  }

  String formatDateFromDateTime(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String formatDateTimeToTime(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  int formatDateTimeToHour(DateTime date) {
    return int.parse(DateFormat.H().format(date));
  }

  int formatDateTimeToMinute(DateTime date) {
    return int.parse(DateFormat.m().format(date));
  }

  String formatDateToRequest(DateTime date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(date);
  }

  String formatNumber2digits(int number) {
    return number.toString().padLeft(2, '0');
  }

  String formatMoney(double money) {
    int intMoney = money.toInt();
    final currencyFormatter = NumberFormat('#,##0');
    return (currencyFormatter.format(intMoney));
  }

  String formatDistance(double distance) {
    final currencyFormatter = NumberFormat('0.00');
    return (currencyFormatter.format(distance));
  }

  String formatNumber(double number) {
    var f = NumberFormat("0.0");
    return f.format(number);
  }

// var dateValue = new DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUTC("2020-06-14T18:55:21Z").toLocal();
// String formattedDate = DateFormat("dd MMM yyyy hh:mm").format(dateValue);
// debugPrint("formattedDate = "+formattedDate);
  DateTime formatDateStringToDateTime(String date) {
    DateFormat dateFormat = DateFormat('yyyy-MM-ddTHH:mm');
    DateTime dateTime = dateFormat.parseUTC(date).toLocal();
    return dateTime;
  }

  String formatToTimeAgo(String dateString) {
    var dateTime = formatDateStringToDateTime(dateString);
    return timeago.format(
      dateTime,
      locale: AccountServices().getLanguageCode(),
    );
  }

  Future<File> generateVideoThumbnail(String url) async {
    var fileName = await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
    );
    return File(fileName ?? '');
  }
}
