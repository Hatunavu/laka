import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class IntroduceCard extends StatelessWidget {
  const IntroduceCard({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(content == "" ? "" : "introduction".tr,
            style: AppTextStyle().titleBold16.copyWith(height: 1.5)),
        SizedBox(height: kDefaultPaddingItem.h),
        Text(
          content,
          style: AppTextStyle().subtitleRegular14Grey.copyWith(height: 1.5),
        ),
      ],
    );
  }
}
