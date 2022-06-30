import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/voucher/enum_voucher.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/filter_vendors/filter_vendors_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/rewards/rewards_controller.dart';
import 'package:client_tggt/screen/vendors_detail/vendors_detail.controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/not_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RewardsScreen extends StatefulWidget {
  RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  RewardsController controller =
      Get.put(RewardsController(getIt.get<ApiClient>()));
  MainController mainController = Get.find();
  @override
  void initState() {
    if (mainController.userToken.value != "") {
      // controller.getListVoucher(30, 1, "", "");
      controller.getDataRewardScreen();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => mainController.userToken.value == ""
        ? NotLoginScreen(
            title: "loginToSeeNewfeed".tr,
            subTitle: "loginToSeeNotificationLabel".tr)
        : Scaffold(
            body: SafeArea(
                left: false,
                right: false,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
                  child: Column(
                    children: [
                      renderHeader(context, controller, mainController),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: controller.isLoading.isTrue
                              ? const LoadingScreen()
                              : Column(
                                  children: [
                                    renderCarouselSlide(context),
                                    Visibility(
                                        visible:
                                            controller.carouselIndex.value ==
                                                100,
                                        child: Text(
                                            '${controller.carouselIndex.value}')),
                                    SizedBox(
                                      height: kDefaultPaddingWidget.h,
                                    ),
                                    renderNewVoucher(context, controller),
                                    SizedBox(
                                      height: kDefaultPaddingWidget.h,
                                    ),
                                    renderHotSale(context, controller)
                                  ],
                                ),
                        ),
                      )
                    ],
                  ),
                )),
          ));
  }

  Widget renderHeader(BuildContext context, RewardsController controller,
      MainController mainController) {
    final AccountModel userProfile = mainController.account.value;
    final coin = userProfile.balance != null
        ? userProfile.balance!.coin!.toInt().toString()
        : "0";
    final currentLocation = AccountServices().getAccountAddress();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   padding: EdgeInsets.zero,
          //   child: Text(
          //     userProfile.profile!.fullName ?? "",
          //     style: titleStyle.copyWith(fontSize: 16.sp),
          //   ),
          // ),
          SizedBox(
            height: kDefaultPaddingItem.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.only(bottom: 3.h),
                  child: SvgPicture.asset(
                    AppPath.lakaPoint,
                    color: ThemeServices().isDarkMode
                        ? Colors.white
                        : Colors.black,
                    width: 12.w,
                    // height: 60,
                  ),
                ),
                SizedBox(
                  width: kDefaultPaddingItem.w,
                ),
                Text(
                  coin,
                  style: TextStyle(
                      color: ThemeServices().isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                ),
              ]),
              SizedBox(
                width: kDefaultPaddingWidget.w,
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  margin: EdgeInsets.only(bottom: 3.h),
                  child: Image.asset(
                    ThemeServices().isDarkMode
                        ? AppPath.locationIconWhite
                        : AppPath.locationIconBlack,
                    color: ThemeServices().isDarkMode
                        ? Colors.white
                        : Colors.black,
                    width: 12.w,
                    // height: 60,
                  ),
                ),
                SizedBox(
                  width: kDefaultPaddingItem.w,
                ),
                Text(
                  currentLocation,
                  style: TextStyle(
                      color: ThemeServices().isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                ),
              ])
            ],
          )
        ],
      ),
    );
  }

  Widget renderCarouselSlide(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 3 / 1,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            reverse: false,

            //autoPlayCurve: Curves.easeInOutCubicEmphasized,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(seconds: 2),
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, resson) {
              // controller.handleUpdateCarouselIndex(index);
              controller.carouselIndex.value = index;
            },
            enlargeStrategy: CenterPageEnlargeStrategy.height),
        items: controller.listBanner.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  context.router.push(
                    VendorsDetailPage(
                        first: item.vendor!.id ?? "",
                        last: item.vendor!.category.getType(),
                        tagId: "banner-${item.vendor!.id}",
                        imageUrl: item.vendor!.thumbnail?.path ?? "",
                        vendorTitle: item.vendor!.brandName,
                        vendorsInfo: item.vendor!,
                        voucher: null),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width + 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(item
                              .image), //CachedNetworkImageProvider(item.image),
                          fit: BoxFit.fill)),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget renderNewVoucher(BuildContext context, RewardsController controller) {
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Text(
              "voucherForNewbie".tr,
              style: titleStyle,
            ),
          ),
          SizedBox(
            height: kDefaultPaddingItem.h,
          ),
          Container(
            alignment: Alignment.centerLeft,
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 75.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.listVoucherSystem.length,
              itemBuilder: (ctx, index) {
                final item = controller.listVoucherSystem[index];
                return Container(
                  margin: EdgeInsets.only(right: 5.h),
                  height: 75.h,
                  width: MediaQuery.of(context).size.width * .8,
                  child: Stack(children: [
                    Positioned(
                        top: 5.h,
                        bottom: 5.h,
                        left: 5.w,
                        right: 5.w,
                        child: SvgPicture.asset(
                          AppPath.voucherTicketThumbnail,
                          color: Theme.of(context).primaryColor,
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                      top: 6.h,
                      bottom: 6.h,
                      left: 6.w,
                      right: 6.w,
                      child: Container(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.w),
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .backgroundColor),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        RichText(
                                          maxLines: 2,
                                          text: TextSpan(
                                            text: 'reduce'.tr + ' ',
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .backgroundColor),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: item.getDiscountAmount,
                                              ),
                                              TextSpan(
                                                  text: ' ' +
                                                      'forBillFrom'.tr +
                                                      ' '),
                                              TextSpan(
                                                text: item.getMinBasketPrice,
                                              ),
                                            ],
                                          ),
                                        )
                                      ]),
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 1.w,
                                              color: Theme.of(context)
                                                  .backgroundColor))),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (item.type == VoucherType.vendor) {
                                        context.router
                                            .push(
                                          VendorsDetailPage(
                                              first: item.vendor!.id,
                                              last: item.vendor!.category
                                                  .getType(),
                                              tagId:
                                                  "voucher-${item.vendor!.id}",
                                              imageUrl: item.vendor!.thumbnail
                                                      ?.path ??
                                                  "",
                                              vendorTitle:
                                                  item.vendor!.brandName,
                                              vendorsInfo: item.vendor!,
                                              voucher: item),
                                        )
                                            .then((value) {
                                          Get.delete<VendorsDetailController>();
                                        });
                                      } else if (item.type ==
                                          VoucherType.system) {
                                        context.router
                                            .push(FilterVendorsPage(
                                                type: "bigVoucher".tr,
                                                isFilterByCity: false,
                                                voucher: item))
                                            .then((value) {
                                          Get.delete<FilterVendorsController>();
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 5.h),
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(3.r),
                                      ),
                                      child: Text("use".tr,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget renderHotSale(BuildContext context, RewardsController controller) {
    return Container(
        padding: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.zero,
            child: Text(
              "superVoucher".tr,
              style: titleStyle,
            ),
          ),
          SizedBox(
            height: kDefaultPaddingItem.h,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listVoucherVendors.length,
            itemBuilder: (ctx, index) {
              final item = controller.listVoucherVendors[index];
              return Container(
                margin: EdgeInsets.only(bottom: kDefaultPaddingItem.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeServices().isDarkMode
                                ? kColorSecondaryDark
                                : Colors.grey[100],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                bottomLeft: Radius.circular(10.r)),
                          ),
                          height: 139.h,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: item.type == VoucherType.system
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 50.w,
                                            height: 50.w,
                                            child: SvgPicture.asset(
                                                AppPath.logo,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 36.w),
                                          ))
                                      : Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          item
                                                                  .vendor!
                                                                  .thumbnail!
                                                                  .path ??
                                                              ""),
                                                  fit: BoxFit.cover)),
                                        )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '# ${item.code}',
                                      style: subTitleStyle.copyWith(
                                          fontSize: 12.sp),
                                    ),
                                  ))
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          height: 139.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "voucherReduce".tr +
                                              " ${item.getDiscountAmount}",
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "applyFrom".tr +
                                              " ${item.getMinBasketPrice}",
                                          maxLines: 2,
                                          style: const TextStyle(height: 1.3),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "limitReduce".tr +
                                              " ${item.getMaxVoucherAmount}",
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          "amount".tr +
                                              ":  ${item.discount.amount}",
                                          maxLines: 1,
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          item.expireDateWithoutTime,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (item.type ==
                                                VoucherType.vendor) {
                                              context.router
                                                  .push(
                                                VendorsDetailPage(
                                                    first: item.vendor!.id,
                                                    last: item.vendor!.category
                                                        .getType(),
                                                    tagId:
                                                        "voucher-${item.vendor!.id}",
                                                    imageUrl: item.vendor!
                                                            .thumbnail?.path ??
                                                        "",
                                                    vendorTitle:
                                                        item.vendor!.brandName,
                                                    vendorsInfo: item.vendor!,
                                                    voucher: item),
                                              )
                                                  .then((value) {
                                                Get.delete<
                                                    VendorsDetailController>();
                                              });
                                            } else if (item.type ==
                                                VoucherType.system) {
                                              context.router
                                                  .push(FilterVendorsPage(
                                                      type: "bigVoucher".tr,
                                                      isFilterByCity: false,
                                                      voucher: item))
                                                  .then((value) {
                                                Get.delete<
                                                    FilterVendorsController>();
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 5.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3.r),
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Text("use".tr,
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
        ]));
  }
}

