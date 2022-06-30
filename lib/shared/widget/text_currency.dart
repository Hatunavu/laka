import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextCurrency extends StatelessWidget {
  const TextCurrency({Key? key, required this.title, this.textStyle})
      : super(key: key);
  final String title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,##0  đ', 'ID');

    return Text(
      currencyFormatter.format(double.parse(title)),
      style: textStyle,
    );
  }
}
