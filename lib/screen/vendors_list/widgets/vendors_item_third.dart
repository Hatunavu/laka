import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

class VendorsItemThird extends StatelessWidget {
  const VendorsItemThird(
      {Key? key, required this.vendorInfo, this.voucher, this.listType})
      : super(key: key);
  final VendorModel vendorInfo;
  final VoucherModel? voucher;
  final String? listType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(
          VendorsDetailPage(
              first: vendorInfo.id ?? '',
              last: vendorInfo.category.getType(),
              tagId: "$listType-${vendorInfo.id}",
              imageUrl: vendorInfo.thumbnail?.path ?? "",
              vendorTitle: vendorInfo.brandName,
              vendorsInfo: vendorInfo,
              voucher: voucher),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Theme.of(context).backgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r)),
              child: CachedNetworkImage(
                imageUrl: vendorInfo.thumbnail?.path ??
                    "http://192.168.1.12:3000/cdn/images/thumbnails/restaurant2.jpg",
                height: 90.h,
                memCacheHeight: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    child: Text(
                      vendorInfo.brandName,
                      maxLines: 1,
                      style: titleStyle.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 11.sp),
                    ),
                  ),
                  // SizedBox(
                  //   height: 6.h,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.zero,
                  //   child: Text(
                  //     vendorInfo.priceRange!.getMinPrice(),
                  //     style: TextStyle(
                  //         color: Theme.of(context).primaryColor,
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 10.sp),
                  //   ),
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 12.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (ctx, index) {
                            if (vendorInfo.avgRating == null) {
                              return Container(
                                  padding: const EdgeInsets.all(0),
                                  child: Icon(Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 10.sp));
                            } else {
                              return Container(
                                  padding: const EdgeInsets.all(0),
                                  child: Icon(Icons.star,
                                      color: index <
                                              (vendorInfo.avgRating ?? 0)
                                                  .toInt()
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondaryVariant,
                                      size: 10.sp));
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3.w, top: 3.h),
                        height: 12.h,
                        alignment: Alignment.center,
                        child: Text(
                            (vendorInfo.avgRating ?? 0).toStringAsFixed(1),
                            style: subTitleStyle.copyWith(fontSize: 10.sp)),
                      ),
                      // Visibility(
                      //   visible: vendorInfo.totalReviews! > 0,
                      //   child: Container(
                      //     margin:
                      //         EdgeInsets.only(left: 3.w, top: 3.h, right: 3.w),
                      //     height: 12.h,
                      //     alignment: Alignment.center,
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         Text('(${vendorInfo.totalReviews}) ',
                      //             style: categoryTitleStyle.copyWith(
                      //                 color: Colors.grey, fontSize: 10.sp)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      if (vendorInfo.dist != null &&
                          vendorInfo.dist?.calculated != 0)
                        Container(
                          margin: EdgeInsets.only(left: 5.w),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 3.w),
                                width: 7.h,
                                height: 7.h,
                                child: Image.asset(ThemeServices().isDarkMode
                                    ? AppPath.locationIconDark
                                    : AppPath.locationIconLight),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3.h),
                                child: Text(
                                    "${TGGTUtils().formatDistance(vendorInfo.dist?.calculated ?? 0)} Km",
                                    style:
                                        subTitleStyle.copyWith(fontSize: 9.sp)),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
