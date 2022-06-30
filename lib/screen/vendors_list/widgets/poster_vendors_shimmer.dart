import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PosterVendorsShimmer extends StatelessWidget {
  const PosterVendorsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
        // margin: const EdgeInsets.only(top: 60),
        child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.zero,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.4),
              highlightColor: Colors.grey.withOpacity(0.2),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: kDefaultPaddingItem.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPaddingScreen.w),
                      child: Container(height: 200.h, color: Colors.white),
                    ),
                    SizedBox(
                      height: kDefaultPaddingItem.h,
                    ),
                    Container(
                      height: 150.h,
                      padding: EdgeInsets.zero,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (item, int index) {
                            return Container(
                                margin: EdgeInsets.only(right: 8.w),
                                height: MediaQuery.of(context).size.width * .4,
                                color: Colors.white);
                          }),
                    )
                  ]),
            )));
  }
}
