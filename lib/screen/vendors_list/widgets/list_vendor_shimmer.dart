import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ListVendorShimmer extends StatelessWidget {
  const ListVendorShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
        // margin: const EdgeInsets.only(top: 60),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.zero,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.4),
                      highlightColor: Colors.grey.withOpacity(0.2),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 3,
                          itemBuilder: (item, int index) {
                            return Container(
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: SizedBox(
                                height: 90.h,
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
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Container(color: Colors.white),
                                        ),
                                        SizedBox(height: kChipPadding.h),
                                        Flexible(
                                          flex: 2,
                                          child: Container(color: Colors.white),
                                        ),
                                        SizedBox(height: kChipPadding.h),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Container(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: kChipPadding.w),
                                              Flexible(
                                                child: Container(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: kChipPadding.h),
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Container(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: kChipPadding.w),
                                              Flexible(
                                                child: Container(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: kChipPadding.w),
                                              Flexible(
                                                child: Container(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          })))
            ]));
  }
}
