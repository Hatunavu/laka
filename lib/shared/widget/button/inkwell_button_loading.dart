import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InkwellButtonLoading extends StatefulWidget {
  final String label;
  final Color? backgroundColor;
  final FontWeight? buttonFontWeight;
  final void Function()? onPressed;
  final double? maxWidth;
  final bool? isLoading;
  final BoxBorder? boxBorder;
  final double? maxHeight;
  final Color? borderColor;

  final Color? textColor;

  final BorderRadiusGeometry? borderRadius;

  const InkwellButtonLoading(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.backgroundColor = kColorPrimaryLight,
      this.borderColor = Colors.transparent,
      this.textColor = Colors.white,
      this.maxWidth,
      this.maxHeight = 45,
      this.isLoading = false,
      this.boxBorder,
      this.borderRadius,
      this.buttonFontWeight = FontWeight.normal})
      : super(key: key);

  @override
  _InkwellButtonLoadingState createState() => _InkwellButtonLoadingState();
}

class _InkwellButtonLoadingState extends State<InkwellButtonLoading> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isLoading == false ? widget.onPressed : () {},
      child: Container(
        width: widget.maxWidth,
        height: widget.maxHeight!,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius:
              widget.borderRadius ?? BorderRadius.circular(defaultBorderRadius),
          // border: widget.boxBorder,
          border: Border.all(color: widget.borderColor!),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingWidget.w,
            //vertical: 12.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: widget.isLoading == false,
                  child: Text(widget.label,
                      style: AppTextStyle()
                          .titleRegular16
                          .copyWith(color: widget.textColor))),
              Visibility(
                visible: widget.isLoading!,
                child: SizedBox(
                  child: Lottie.asset(AppPath.appLoading,
                      frameRate: FrameRate.max),
                  height: 45.h,
                  width: 45.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
