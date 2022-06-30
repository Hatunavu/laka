import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CarouselShimmerLoading extends StatelessWidget {
  const CarouselShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
        height: 145.h,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.4),
              highlightColor: Colors.grey.withOpacity(0.2),
              child: Container(
                width: MediaQuery.of(context).size.width -
                    (kDefaultPaddingScreen * 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadius.r),
                    color: Colors.white),
              ),
            ),
          ),
        ]));
  }
}
