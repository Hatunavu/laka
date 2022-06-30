import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
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

class SearchResultItem extends StatelessWidget {
  const SearchResultItem(
      {Key? key, required this.vendorInfo, required this.index})
      : super(key: key);
  final int index;
  final VendorModel vendorInfo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(
          VendorsDetailPage(
              first: vendorInfo.id ?? '',
              last: vendorInfo.category.getType(),
              tagId: "search-${vendorInfo.id}",
              imageUrl: vendorInfo.thumbnail?.path ?? "",
              vendorTitle: vendorInfo.brandName,
              vendorsInfo: vendorInfo),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        margin: EdgeInsets.only(top: index > 0 ? kDefaultPaddingItem.h : 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                image: DecorationImage(
                    // image: NetworkImage(
                    //     "http://192.168.1.50:3000/cdn/images/thumbnails/karaoke4.jpg"),
                    image: CachedNetworkImageProvider(
                        vendorInfo.thumbnail?.path ?? ""),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Positioned(
                      right: 3,
                      bottom: 3,
                      child:
                          renderCategoryPrimary(context, vendorInfo.category))
                ],
              ),
            ),
            SizedBox(
              width: kDefaultPaddingScreen.w,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        vendorInfo.brandName,
                        maxLines: 1,
                        style: titleStyle.copyWith(fontSize: 15.sp),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    if (vendorInfo.dist != null &&
                        vendorInfo.dist?.calculated != 0)
                      Container(
                        margin: EdgeInsets.only(left: 5.w),
                        child: Row(
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
                                  style: subTitleStyle.copyWith(
                                      fontSize: 12.sp,
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  vendorInfo.fullAddressPrimary,
                  maxLines: 2,
                  style: subTitleStyle.copyWith(fontSize: 13.sp),
                )
              ],
            )),
            SizedBox(
              width: 5.w,
            ),
            // renderCategoryPrimary(context, vendorInfo.vendor.category),
          ],
        ),
      ),
    );
  }
}

Widget renderCategoryPrimary(BuildContext context, CategoryType category) {
  return Container(
    width: 20.w,
    height: 20.w,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: HexColor(textColor),
        borderRadius: BorderRadius.circular(defaultBorderRadius)),
    child: Image.asset(getPathIcon(category), width: 15.w, height: 15.w),
  );
}

Widget renderCategorySecondary(BuildContext context, String category) {
  return Container(
    width: 80.w,
    height: 36.h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border.all(color: HexColor(secondaryColorLight), width: 1),
        borderRadius: BorderRadius.circular(defaultBorderRadius)),
    child: Text(
      category,
      style: subTitleStyle,
    ),
  );
}
