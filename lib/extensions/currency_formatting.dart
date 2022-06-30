import 'package:intl/intl.dart';

extension IntFormatting on int {
  String formatCurrency({String symbol = 'đ'}) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: symbol);
    // Remove extra special space in formatter result
    final formattedString =
        formatter.format(this).replaceAll(RegExp(r"\s+"), "");
    return formattedString;
  }

  String formatCurrency2() {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: "");
    // Remove extra special space in formatter result
    final formattedString =
        formatter.format(this).replaceAll(RegExp(r"\s+"), "");
    return formattedString;
  }
}
