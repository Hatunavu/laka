import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ServiceDetailShimmer extends StatelessWidget {
  const ServiceDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(top: 60),
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
                          Container(
                            width: double.infinity,
                            height: 200.h,
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPaddingWidget.h * 1.5,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: kDefaultPaddingWidget.h * 1.5),
                              child: Row(
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
                                    width: 30.w,
                                    height: 30.h,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                          Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: kDefaultPaddingWidget.h * 1.5),
                              child: Row(
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
                                    width: 30.w,
                                    height: 30.h,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                          Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: kDefaultPaddingWidget.h * 1.5),
                              child: Row(
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
                                    width: 30.w,
                                    height: 30.h,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                          Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: kDefaultPaddingWidget.h * 1.5),
                              child: Row(
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
                                    width: 30.w,
                                    height: 30.h,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                          Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: kDefaultPaddingWidget.h * 1.5),
                              child: Row(
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
                                    width: 30.w,
                                    height: 30.h,
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                          Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  )))
        ]));
  }
}
