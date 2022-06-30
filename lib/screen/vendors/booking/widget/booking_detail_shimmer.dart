import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class BookingDetailShimmer extends StatelessWidget {
  const BookingDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.grey.withOpacity(0.2),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 100.w,
                                height: 20.h,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: defaultPaddingItem.w,
                              ),
                              Container(
                                width: 200.w,
                                height: 20.h,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: defaultPaddingItem.h,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100.w,
                                height: 20.h,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: defaultPaddingItem.w,
                              ),
                              Container(
                                width: 200.w,
                                height: 20.h,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: defaultPaddingItem.h,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 100.w,
                                height: 20.h,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: defaultPaddingItem.w,
                              ),
                              Container(
                                width: 200.w,
                                height: 20.h,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: kDefaultPaddingWidget.h * 1.5,
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.6)),
                          ),
                          SizedBox(
                            height: kDefaultPaddingWidget.h,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 200.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: 100.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: kDefaultPaddingWidget.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 26.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: kDefaultPaddingWidget.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150.w,
                                          height: 20.h,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          width: 250.w,
                                          height: 20.h,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: kDefaultPaddingWidget.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 26.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: kDefaultPaddingWidget.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150.w,
                                          height: 20.h,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          width: 250.w,
                                          height: 20.h,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: kDefaultPaddingWidget.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 26.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: kDefaultPaddingWidget.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150.w,
                                          height: 20.h,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          width: 250.w,
                                          height: 20.h,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: kDefaultPaddingWidget.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 26.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: kDefaultPaddingWidget.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150.w,
                                          height: 20.h,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Container(
                                          width: 250.w,
                                          height: 20.h,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ])),
                          SizedBox(
                            height: kDefaultPaddingWidget.h * 2,
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.6)),
                          ),
                          SizedBox(
                            height: kDefaultPaddingWidget.h,
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: 200.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: kDefaultPaddingWidget.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: 200.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: kDefaultPaddingWidget.h,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  width: double.infinity,
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(.6)),
                                ),
                                const SizedBox(
                                  height: defaultPaddingItem,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      width: 200.w,
                                      height: 20.h,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: kDefaultPaddingWidget.h,
                                ),
                              ])),
                          const SizedBox(
                            height: defaultPaddingItem,
                          ),
                        ]))),
          ),
        ]));
  }
}
