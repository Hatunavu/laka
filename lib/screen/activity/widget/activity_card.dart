import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/model/activity/doc.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shimmer/shimmer.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    Key? key,
    required this.docData,
    required this.callback,
  }) : super(key: key);

  final BookingItemModel docData;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: () {
          context.router
              .push(ActivityDetailPage(id: docData.id ?? '', isFromQr: false))
              .then((value) => callback());
        },
        child: Material(
          //Build Shadow
          color: Theme.of(context).backgroundColor,
          elevation: kdefaultElevated,
          borderRadius:
              BorderRadius.all(Radius.circular(defaultBorderRadius.r)),
          child: buildContent(context),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(kDefaultPaddingItem),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SizedBox(
            height: 75.h,
            child: Row(children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      child: CachedNetworkImage(
                        imageUrl: docData.vendor?.thumbnail?.path ??
                            "http://static1.bestie.vn/Mlog/ImageContent/202106/202106080209252204-6ec88eae-5394-45e6-85e0-640b4c8de751.jpeg",
                        memCacheHeight: 200,
                        placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(
                            color: Colors.white,
                          ),
                          baseColor: Colors.grey.withOpacity(0.4),
                          highlightColor: Colors.grey.withOpacity(0.2),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: kDefaultPaddingItem.h,
                    left: kDefaultPaddingItem.w,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Image.asset(
                        getPathIcon(
                            docData.vendor?.category ?? CategoryType.bar),
                        width: 14.w,
                        height: 14.w,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: kDefaultPaddingItem.w),
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.all(4.0),
                  padding: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#${docData.orderId ?? ''}',
                              style: AppTextStyle().eyebrowRegular10Grey,
                            ),
                            if (docData.status != BookingStatus.pending)
                              buildBadge(context),
                          ],
                        ),
                      ),
                      AutoSizeText(docData.vendor?.brandName ?? "",
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeServices().isDarkMode
                                  ? kColorTextDark
                                  : kColorTextLight)),
                      docData.getPrePriceWithDiscount == 0
                          ? RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text:
                                        "${TGGTUtils().formatMoney((docData.totalPrice ?? 0).toDouble())}đ",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Theme.of(context).primaryColor)),
                                TextSpan(
                                    text:
                                        " (${docData.totalPeople ?? 0} ${'people'.tr})",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: ThemeServices().isDarkMode
                                            ? kColorTextDark
                                            : kColorTextLight)),
                              ]),
                            )
                          : RichText(
                              text: TextSpan(
                                text:
                                    "${TGGTUtils().formatMoney(docData.totalPrice ?? 0)} đ",
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    decoration: TextDecoration.lineThrough,
                                    color: ThemeServices().isDarkMode
                                        ? kColorGreyDark
                                        : kColorGreyLight),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: ' ',
                                      style: TextStyle(
                                          decoration: TextDecoration.none)),
                                  TextSpan(
                                      text:
                                          "${TGGTUtils().formatMoney(docData.getPrePriceWithDiscount)} đ",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontSize: 11.sp,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  TextSpan(
                                      text:
                                          " (${docData.totalPeople ?? 0} ${'people'.tr})",
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          decoration: TextDecoration.none,
                                          color: ThemeServices().isDarkMode
                                              ? kColorTextDark
                                              : kColorTextLight)),
                                ],
                              ),
                            ),
                      Row(
                        children: [
                          Icon(
                            Ionicons.md_time,
                            color: ThemeServices().isDarkMode
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).unselectedWidgetColor,
                            size: 14.sp,
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            margin: EdgeInsets.only(top: 2.h),
                            child: Text(
                              docData.getOrderTime,
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  height: 1.2,
                                  color: ThemeServices().isDarkMode
                                      ? kColorTextDark
                                      : kColorTextLight),
                            ),
                          ),
                        ],
                      ),
                      if (docData.status == BookingStatus.canceled ||
                          docData.status == BookingStatus.completed ||
                          docData.status == BookingStatus.reviewed)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (docData.status == BookingStatus.completed ||
                                docData.status == BookingStatus.reviewed)
                              Container()
                            //   AbsorbPointer(
                            //     child: InkWellButton.outlineSmall(
                            //       borderColor: Theme.of(context).primaryColor,
                            //       textColor: Theme.of(context).primaryColor,
                            //       style: AppTextStyle().eyebrowRegular10,
                            //       onPressed: () {},
                            //       label: docData.review != null
                            //           ? "seeReview".tr
                            //           : "review".tr,
                            //       borderRadius: BorderRadius.circular(
                            //           kDefaultButtonHeight),
                            //     ),
                            //   ),
                            // const Padding(padding: EdgeInsets.only(left: 4)),
                            // InkWellButton.small(
                            //   maxWidth: 100.w,
                            //   style: AppTextStyle().eyebrowRegular10,
                            //   onPressed: () {
                            //     context.router.push(VendorsDetailPage(
                            //         first: docData.vendor?.id ?? "",
                            //         vendorsInfo:
                            //             docData.vendor as VendorModel,
                            //         last: docData.vendor?.category.name));
                            //   },
                            //   label: "reorder".tr,
                            //   borderRadius:
                            //       BorderRadius.circular(kDefaultButtonHeight),
                            // ),
                          ],
                        ),
                      if (docData.status == BookingStatus.pending)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            buildPendingStatus(context),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Badge buildBadge(BuildContext context) {
    return Badge(
      elevation: 0,
      toAnimate: false,
      shape: BadgeShape.square,
      badgeColor: ThemeServices().isDarkMode
          ? docData.status.color()
          : docData.status.color().withOpacity(0.1),
      borderRadius: BorderRadius.circular(defaultBorderRadiusItem),
      badgeContent: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: docData.status == BookingStatus.pending
                ? SpinKitRing(
                    size: 10.sp,
                    lineWidth: 1,
                    color: ThemeServices().isDarkMode
                        ? Theme.of(context).backgroundColor
                        : docData.status.color(),
                  )
                : Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: ThemeServices().isDarkMode
                          ? Theme.of(context).backgroundColor
                          : docData.status.color(),
                      shape: BoxShape.circle,
                    ),
                  ),
          ),
          SizedBox(
            width: 6.w,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              docData.status.display(),
              style: TextStyle(
                  fontSize: 8.sp,
                  color: ThemeServices().isDarkMode
                      ? Theme.of(context).backgroundColor
                      : docData.status.color(),
                  height: 1.2),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildPendingStatus(BuildContext context) {
    return SizedBox(
      height: 15.h,
      child: Badge(
        elevation: 0,
        toAnimate: false,
        shape: BadgeShape.square,
        badgeColor: ThemeServices().isDarkMode
            ? docData.status.color()
            : docData.status.color().withOpacity(0.1),
        borderRadius: BorderRadius.circular(defaultBorderRadiusItem),
        badgeContent: Row(
          children: [
            docData.status == BookingStatus.pending
                ? SpinKitRing(
                    size: 8.sp,
                    lineWidth: 1,
                    color: ThemeServices().isDarkMode
                        ? Theme.of(context).backgroundColor
                        : docData.status.color(),
                  )
                : Container(
                    width: 6.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: ThemeServices().isDarkMode
                          ? Theme.of(context).backgroundColor
                          : docData.status.color(),
                      shape: BoxShape.circle,
                    ),
                  ),
            SizedBox(
              width: 4.w,
            ),
            docData.status == BookingStatus.pending
                ? AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'processing1'.tr,
                        textStyle: TextStyle(
                            fontSize: 8.sp,
                            color: ThemeServices().isDarkMode
                                ? Theme.of(context).backgroundColor
                                : docData.status.color(),
                            height: 1.2),
                      ),
                      TyperAnimatedText(
                        'processing2'.tr,
                        textStyle: TextStyle(
                            fontSize: 8.sp,
                            color: ThemeServices().isDarkMode
                                ? Theme.of(context).backgroundColor
                                : docData.status.color(),
                            height: 1.2),
                      ),
                    ],
                    repeatForever: true,
                  )
                : Text(
                    docData.status.display(),
                    style: AppTextStyle().eyebrowRegular10.copyWith(
                        color: ThemeServices().isDarkMode
                            ? Theme.of(context).backgroundColor
                            : docData.status.color(),
                        height: 1.2),
                  ),
          ],
        ),
      ),
    );
  }
}
