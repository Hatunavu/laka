import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class VendorShimmerLoading extends StatelessWidget {
  const VendorShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        height: 300.h,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.grey.withOpacity(0.2),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (ctx, index) {
                    return Container(
                        padding: EdgeInsets.only(
                            left: index > 0 ? kDefaultPaddingScreen.w : 0),
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius),
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                width: 200.w,
                                height: 20.h,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                width: double.infinity,
                                height: 20.h,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                  width: double.infinity,
                                  height: 20.h,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 86.w, color: Colors.white),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Container(
                                          width: 30.w, color: Colors.white),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Container(
                                          width: 30.w, color: Colors.white),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Container(
                                          width: 86.w, color: Colors.white),
                                    ],
                                  )),
                            ]));
                  },
                )),
          ),
        ]));
  }
}
