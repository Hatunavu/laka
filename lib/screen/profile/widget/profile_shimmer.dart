import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h * 2),
        height: MediaQuery.of(context).size.height,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.4),
          highlightColor: Colors.grey.withOpacity(0.2),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 140.h,
                  width: 140.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(75.h)),
                ),
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
                Container(
                  height: 25.h,
                  width: 150.h,
                  color: Colors.white,
                ),
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
                Container(
                  height: 25.h,
                  width: 100.w,
                  color: Colors.white,
                ),
                SizedBox(
                  height: kDefaultPaddingWidget.h * 2,
                ),
                Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.h),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                bottom: kDefaultPaddingWidget.h * 2,
                                left: kDefaultPaddingWidget.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25.h,
                                  width: 25.h,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: kDefaultPaddingWidget.w * 2,
                                ),
                                Container(
                                  height: 25.h,
                                  width: 186.w,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: kDefaultPaddingWidget * 2,
                                left: kDefaultPaddingWidget),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25.h,
                                  width: 25.h,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: kDefaultPaddingWidget * 2,
                                ),
                                Container(
                                  height: 25.h,
                                  width: 210.w,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: kDefaultPaddingWidget * 2,
                                left: kDefaultPaddingWidget),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25.h,
                                  width: 25.h,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: kDefaultPaddingWidget * 2,
                                ),
                                Container(
                                  height: 25.h,
                                  width: 150.w,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: kDefaultPaddingWidget * 2,
                                left: kDefaultPaddingWidget),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25.h,
                                  width: 25.h,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: kDefaultPaddingWidget * 2,
                                ),
                                Container(
                                  height: 25.h,
                                  width: 150.w,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.only(
                                bottom: kDefaultPaddingWidget * 2,
                                left: kDefaultPaddingWidget),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25.h,
                                  width: 25.h,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: kDefaultPaddingWidget * 2,
                                ),
                                Container(
                                  height: 25.h,
                                  width: 186.w,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ],
                    ))
              ]),
        ));
  }
}
