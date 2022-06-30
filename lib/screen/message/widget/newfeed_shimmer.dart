import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class NewfeedShimmer extends StatelessWidget {
  const NewfeedShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.grey.withOpacity(0.2),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (ctx, index) {
                    return Container(
                        padding: EdgeInsets.only(
                            left: kDefaultPaddingScreen.w,
                            right: kDefaultPaddingScreen.w,
                            bottom: kDefaultPaddingScreen.h,
                            top: kDefaultPaddingScreen.h),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50.h,
                                    width: 50.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.h),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kDefaultPaddingItem,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 15.h,
                                        width: 200.h,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 5.h),
                                      Container(
                                        height: 15.h,
                                        width: 120.h,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ]),
                            const SizedBox(
                              height: defaultPaddingItem,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width - 68.h,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: defaultPaddingItem,
                            ),
                            Container(
                              height: 30.h,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: defaultPaddingItem,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 26.h,
                                  width: 26.h,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: defaultPaddingItem,
                                ),
                                Container(
                                  height: 26.h,
                                  width: 26.h,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: defaultPaddingItem,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 26.h,
                                  width: 20.h,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: defaultPaddingItem / 2,
                                ),
                                Container(
                                  height: 26.h,
                                  width: 100.h,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: defaultPaddingItem,
                                ),
                                Container(
                                  height: 26.h,
                                  width: 20.h,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: defaultPaddingItem / 2,
                                ),
                                Container(
                                  height: 26.h,
                                  width: 100.h,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ));
                  },
                )),
          ),
        ]));
  }
}
