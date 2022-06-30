import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  final Widget? errorWidget;
  final bool hasAction;
  final String? actionTitle;
  final void Function()? onTapped;

  const ErrorScreen({
    Key? key,
    required this.error,
    this.errorWidget,
    this.hasAction = false,
    this.onTapped,
    this.actionTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 32.h,
        horizontal: 32.w,
      ),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: errorWidget ??
                  Image.asset(
                    "assets/images/bar/bar1.jpg",
                    fit: BoxFit.cover,
                    width: 160.w,
                  ),
            ),
            SizedBox(height: 42.h),
            Text(
              error,
              style: TextStyle(
                color: HexColor(primaryColorLight),
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Container(
              padding: const EdgeInsets.all(0),
              height: 32.h,
              width: 140.w,
              child: hasAction
                  ? InkWellButton(label: "Thử lại", onPressed: () {})
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
