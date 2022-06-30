import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(top: 16.h),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.4),
          highlightColor: Colors.grey.withOpacity(0.2),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 8,
                    itemBuilder: (ctx, index) {
                      return Container(
                          padding: EdgeInsets.only(
                            left: kDefaultPaddingScreen.w,
                            right: kDefaultPaddingScreen.w,
                            bottom: kDefaultPaddingScreen.h,
                          ),
                          height: 52.h,
                          // width: MediaQuery.of(context).size.width,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 26,
                                ),
                                SizedBox(
                                  width: kDefaultPaddingWidget.w,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Flexible(
                                        flex: 2,
                                        child: Container(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Container(
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Flexible(child: SizedBox()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]));
                    })
              ]),
        ));
  }
}