// Widget renderCarouselSlide(BuildContext context, RewardsController controller) {
//   return Container(
//     padding: EdgeInsets.zero,
//     child: Stack(
//       children: [
//         CarouselSlider(
//           options: CarouselOptions(
//               // height: 120.h,
//               aspectRatio: 2 / 1,
//               viewportFraction: 1,
//               initialPage: 0,
//               enableInfiniteScroll: true,
//               enlargeCenterPage: true,
//               reverse: false,
//               autoPlay: true,
//               //autoPlayCurve: Curves.easeInOutCubicEmphasized,
//               autoPlayInterval: const Duration(seconds: 4),
//               autoPlayAnimationDuration: const Duration(seconds: 2),
//               scrollDirection: Axis.horizontal,
//               onPageChanged: (index, resson) {
//                 controller.handleUpdateCarouselIndex(index);
//               },
//               enlargeStrategy: CenterPageEnlargeStrategy.height),
//           items: controller.listSplashImage.map((item) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width + 5,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                           controller.carouselIndex.value == item.index
//                               ? defaultBorderRadius
//                               : defaultBorderRadius),
//                       image: DecorationImage(
//                           image: AssetImage(item
//                               .image), //CachedNetworkImageProvider(item.image),
//                           fit: BoxFit.fill)),
//                 );
//               },
//             );
//           }).toList(),
//         ),
//         Positioned(
//           bottom: 8,
//           child: Container(
//             alignment: Alignment.center,
//             color: Colors.transparent,
//             width: MediaQuery.of(context).size.width,
//             height: 3.h,
//             child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemCount: controller.listSplashImage.length,
//               itemBuilder: (ctx, index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(horizontal: 2.w),
//                   width: kDefaultPaddingWidget.w,
//                   color: controller.carouselIndex.value == index
//                       ? Colors.grey[50]
//                       : Colors.grey,
//                 );
//               },
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }

