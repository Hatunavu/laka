import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/filter_vendors/filter_vendors_controller.dart';
import 'package:client_tggt/screen/filter_vendors/widget/city_popup.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/home/widget/carousel_shimmer_loading.dart';
import 'package:client_tggt/screen/home/widget/carousel_slide.dart';
import 'package:client_tggt/screen/home/widget/category_widget.dart';
import 'package:client_tggt/screen/home/widget/list_city.dart';
import 'package:client_tggt/screen/home/widget/order_status_slide.dart';
import 'package:client_tggt/screen/home/widget/popular_place_widget.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:client_tggt/screen/home/widget/vendor_shimmer_loading.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/notification/notification_controller.dart';
import 'package:client_tggt/screen/profile/message/message_controller.dart';
import 'package:client_tggt/screen/search/search_controller.dart';
import 'package:client_tggt/screen/search/search_screen.dart';
import 'package:client_tggt/screen/search/widget/vendor_item_primary.dart';
import 'package:client_tggt/screen/vendors_list/vendors_binding.dart';
import 'package:client_tggt/screen/vendors_list/vendors_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:client_tggt/shared/widget/popup_card/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController =
      Get.put(HomeController(getIt.get<ApiClient>()));
  final MainController mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: homeController.backgroundColorBehind.value,
          body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 1000));
              homeController.getDataHomeScreen(
                  lat: double.parse(homeController.latitude.value),
                  lng: double.parse(homeController.longitude.value));
              homeController.moreHostVendors.value = [];
              homeController.page.value = 1;
              homeController.totalDocs.value = 0;
            },
            child: Stack(
              children: [
                Container(
                    // padding: const EdgeInsets.only(bottom: kDefaultPaddingWidget),
                    padding: EdgeInsets.zero,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: homeController.scrollController,
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.zero,
                              height: 175.h,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 0.h,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                          left: kDefaultPaddingWidget.h),
                                      height: 140.h,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(ThemeServices()
                                                      .isDarkMode
                                                  ? AppPath.homepageHeaderDark
                                                  : AppPath
                                                      .homepageHeaderLight),
                                              fit: BoxFit.cover)),
                                      child: Container(
                                        padding: EdgeInsets.zero,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            mainController.isLogin.isTrue
                                                ? Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                        Expanded(
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CachedNetworkImage(
                                                                  imageUrl: mainController
                                                                          .account
                                                                          .value
                                                                          .urlUserAvatar ??
                                                                      "",
                                                                  memCacheHeight:
                                                                      200,
                                                                  imageBuilder:
                                                                      (context,
                                                                              image) =>
                                                                          CircleAvatar(
                                                                    backgroundImage:
                                                                        image,
                                                                    radius:
                                                                        18.r,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      kDefaultPaddingItem
                                                                          .w,
                                                                ),
                                                                Text(
                                                                  '${mainController.account.value.balance?.coin?.toInt()}',
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .backgroundColor,
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                                SizedBox(
                                                                  width: 5.w,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              3.h),
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    AppPath
                                                                        .lakaPoint,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .backgroundColor,
                                                                    width: 12.w,
                                                                    // height: 60,
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                        renderCityPopup(
                                                            context),
                                                        Expanded(
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        3.h),
                                                            padding:
                                                                EdgeInsets.zero,
                                                            // child: SvgPicture.asset(
                                                            //   logoUrl,
                                                            //   color: Theme.of(context).backgroundColor,
                                                            //   width: 55.w,
                                                            //   allowDrawingOutsideViewBox: true,
                                                            // ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (mainController
                                                                            .countUnreadNotifications
                                                                            .value >
                                                                        0) {
                                                                      mainController
                                                                          .countUnreadNotifications
                                                                          .value = 0;
                                                                    }
                                                                    context
                                                                        .router
                                                                        .push(
                                                                            const NotificationPage())
                                                                        .then((value) =>
                                                                            {
                                                                              Get.delete<NotificationController>()
                                                                            });
                                                                  },
                                                                  child: mainController
                                                                              .countUnreadNotifications
                                                                              .value >
                                                                          0
                                                                      ? Container(
                                                                          padding: EdgeInsets.only(
                                                                              left: 10.w,
                                                                              top: 10.w,
                                                                              bottom: 10.w,
                                                                              right: 6.w),
                                                                          child:
                                                                              Badge(
                                                                            padding:
                                                                                EdgeInsets.all(5.w),
                                                                            badgeColor:
                                                                                Theme.of(context).backgroundColor,
                                                                            badgeContent:
                                                                                Container(
                                                                              // padding:
                                                                              //     EdgeInsets.all(1.w),
                                                                              child: Text(
                                                                                mainController.countUnreadNotifications.value > 100 ? '99+' : '${mainController.countUnreadNotifications.value}',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 7.sp, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                            position:
                                                                                BadgePosition.topEnd(top: -5.h, end: -5.h),
                                                                            animationType:
                                                                                BadgeAnimationType.scale,
                                                                            animationDuration:
                                                                                const Duration(milliseconds: 100),
                                                                            child:
                                                                                Icon(
                                                                              Ionicons.notifications_outline,
                                                                              color: Theme.of(context).backgroundColor,
                                                                              size: 23.sp,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          padding: EdgeInsets.only(
                                                                              left: 10.w,
                                                                              top: 10.w,
                                                                              bottom: 10.w,
                                                                              right: 6.w),
                                                                          child:
                                                                              Icon(
                                                                            Ionicons.notifications_outline,
                                                                            size:
                                                                                23.sp,
                                                                            color:
                                                                                Theme.of(context).backgroundColor,
                                                                          ),
                                                                        ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    context
                                                                        .router
                                                                        .push(
                                                                            const MessagePage())
                                                                        .then((value) =>
                                                                            {
                                                                              Get.delete<MessageController>()
                                                                            });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: 10
                                                                            .w,
                                                                        bottom: 10
                                                                            .w,
                                                                        right: 16
                                                                            .w),
                                                                    child: Icon(
                                                                      Ionicons
                                                                          .chatbubble_ellipses_outline,
                                                                      size:
                                                                          21.sp,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .backgroundColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ])
                                                : Container(
                                                    padding: EdgeInsets.zero,
                                                    child: Text("greet".tr,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .backgroundColor,
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                            SizedBox(
                                              height: 6.h,
                                            ),
                                            Text(
                                              'homeSlogan'.tr,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                  height: 1.3,
                                                  fontSize: 11.h,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 114.h,
                                    left: kDefaultPaddingWidget.w,
                                    right: kDefaultPaddingWidget.w,
                                    child: InkWell(
                                      onTap: () {
                                        // Get.toNamed(AppRoutes.search);
                                        homeController.moreHostVendors.value =
                                            [];
                                        homeController.page.value = 1;
                                        context.router
                                            .push(SearchPage())
                                            .then((value) {
                                          Get.delete<SearchController>();
                                        });
                                      },
                                      child: Material(
                                        //Build Shadow
                                        elevation: kdefaultElevated,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                defaultBorderRadius.r)),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 50.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  kDefaultPaddingWidget.w),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              kDefaultPaddingWidget.w * 2,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            borderRadius: BorderRadius.circular(
                                                defaultBorderRadius),
                                          ),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  size: 30.h,
                                                ),
                                                SizedBox(
                                                  width: kDefaultPaddingItem.w,
                                                ),
                                                Expanded(
                                                  child: AnimatedTextKit(
                                                    animatedTexts: [
                                                      TyperAnimatedText(
                                                          'searchBarTitle'.tr),
                                                      TyperAnimatedText(
                                                          'karaoke'.tr),
                                                      TyperAnimatedText(
                                                          'bar'.tr),
                                                      TyperAnimatedText(
                                                          'massage'.tr),
                                                      TyperAnimatedText(
                                                          'restaurant'.tr),
                                                    ],
                                                    totalRepeatCount: 100,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: kDefaultPaddingItem.w,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    homeController.page.value =
                                                        1;
                                                    homeController
                                                        .moreHostVendors
                                                        .value = [];
                                                    context.router.push(
                                                        const CustomerQrPage());
                                                  },
                                                  child: Icon(
                                                    MaterialCommunityIcons
                                                        .qrcode_scan,
                                                    color: ThemeServices()
                                                            .isDarkMode
                                                        ? kColorGreyDark
                                                        : Colors.black87,
                                                    size: 22.h,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    VendorsBinding().dependencies();
                                    homeController.page.value = 1;
                                    homeController.moreHostVendors.value = [];
                                    context.router
                                        .push(VendorsPage(
                                            category: CategoryType.restaurant))
                                        .then((value) =>
                                            {Get.delete<VendorsController>()});
                                    ;
                                  },
                                  child: Category(
                                      title: CategoryType.restaurant.display(),
                                      color: HexColor("#2196F3"),
                                      imageurl: AppPath.restaurantIconWhite),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    VendorsBinding().dependencies();
                                    homeController.page.value = 1;
                                    homeController.moreHostVendors.value = [];
                                    context.router
                                        .push(VendorsPage(
                                            category: CategoryType.karaoke))
                                        .then((value) =>
                                            {Get.delete<VendorsController>()});
                                    ;
                                  },
                                  child: Category(
                                      title: CategoryType.karaoke.display(),
                                      color: HexColor("#ff9800"),
                                      imageurl: AppPath.karaokeIconWhite),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    VendorsBinding().dependencies();
                                    homeController.page.value = 1;
                                    homeController.moreHostVendors.value = [];
                                    context.router
                                        .push(VendorsPage(
                                            category: CategoryType.bar))
                                        .then((value) =>
                                            {Get.delete<VendorsController>()});
                                    ;
                                  },
                                  child: Category(
                                      title: CategoryType.bar.display(),
                                      color: HexColor("#E64A19"),
                                      imageurl: AppPath.barIconWhite),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    VendorsBinding().dependencies();
                                    homeController.page.value = 1;
                                    homeController.moreHostVendors.value = [];
                                    context.router
                                        .push(VendorsPage(
                                            category: CategoryType.massage))
                                        .then((value) =>
                                            {Get.delete<VendorsController>()});
                                  },
                                  child: Category(
                                      title: CategoryType.massage.display(),
                                      color: HexColor("#673AB7"),
                                      imageurl: AppPath.massageIconWhite),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: kDefaultPaddingWidget.h,
                            ),
                            homeController.isLoading.isTrue
                                ? const CarouselShimmerLoading()
                                : CarouselSlide(
                                    listSplashImage:
                                        homeController.listBanners),
                            Container(
                                padding: EdgeInsets.only(
                                    left: kDefaultPaddingScreen.w),
                                child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                            right: kDefaultPaddingScreen.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('hotPlace'.tr,
                                                style: AppTextStyle()
                                                    .titleRegular16),
                                            InkWell(
                                                onTap: () {
                                                  homeController.page.value = 1;
                                                  homeController.moreHostVendors
                                                      .value = [];
                                                  context.router
                                                      .push(FilterVendorsPage(
                                                          type: 'hotPlace'.tr,
                                                          isFilterByCity:
                                                              false))
                                                      .then((value) {
                                                    Get.delete<
                                                        FilterVendorsController>();
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      defaultPaddingItem.w),
                                                  child: Icon(
                                                      Ionicons
                                                          .chevron_forward_outline,
                                                      size: 20,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ))
                                          ],
                                        )),
                                    // SizedBox(
                                    //   height: kDefaultPaddingItem.h,
                                    // ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 75.h,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            homeController.listCity.length,
                                        itemBuilder: (ctx, index) {
                                          final cityInfo =
                                              homeController.listCity[index];
                                          return PopularPlaceWidget(
                                              placeCount:
                                                  cityInfo.placeCount ?? 100,
                                              placeImage: cityInfo
                                                      .categoryImage ??
                                                  "assets/images/place/saigon.jpg",
                                              imageSize: 60.h,
                                              cityCode: cityInfo.code ?? "",
                                              placeTitle:
                                                  cityInfo.title ?? "Hà Nội");
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.only(
                                  left: kDefaultPaddingScreen.w),
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          right: kDefaultPaddingScreen.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('suggest'.tr,
                                              style: AppTextStyle()
                                                  .titleRegular16),
                                          InkWell(
                                              onTap: () {
                                                homeController.page.value = 1;
                                                homeController
                                                    .moreHostVendors.value = [];
                                                context.router
                                                    .push(FilterVendorsPage(
                                                        type: 'suggest'.tr,
                                                        isFilterByCity: false))
                                                    .then((value) {
                                                  Get.delete<
                                                      FilterVendorsController>();
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    defaultPaddingItem.w),
                                                child: Icon(
                                                    Ionicons
                                                        .chevron_forward_outline,
                                                    size: 20,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ))
                                        ],
                                      )),
                                  SizedBox(
                                    height: kDefaultPaddingItem.w,
                                  ),
                                  renderListSuggestServices(
                                      context, homeController),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: defaultPaddingItem.w - 5,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: kDefaultPaddingScreen.w,
                                top: 20.h,
                                bottom: 20.h,
                              ),
                              height: 180.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(AppPath.homeBanner),
                              )),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    left: kDefaultPaddingScreen.w,
                                    right: kDefaultPaddingScreen.w,
                                    top: kDefaultPaddingItem.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.zero,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('hot'.tr,
                                                style: AppTextStyle()
                                                    .titleRegular16),
                                            // InkWell(
                                            //     onTap: () {
                                            //       context.router
                                            //           .push(FilterVendorsPage(
                                            //               type: 'hot'.tr,
                                            //               isFilterByCity:
                                            //                   false))
                                            //           .then((value) {
                                            //         Get.delete<
                                            //             FilterVendorsController>();
                                            //       });
                                            //     },
                                            //     child: Container(
                                            //       padding: EdgeInsets.all(
                                            //           defaultPaddingItem.w),
                                            //       child: Icon(
                                            //           Ionicons
                                            //               .chevron_forward_outline,
                                            //           size: 20,
                                            //           color: Theme.of(context)
                                            //               .primaryColor),
                                            //     ))
                                          ],
                                        )),
                                    SizedBox(
                                      height: kDefaultPaddingItem.h,
                                    ),
                                    renderListHotServices(
                                        context, homeController),
                                    homeController.moreHostVendors.isEmpty
                                        ? Container()
                                        : renderMoreVendors(context),
                                    Visibility(
                                        visible: homeController
                                                .moreHostVendors.length ==
                                            homeController.totalDocs.value,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: Text(
                                            "Đã hiển thị hết",
                                            style: subTitleStyle,
                                          ),
                                        )),
                                    homeController.isLoadingMore.isTrue
                                        ? Container(
                                            padding: EdgeInsets.zero,
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              child: Lottie.asset(
                                                  AppPath.appLoading,
                                                  frameRate: FrameRate.max),
                                              height: 30.h,
                                              width: 68.w,
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: kDefaultPaddingWidget.h,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )),
                mainController.currentOrders.value.id == null
                    ? Container()
                    : Positioned(
                        bottom: kDefaultPaddingItem.h,
                        left: kDefaultPaddingScreen.w - 3.w,
                        right: kDefaultPaddingScreen.w - 3.w,
                        child: OrderStatusSlide(
                            item: mainController.currentOrders.value)),
              ],
            ),
          ),
        ));
  }

  Widget renderListSuggestServices(
      BuildContext context, HomeController homeController) {
    if (homeController.isLoading.value == true) {
      return const VendorShimmerLoading();
    } else {
      return Visibility(
        visible: homeController.listSuggestedServices.isNotEmpty,
        child: Container(
          alignment: Alignment.center,
          height: 198.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: homeController.listSuggestedServices.length,
            itemBuilder: (ctx, index) {
              return Container(
                padding: EdgeInsets.only(
                    left: index > 0 ? kDefaultPaddingScreen.w : 2),
                child: Hero(
                  tag:
                      "suggest-${homeController.listSuggestedServices[index].id}",
                  child: VendorItem(
                      listType: "suggest",
                      price: "300.000đ",
                      vendorInfo: homeController.listSuggestedServices[index]),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  Widget renderCityPopup(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Container(
              margin: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      kDefaultPaddingWidget.h * 3),
              alignment: Alignment.topCenter,
              child: TodoPopupCity(
                onBack: (ProvinceData selectedProvince) {
                  homeController.handleUpdateSelectedProvince(selectedProvince);
                },
                listProvince: homeController.listProvinces,
                selectedProvince: homeController.selectedProvince.value,
              ),
            ),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: "popup-city",
        child: Container(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: homeController.currentAddress.value != "",
                child: Container(
                  margin: EdgeInsets.only(right: 5.w, bottom: 2.h),
                  width: 10.h,
                  height: 10.h,
                  child: Image.asset(ThemeServices().isDarkMode
                      ? AppPath.locationIconBlack
                      : AppPath.locationIconWhite),
                ),
              ),
              Text(
                  homeController.currentAddress.value != ""
                      ? homeController.currentAddress.value
                      : AccountServices().getAccountAddress(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500)),
              Visibility(
                visible: homeController.currentAddress.value != "",
                child: Container(
                  margin: EdgeInsets.only(left: 3.w, bottom: 1.h),
                  child: Icon(Ionicons.chevron_down_outline,
                      size: 12.sp, color: Theme.of(context).backgroundColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderListHotServices(
      BuildContext context, HomeController homeController) {
    if (homeController.isLoading.value == true) {
      return const VendorShimmerLoading();
    } else {
      return Container(
        padding: EdgeInsets.zero,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: homeController.listHotServices.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            return Hero(
              tag: "hot-${homeController.listHotServices[index].id}",
              child: VendorItemPrimary(
                // price: "300.000",
                listType: "hot",
                vendorInfo: homeController.listHotServices[index],
              ),
            );
          },
        ),
      );
    }
  }

  Widget renderMoreVendors(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: homeController.moreHostVendors.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return Hero(
            tag: "more-hot-${homeController.moreHostVendors[index].id}",
            child: VendorItemPrimary(
              // price: "300.000",
              listType: "more-hot",
              vendorInfo: homeController.moreHostVendors[index],
            ),
          );
        },
      ),
    );
  }

  Widget renderOrderStatus(BookingItemModel item) {
    if (item.status == BookingStatus.confirmed) {
      return Text(
        "scheduleAt".tr +
            " ${item.customerGetOrderTime} " +
            "at".tr +
            " ${item.vendor!.brandName}",
        maxLines: 2,
        style: subTitleStyle.copyWith(color: Colors.white, fontSize: 12.sp),
      );
    } else if (item.status == BookingStatus.checkedIn) {
      return Text("useServiceAt".tr + " ${item.vendor!.brandName} ",
          maxLines: 2,
          style: subTitleStyle.copyWith(color: Colors.white, fontSize: 12.sp));
    } else {
      return Container();
    }
  }
}
