import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/screen/vendors_detail/vendors_detail.controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LabelWithIcon extends StatelessWidget {
  const LabelWithIcon({
    Key? key,
    required this.icon,
    required this.label,
    this.style,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: label,
                    style: AppTextStyle()
                        .subtitleRegular14Grey
                        .copyWith(height: 1.5)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
