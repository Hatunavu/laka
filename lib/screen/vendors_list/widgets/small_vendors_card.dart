import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/shared/widget/rating/rating_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class SmallVendorsCard extends StatelessWidget {
  const SmallVendorsCard({
    Key? key,
    required this.vendorInfo,
  }) : super(key: key);

  final VendorModel vendorInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: kDefaultPaddingScreen.h, right: kDefaultPaddingScreen.h),
      child: Material(
        //Build Shadow
        color: Theme.of(context).backgroundColor,
        elevation: kdefaultElevated,
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius.r)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultBorderRadius),
                    bottomLeft: Radius.circular(defaultBorderRadius)),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    vendorInfo.thumbnail?.path ?? '',
                    errorListener: () => Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: kDefaultPaddingWidget.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kChipPadding.h),
                  Row(
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: HexColor(textColor),
                            borderRadius: BorderRadius.circular(40)),
                        child: Image.asset(
                            getPathIcon(vendorInfo.category.display()),
                            width: 10.w,
                            height: 10.h),
                      ),
                      SizedBox(width: kChipPadding.w),
                      Expanded(
                          child: AutoSizeText(
                        vendorInfo.brandName,
                        style: AppTextStyle().titleRegular16,
                        maxLines: 1,
                      ))
                    ],
                  ),
                  SizedBox(height: kChipPadding.h),
                  AutoSizeText(
                    vendorInfo.fullAddressPrimary,
                    style: AppTextStyle().subtitleRegular14Grey,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text(
                  //   vendorInfo.address?.fullAddress ?? '',
                  //   style: subTitleStyle,
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
                  SizedBox(height: kChipPadding.h),
                  BuildRatingReview(
                      starCount: vendorInfo.avgRating ?? 0,
                      reviewCount: vendorInfo.totalReviews!),
                  // SizedBox(height: kChipPadding.h),
                  // Row(
                  //   children: [
                  //     Text("Dịch vụ:", style: titleStyle),
                  //     SizedBox(width: 5.w),
                  //     Expanded(
                  //       child: vendorInfo.attributes != null
                  //           ? ServiceAttributes(
                  //               listAtributes: vendorInfo.attributes!)
                  //           : const Text("Không có dữ liệu"),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getPathIcon(String category) {
    switch (category) {
      case "BAR":
        return AppPath.barIconWhite;
      case "KARAOKE":
        return AppPath.karaokeIconWhite;
      case "MASSAGE":
        return AppPath.massageIconWhite;
      case "RESTAURANT":
        return AppPath.restaurantIconWhite;
      default:
        return AppPath.barIconWhite;
    }
  }
}
