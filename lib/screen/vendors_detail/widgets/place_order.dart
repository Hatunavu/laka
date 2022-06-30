import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({
    Key? key,
    required this.priceTitle,
    required this.date,
    required this.callback,
  }) : super(key: key);

  final String priceTitle;
  final String date;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(priceTitle, style: priceTitleStyle),
            SizedBox(height: kDefaultPaddingItem.h),
            Text(date,
                style: subTitleStyle.copyWith(
                    color: HexColor(bottomTabDefaultLight))),
          ],
        ),
        SizedBox(width: kDefaultPaddingWidget.w),
        Expanded(
          child: SizedBox(
            height: 45.h,
            child: ElevatedButton(
                onPressed: callback,
                child: const Text("Đặt bàn"),
                style: roundedButtonStyle),
          ),
        ),
      ],
    );
  }
}
