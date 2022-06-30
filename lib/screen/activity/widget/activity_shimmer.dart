import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ActivityShimmer extends StatelessWidget {
  const ActivityShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.4),
      highlightColor: Colors.grey.withOpacity(0.2),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: kDefaultPaddingScreen.w,
              right: kDefaultPaddingScreen.w,
            ),
            child: buildContent(context),
          );
        },
      ),
    );
  }

  Padding buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPaddingItem),
      child: Column(
        children: [
          SizedBox(
            height: 90.h,
            child: Row(children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  child: Container(color: Colors.white),
                ),
              ),
              SizedBox(width: kDefaultPaddingItem.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(color: Colors.white),
                          ),
                          SizedBox(width: kChipPadding.w),
                          Flexible(
                            flex: 1,
                            child: Container(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kChipPadding.h),
                    Flexible(
                      child: Container(color: Colors.white),
                    ),
                    SizedBox(height: kChipPadding.h),
                    Flexible(
                      child: Container(color: Colors.white),
                    ),
                    SizedBox(height: kChipPadding.h),
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(color: Colors.white),
                          ),
                          SizedBox(width: kChipPadding.w),
                          Flexible(
                            child: Container(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
