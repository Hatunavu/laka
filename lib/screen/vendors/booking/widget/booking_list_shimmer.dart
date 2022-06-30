import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

class BookingListShimmer extends StatelessWidget {
  const BookingListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.grey.withOpacity(0.2),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (ctx, index) {
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        margin: const EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    bottom: defaultPaddingItem),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 120.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: 120.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                decoration: BoxDecoration(
                                    color: HexColor(greyTextColor)
                                        .withOpacity(.5)),
                              ),
                              const SizedBox(
                                height: defaultPaddingItem,
                              ),
                              Row(children: [
                                Container(
                                  width: 110.w,
                                  height: 110.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        defaultBorderRadius),
                                  ),
                                ),
                                const SizedBox(
                                  width: defaultPaddingItem,
                                ),
                                Container(
                                  padding: EdgeInsets.zero,
                                  height: 110.h,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 200.w,
                                          height: 20.h,
                                          color: Colors.white,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: defaultPaddingItem,
                                                ),
                                                Container(
                                                  width: 150.w,
                                                  height: 20.h,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: defaultPaddingItem,
                                                ),
                                                Container(
                                                  width: 150.w,
                                                  height: 20.h,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: defaultPaddingItem,
                                                ),
                                                Container(
                                                  width: 150.w,
                                                  height: 20.h,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ]),
                                )
                              ]),
                            ]));
                  },
                )),
          ),
        ]));
  }
}
