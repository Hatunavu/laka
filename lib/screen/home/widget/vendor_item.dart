import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class VendorItem extends StatelessWidget {
  const VendorItem(
      {Key? key,
      required this.price,
      required this.vendorInfo,
      this.isFullWidth = false,
      this.listType,
      this.paddingBottom = 0.0,
      this.onPress,
      this.isActive = true,
      this.voucher})
      : super(key: key);

  final String price;
  final bool? isActive;
  final bool? isFullWidth;
  final double? paddingBottom;
  final String? listType;
  final VendorModel vendorInfo;
  final Function()? onPress;
  final VoucherModel? voucher;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Material(
        //Build Shadow
        color: Theme.of(context).backgroundColor,
        elevation: kdefaultElevated,
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius.r)),
        child: InkWell(
          onTap: onPress ??
              () {
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
            padding: EdgeInsets.only(bottom: paddingBottom!),
            constraints: BoxConstraints(
                maxWidth: isFullWidth == false
                    ? MediaQuery.of(context).size.width * 0.75
                    : MediaQuery.of(context).size.width),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(defaultBorderRadius),
                          topRight: Radius.circular(defaultBorderRadius)),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          vendorInfo.thumbnail?.path ??
                              "http://192.168.1.12:3000/cdn/images/thumbnails/restaurant2.jpg",
                          errorListener: () => Container(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        vendorInfo.taglines != null
                            ? Positioned(
                                top: 6.h,
                                left: 6.w,
                                child: vendorInfo.taglines!.isNotEmpty
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: kDefaultPaddingItem.w,
                                            vertical: 5.h),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(3.r)),
                                        child: Text(
                                          vendorInfo.taglines![0].name,
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(),
                              )
                            : Container(),
                        Positioned(
                            // bottom: kDefaultPaddingWidget,
                            // left: kDefaultPaddingWidget,
                            // right: kDefaultPaddingScreen,
                            bottom: kDefaultPaddingItem.h,
                            left: kDefaultPaddingItem.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 26.w,
                                      height: 26.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: Image.asset(
                                        getPathIcon(vendorInfo.category),
                                        width: 16.w,
                                        height: 16.w,
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: kDefaultPaddingItem.w,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Container()
                      ],
                    )),
                SizedBox(
                  height: kDefaultPaddingItem.h * 1.3,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              vendorInfo.brandName,
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.normal),
                              maxLines: 1,
                            ),
                          ),
                          Visibility(
                              visible: vendorInfo.verifyStatus == 1,
                              child: SizedBox(
                                width: kDefaultPaddingItem.w,
                              )),
                          Visibility(
                              visible: vendorInfo.verifyStatus == 1,
                              child: Icon(Ionicons.checkmark_circle_outline,
                                  size: 18.sp,
                                  color: Theme.of(context).primaryColor)),
                          Container()
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Text(
                          vendorInfo.fullAddressPrimary,
                          maxLines: 1,
                          style: subTitleStyle.copyWith(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPaddingItem.h / 2,
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
                            alignment: Alignment.center,
                            height: 15.h,
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
                                          size: 13.sp));
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
                                          size: 13.sp));
                                }
                              },
                            ),
                          ),
                          // SizedBox(
                          //   width: 3.w,
                          // ),
                          // Container(
                          //   margin: EdgeInsets.only(left: 3.w, top: 3.h),
                          //   height: 15.h,
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //       (vendorInfo.avgRating ?? 0).toStringAsFixed(1),
                          //       style: AppTextStyle()
                          //           .subtitleRegular14
                          //           .copyWith(fontSize: 12.sp)),
                          // ),
                          SizedBox(
                            width: kDefaultPaddingItem.w,
                          ),
                          Visibility(
                            visible: vendorInfo.totalReviews! > 0,
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 3.w, top: 2.h, right: 3.w),
                              height: 15.h,
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('(${vendorInfo.totalReviews}) ',
                                      style: categoryTitleStyle.copyWith(
                                          color: Colors.grey, fontSize: 10.sp)),
                                ],
                              ),
                            ),
                          ),
                          if (vendorInfo.dist != null &&
                              vendorInfo.dist?.calculated != 0)
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 3.w),
                                  width: 12.h,
                                  height: 12.h,
                                  child: Image.asset(ThemeServices().isDarkMode
                                      ? AppPath.locationIconDark
                                      : AppPath.locationIconLight),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 3.h),
                                  child: Text(
                                      "${TGGTUtils().formatDistance(vendorInfo.dist?.calculated ?? 0)} Km",
                                      style: AppTextStyle()
                                          .subtitleRegular14
                                          .copyWith(fontSize: 12.sp)),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getPathIcon(CategoryType category) {
  switch (category) {
    case CategoryType.bar:
      return AppPath.barIconWhite;
    case CategoryType.karaoke:
      return AppPath.karaokeIconWhite;
    case CategoryType.massage:
      return AppPath.massageIconWhite;
    case CategoryType.restaurant:
      return AppPath.restaurantIconWhite;
    default:
      return AppPath.barIconWhite;
  }
}
