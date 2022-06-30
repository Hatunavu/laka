import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class VendorDetailLoading extends StatelessWidget {
  const VendorDetailLoading({Key? key, this.imageUrl, this.title})
      : super(key: key);
  final String? imageUrl;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.zero,
              height: 297.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl ??
                        "https://d2zdpiztbgorvt.cloudfront.net/region1/us/413353/biz_photo/4946854f94854393a61618a7505671-the-beauty-bar-biz-photo-f398f9c579554fe6aa6013da6ebf0e-booksy.jpeg?size=640x427"),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(kDefaultPaddingScreen.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title ?? '',
                      style: AppTextStyle().headingSemi28,
                      maxLines: 2,
                    ),
                    SizedBox(height: kDefaultPaddingItem.h),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.withOpacity(0.4),
                          highlightColor: Colors.grey.withOpacity(0.2),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                      child: Container(
                                          height: 20.h, color: Colors.white)),
                                  SizedBox(width: kDefaultPaddingItem.w),
                                  Flexible(
                                      child: Container(
                                          height: 20.h, color: Colors.white)),
                                ],
                              ),
                              SizedBox(height: kDefaultPaddingItem.h),
                              Container(height: 40.h, color: Colors.white),
                              SizedBox(height: kDefaultPaddingItem.h),
                              Row(
                                children: [
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                          height: 20.h, color: Colors.white)),
                                  SizedBox(width: kDefaultPaddingItem.w),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                          height: 20.h, color: Colors.white)),
                                ],
                              ),
                              SizedBox(height: kDefaultPaddingItem.h),
                              Container(height: 150.h, color: Colors.white),
                              SizedBox(height: kDefaultPaddingItem.h),
                              Row(
                                children: [
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                          height: 20.h, color: Colors.white)),
                                  SizedBox(width: kDefaultPaddingItem.w),
                                  Flexible(
                                      flex: 2,
                                      child: Container(
                                          height: 20.h, color: Colors.white)),
                                ],
                              ),
                              SizedBox(height: kDefaultPaddingItem.h),
                              Container(height: 20.h, color: Colors.white),
                              SizedBox(height: kDefaultPaddingItem.h),
                              Row(
                                children: [
                                  Flexible(
                                      flex: 3,
                                      child: Container(
                                          height: 20.h, color: Colors.white)),
                                  SizedBox(width: kDefaultPaddingItem.w),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                          height: 20.h, color: Colors.white)),
                                ],
                              ),
                              SizedBox(height: kDefaultPaddingItem.h),
                              Container(height: 20.h, color: Colors.white),
                              SizedBox(height: kDefaultPaddingItem.h),
                              Container(height: 40.h, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
