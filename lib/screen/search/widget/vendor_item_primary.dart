import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_route/auto_route.dart';

class VendorItemPrimary extends StatelessWidget {
  const VendorItemPrimary({
    Key? key,
    this.listType,
    // required this.price,
    required this.vendorInfo,
    this.onPress,
  }) : super(key: key);
  final String? listType;

  // final String price;
  final VendorModel vendorInfo;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress ??
          () {
            context.router.push(VendorsDetailPage(
                first: vendorInfo.id,
                last: vendorInfo.category.getType(),
                tagId: "$listType-${vendorInfo.id}",
                imageUrl: vendorInfo.thumbnail?.path ?? "",
                vendorTitle: vendorInfo.brandName,
                vendorsInfo: vendorInfo));
          },
      child: Container(
        width: double.infinity,
        height: 100.h,
        padding: EdgeInsets.only(bottom: 10.w),
        child: Material(
          //Build Shadow
          color: Theme.of(context).backgroundColor,
          elevation: kdefaultElevated,
          borderRadius:
              BorderRadius.all(Radius.circular(defaultBorderRadius.r)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 88.w,
                height: 85.h,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(defaultBorderRadius),
                //   image: DecorationImage(
                //     image: CachedNetworkImageProvider(
                //       vendorInfo.thumbnail?.path ??
                //           "http://192.168.1.12:3000/cdn/images/thumbnails/restaurant2.jpg",
                //       errorListener: () => Container(
                //         color: Theme.of(context).primaryColor,
                //       ),
                //     ),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      child: CachedNetworkImage(
                        imageUrl: vendorInfo.thumbnail?.path ??
                            "http://192.168.1.12:3000/cdn/images/thumbnails/restaurant2.jpg",
                        height: 85.h,
                        memCacheHeight: 200,
                        width: 100.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 8.h,
                      left: 8.w,
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(40)),
                        child: Image.asset(getPathIcon(vendorInfo.category),
                            width: 12.w,
                            height: 12.w,
                            color: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: defaultPaddingItem.w,
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      height: 85.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            // margin: const EdgeInsets.only(bottom: 2),
                            width: double.infinity,
                            child: RichText(
                              maxLines: 2,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: vendorInfo.brandName,
                                    style: AppTextStyle()
                                        .titleRegular16
                                        .copyWith(height: 1.2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     const Text("Dịch vụ: "),
                          //     Expanded(
                          //         child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //       children: [],
                          //     ))
                          //   ],
                          // ),
                          Text(
                            vendorInfo.fullAddressPrimary,
                            style: AppTextStyle()
                                .subtitleRegular14Grey
                                .copyWith(height: 1.2, fontSize: 12.sp),
                            maxLines: 2,
                          ),
                          // Text(
                          //   vendorInfo.priceRange!.toPriceRange(),
                          //   style: TextStyle(
                          //       color: Theme.of(context).primaryColor,
                          //       fontSize: 12.sp,
                          //       fontWeight: FontWeight.w500),
                          // ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 2.h),
                                height: 12.h,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    // Icon(Icons.star,
                                    //     color: HexColor("F0C05A"), size: 15.sp),
                                    // SizedBox(width: 3.w),
                                    // Text(
                                    //     (vendorInfo.avgRating ?? 0)
                                    //         .toStringAsFixed(1),
                                    //     style: AppTextStyle()
                                    //         .subtitleRegular14
                                    //         .copyWith(height: 1.2)),

                                    ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (ctx, index) {
                                        if (vendorInfo.avgRating == null) {
                                          return Container(
                                              padding: const EdgeInsets.all(0),
                                              child: Icon(Icons.star,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  size: 13.sp));
                                        } else {
                                          return Container(
                                              padding: const EdgeInsets.all(0),
                                              child: Icon(Icons.star,
                                                  color: index <
                                                          (vendorInfo.avgRating ??
                                                                  0)
                                                              .toInt()
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .secondaryVariant,
                                                  size: 13.sp));
                                        }
                                      },
                                    ),
                                    if (vendorInfo.dist != null &&
                                        vendorInfo.dist?.calculated != 0)
                                      Container(
                                        padding: EdgeInsets.zero,
                                        margin: EdgeInsets.only(left: 5.w),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 3.w),
                                              width: 12.h,
                                              height: 12.h,
                                              child: Image.asset(ThemeServices()
                                                      .isDarkMode
                                                  ? AppPath.locationIconDark
                                                  : AppPath.locationIconLight),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 1.h),
                                              child: Text(
                                                  "${TGGTUtils().formatDistance(vendorInfo.dist?.calculated ?? 0)} Km",
                                                  style: AppTextStyle()
                                                      .subtitleRegular14
                                                      .copyWith(
                                                          fontSize: 12.sp)),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
