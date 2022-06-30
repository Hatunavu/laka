import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildRatingReview extends StatelessWidget {
  const BuildRatingReview({
    Key? key,
    required this.starCount,
    required this.reviewCount,
  }) : super(key: key);

  final double starCount;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 15.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (ctx, index) {
              if (starCount == 0) {
                return Container(
                    padding: const EdgeInsets.all(0),
                    child: Icon(Icons.star,
                        color: Theme.of(context).primaryColor, size: 13.sp));
              } else {
                return Container(
                    padding: const EdgeInsets.all(0),
                    child: Icon(Icons.star,
                        color: index < starCount
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.secondaryVariant,
                        size: 13.sp));
              }
            },
          ),
        ),
        SizedBox(
          width: 6.w,
        ),
        Container(
          margin: EdgeInsets.only(top: 3.h),
          child: Text(
            TGGTUtils().formatNumber(starCount),
            style: AppTextStyle().subtitleRegular14,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 2.w),
        // Padding(
        //   padding: EdgeInsets.only(bottom: 3.h),
        //   child: Icon(Icons.star,
        //       color: Theme.of(context).primaryColor, size: 15.sp),
        // ),

        // SizedBox(width: kChipPadding.w),
        // Text("($reviewCount) đánh giá",
        //     style: subTitleStyle.copyWith(fontSize: 12.sp),
        //     textAlign: TextAlign.center),
      ],
    );
  }
}
