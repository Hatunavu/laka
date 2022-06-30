import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/activity/detail/activity_detail_controller.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class OrderStatusSlide extends StatefulWidget {
  OrderStatusSlide({Key? key, required this.item}) : super(key: key);

  final BookingItemModel item;

  @override
  State<OrderStatusSlide> createState() => _OrderStatusSlideState();
}

class _OrderStatusSlideState extends State<OrderStatusSlide> {
  var carouselIndex = 0;
  late BookingItemModel docData;
  @override
  void initState() {
    // TODO: implement initState
    docData = widget.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router
            .push(ActivityDetailPage(id: docData.id ?? "", isFromQr: false))
            .then((value) => {Get.delete<ActivityDetailController>()});
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingItem.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: const Offset(1, 3))
            ]),
        child: SizedBox(
          height: 46.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                              child: CachedNetworkImage(
                                imageUrl: docData.vendor?.thumbnail?.path ??
                                    "http://static1.bestie.vn/Mlog/ImageContent/202106/202106080209252204-6ec88eae-5394-45e6-85e0-640b4c8de751.jpeg",
                                memCacheHeight: 200,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  child: Container(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  baseColor: Colors.grey.withOpacity(0.4),
                                  highlightColor: Colors.grey.withOpacity(0.2),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5.h,
                            left: 5.w,
                            child: Container(
                              width: 10.w,
                              height: 10.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Image.asset(
                                getPathIcon(docData.vendor?.category ??
                                    CategoryType.bar),
                                width: 8.w,
                                height: 8.w,
                                color: Theme.of(context).backgroundColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: kDefaultPaddingItem.w),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          margin: EdgeInsets.only(top: 6.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                    padding: EdgeInsets.zero,
                                    child: Text(docData.vendor!.brandName,
                                        style: titleStyle.copyWith(
                                            fontSize: 13.sp))),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Ionicons.md_time,
                                    color: ThemeServices().isDarkMode
                                        ? kColorGreyDark
                                        : kColorGreyLight,
                                    size: 12.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  // Container(
                                  //   margin: EdgeInsets.only(top: 3.h),
                                  //   child: Text(
                                  //     docData.getOrderTimeUpdate,
                                  //     style: subTitleStyle.copyWith(
                                  //         fontSize: 12.sp),
                                  //   ),
                                  // ),
                                  Container(
                                    margin: EdgeInsets.only(top: 3.h),
                                    child: RichText(
                                      maxLines: 2,
                                      text: TextSpan(
                                        style: subTitleStyle.copyWith(
                                            fontSize: 12.sp),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: DateFormat("hh:mm ")
                                                  .format(docData.orderAt!)),
                                          TextSpan(text: " " + "day".tr + " "),
                                          TextSpan(
                                              text: DateFormat("dd-MM")
                                                  .format(docData.orderAt!))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
              Container(
                height: 26.h,
                padding:
                    EdgeInsets.symmetric(horizontal: kDefaultPaddingItem.w),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5.r)),
                alignment: Alignment.center,
                child: Text(docData.status.display(),
                    style: subTitleStyle.copyWith(
                        color: Theme.of(context).backgroundColor,
                        fontSize: 12.sp)),
              )
            ],
          ),
        ),
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

  Widget renderOrderStatus(BookingItemModel item) {
    if (item.status == BookingStatus.confirmed) {
      return AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            "Bạn có lịch đặt lúc ${item.customerGetOrderTime} tại ${item.vendor!.brandName}",
            textStyle: subTitleStyle.copyWith(
                color: Theme.of(context).backgroundColor,
                fontSize: 12.sp,
                height: 1.2),
          ),
        ],
        totalRepeatCount: 10000,
      );
    } else if (item.status == BookingStatus.checkedIn) {
      return AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            "Bạn đang sử dụng dịch vụ tại ${item.vendor!.brandName}",
            textStyle: subTitleStyle.copyWith(
                color: Theme.of(context).backgroundColor,
                fontSize: 12.sp,
                height: 1.2),
          ),
        ],
        totalRepeatCount: 10000,
      );
    } else if (item.status == BookingStatus.pending) {
      return AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            "Bạn có lịch đặt lúc ${item.customerGetOrderTime} tại ${item.vendor!.brandName}",
            textStyle: subTitleStyle.copyWith(
                color: Theme.of(context).backgroundColor,
                fontSize: 12.sp,
                height: 1.2),
          ),
        ],
        totalRepeatCount: 10000,
      );
    } else {
      return Container();
    }
  }
}
