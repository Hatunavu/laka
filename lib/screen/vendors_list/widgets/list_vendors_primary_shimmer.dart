import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ListVendorPrimaryShimmer extends StatelessWidget {
  const ListVendorPrimaryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
        // margin: const EdgeInsets.only(top: 60),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Expanded(
                child: Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.zero,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.withOpacity(0.4),
                        highlightColor: Colors.grey.withOpacity(0.2),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 10,
                            itemBuilder: (item, int index) {
                              return Container(
                                alignment: Alignment.topCenter,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: SizedBox(
                                  height: 100.h,
                                  child: Row(children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            defaultBorderRadius),
                                        child: Container(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(width: kDefaultPaddingItem.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: Colors.white,
                                            width: 200.w,
                                            height: 15.h,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: 200.w,
                                            height: 30.h,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            width: 100.w,
                                            height: 15.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              );
                            }))),
              )
            ]));
  }
}
