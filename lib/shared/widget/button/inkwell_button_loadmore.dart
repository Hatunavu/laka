import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InkWellButtonLoadmore extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? fontSize;
  const InkWellButtonLoadmore(
      {Key? key,
      this.onPressed,
      required this.label,
      this.borderRadius,
      this.backgroundColor,
      this.fontSize = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: onPressed ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius:
              borderRadius ?? BorderRadius.circular(defaultBorderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingWidget.w,
            vertical: 12,
          ),
          child: Text(label,
              style: TextStyle(
                  color: Theme.of(context).backgroundColor,
                  fontSize: fontSize)),
        ),
      ),
    );
  }
}
