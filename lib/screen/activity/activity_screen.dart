import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/screen/activity/activity_controller.dart';
import 'package:client_tggt/screen/activity/widget/activity_card.dart';
import 'package:client_tggt/screen/filter_vendors/widget/category_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/order_status_type.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/not_login_screen.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:client_tggt/shared/widget/popup_card/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ActivityScreen extends StatefulWidget {
  ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final MainController mainController =
      Get.put(MainController(getIt.get<ApiClient>()));
  ActivityController controller =
      Get.put(ActivityController(getIt.get<ApiClient>()));
  @override
  Widget build(BuildContext context) {
    controller.getListOrder(
        1, controller.statusParam.value, controller.cats.value);

    return Obx(
      () => Container(
          child: mainController.userToken.value == ""
              ? NotLoginScreen(
                  title: "loginHistoryTitle".tr,
                  subTitle: "loginHistorySubtitle".tr)
              : BaseScreen(
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Theme.of(context).primaryColor,
                          labelStyle: subTitleStyle.copyWith(
                              color: ThemeServices().isDarkMode
                                  ? kColorTextGrey
                                  : kColorTextLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp),
                          unselectedLabelColor: ThemeServices().isDarkMode
                              ? kColorTextGrey
                              : kColorTextLight,
                          unselectedLabelStyle: subTitleStyle.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 13.sp),
                          indicatorColor: Theme.of(context).primaryColor,
                          onTap: (index) {
                            controller.handleChangeTapIndex(index);
                          },
                          tabs: [
                            Tab(
                                text: controller.totalOrderActive.value > 0
                                    ? "Hoạt động (${controller.totalOrderActive.value})"
                                    : "Hoạt động"),
                            const Tab(text: "Lịch sử"),
                            Tab(
                                text: controller.waitingReviews.value > 0
                                    ? "Đánh giá (${controller.waitingReviews.value})"
                                    : "Đánh giá"),
                          ],
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPaddingScreen.w),
                          child: Column(
                            children: [
                              Visibility(
                                  visible: controller.tabIndex.value == 1,
                                  child: renderFilterBar(context)),
                              Expanded(
                                  child: controller.isLoading.isTrue
                                      ? const LoadingScreen()
                                      : controller.listOrdering.isEmpty
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      AppPath.emptyOrder),
                                                  renderEmptyStatus(controller
                                                      .tabIndex.value),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.zero,
                                              margin: EdgeInsets.only(
                                                  top: kDefaultPaddingItem.h),
                                              child: ListView.builder(
                                                  itemCount: controller
                                                      .listOrdering.length,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder: (c, i) {
                                                    final item = controller
                                                        .listOrdering[i];
                                                    return ActivityCard(
                                                        docData: item,
                                                        callback: () {});
                                                  }),
                                            )),
                              Container()
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                )),
    );
  }

  Widget renderFilterBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: kDefaultPaddingWidget.h),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Obx(() => Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 0.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  renderCategoryPopup(context),
                  SizedBox(
                    width: defaultPaddingItem.w,
                  ),
                  renderBookingStatusPopup(context),
                ],
              ),
            ),
          )),
    );
  }

  Widget renderCategoryPopup(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(
          builder: (context) => Container(
            margin: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    kDefaultPaddingWidget.h * 3),
            alignment: Alignment.topCenter,
            child: TodoPopupVendorType(
              onBack: (List<CategoryType> listCategory) {
                controller.handleUpdateListSelectedCategory(listCategory);
              },
              categories: controller.selectedCategory,
              listCategory: controller.listCategory,
            ),
          ),
        ));
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: "popup-type",
        child: Container(
            height: 25.h,
            decoration: BoxDecoration(
                border: Border.all(
                    width: controller.selectedCategory.isNotEmpty ? 1.w : 0.5.w,
                    color: controller.selectedCategory.isNotEmpty
                        ? ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black
                        : ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : HexColor(greyTextColor)),
                borderRadius: BorderRadius.circular(defaultBorderRadiusItem)),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: controller.selectedCategory.isNotEmpty
                        ? controller.selectedCategory[0].getType()
                        : "Danh mục",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: controller.selectedCategory.isNotEmpty
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black54),
                    children: controller.selectedCategory.length > 1
                        ? [
                            const TextSpan(text: ' +'),
                            TextSpan(
                                text:
                                    '${controller.selectedCategory.length - 1}'),
                          ]
                        : [],
                  ),
                ),
                SizedBox(
                  width: 6.h,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    Ionicons.caret_down_outline,
                    size: 12.sp,
                    color: ThemeServices().isDarkMode
                        ? kColorPrimaryDark
                        : HexColor(greyTextColor),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget renderBookingStatusPopup(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(
          builder: (context) => Container(
            margin: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    kDefaultPaddingWidget.h * 3),
            alignment: Alignment.topCenter,
            child: OrderStatusTypePopUp(
              onBack: (String selectedStatus) {
                controller.handleUpdateSelectedStatus(selectedStatus);
              },
              listStatus: controller.listOrderStatusType,
              selectedStatus: controller.selectedOrderStatus.value,
            ),
          ),
        ));
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: "popup-order-status",
        child: Container(
            height: 25.h,
            decoration: BoxDecoration(
                border: Border.all(
                    width: controller.selectedOrderStatus.value != ""
                        ? 1.w
                        : 0.5.w,
                    color: controller.selectedOrderStatus.value != ""
                        ? ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black
                        : ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : HexColor(greyTextColor)),
                borderRadius: BorderRadius.circular(defaultBorderRadiusItem)),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: controller.selectedOrderStatus.value != ""
                        ? bookingStatusStringToString(
                            controller.selectedOrderStatus.value)
                        : "Trạng thái",
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: controller.selectedCategory.isNotEmpty
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black54),
                  ),
                ),
                SizedBox(
                  width: 6.h,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    Ionicons.caret_down_outline,
                    size: 12.sp,
                    color: ThemeServices().isDarkMode
                        ? kColorPrimaryDark
                        : HexColor(greyTextColor),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget renderEmptyStatus(int index) {
    if (index == 0) {
      return Text("Bạn chưa có hoạt động nào đang diễn ra!", style: titleStyle);
    } else if (index == 1) {
      return Text("Bạn chưa có lịch sử hoạt động", style: titleStyle);
    } else if (index == 2) {
      return Text("Bạn chưa có lịch hẹn nào để đánh giá", style: titleStyle);
    } else {
      return Container();
    }
  }
}
