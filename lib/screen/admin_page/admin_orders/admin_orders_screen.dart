import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/screen/admin_page/admin_orders/admin_orders_controller.dart';
import 'package:client_tggt/screen/admin_page/admin_orders/widget/admin_orders_item.dart';
import 'package:client_tggt/screen/filter_vendors/widget/category_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/order_status_type.dart';
import 'package:client_tggt/screen/vendors/booking/vendor_booking_screen.dart';
import 'package:client_tggt/screen/vendors/booking/widget/booking_list_shimmer.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:client_tggt/shared/widget/popup_card/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class AdminOrdersScreen extends StatefulWidget {
  AdminOrdersScreen({Key? key}) : super(key: key);

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final AdminOrdersController controller =
      Get.put(AdminOrdersController(getIt.get<ApiClient>()));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        child: Container(
      decoration:
          BoxDecoration(color: HexColor(greyLightColor).withOpacity(.3)),
      margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
      child: Obx(() => Column(
            children: [
              renderTabService(context),
              AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  color: Theme.of(context).backgroundColor,
                  height: controller.isVisible.value ? 43.h : 0,
                  child: renderSeachBar(context)),
              // Container(
              //   margin: EdgeInsets.only(top: 5.h),
              //   child: AnimatedContainer(
              //       duration: const Duration(milliseconds: 200),
              //       color: Theme.of(context).backgroundColor,
              //       alignment: Alignment.center,
              //       height: controller.isVisible.value ? 33.h : 0,
              //       child: renderFilterTab(context)),
              // ),
              Visibility(
                  visible: controller.isShowFilter.isTrue,
                  child: renderFilterTab(context)),

              renderListBooking(context)
            ],
          )),
    ));
  }

  Widget renderSeachBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      color: Colors.white,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
          width: double.infinity,
          height: 32.h,
          decoration: BoxDecoration(
            border: Border.all(color: darkGreyClr.withOpacity(.3), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  controller.dispose();
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    Ionicons.search_outline,
                    color: Colors.grey,
                    size: 18.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: TextFormField(
                  cursorColor: Theme.of(context).primaryColor,
                  // showCursor: false,
                  onChanged: (text) {
                    controller.handleSearchText(text);
                  },
                  style: AppTextStyle().subtitleRegular14.copyWith(height: 1.2),
                  controller: controller.searchText.value,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'search'.tr,
                  ),
                ),
              ),
              SizedBox(
                width: defaultPaddingItem.w,
              ),
              GestureDetector(
                onTap: () {
                  controller.isShowFilter.value =
                      !controller.isShowFilter.value;
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    Ionicons.filter_outline,
                    size: 18.sp,
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget renderListBooking(BuildContext context) {
    return Expanded(
        child: controller.isLoading.isTrue
            ? const BookingListShimmer()
            : Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 1000));
                    controller.getListOrders(1, "", "", "", "", "", "", "", "");
                  },
                  child: controller.listBooking.isEmpty
                      ? renderEmptyBooing(context)
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: controller.listViewBookingController,
                          padding: EdgeInsets.zero,
                          itemCount: controller.listBooking.length,
                          itemBuilder: (context, int index) {
                            final BookingItemModel item =
                                controller.listBooking[index];
                            return AdminOrderItem(
                              bookingItem: item,
                              onBack: (BookingItemModel item) {
                                controller.listBooking[index] = item;
                              },
                            );
                          }),
                )));
  }

  Widget renderTabService(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPaddingItem.w, vertical: kDefaultPaddingItem.h),
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 6.h),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                controller.handleChangeTab(0);
              },
              child: Container(
                height: 28.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.tabIndex.value == 0
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.r),
                      bottomLeft: Radius.circular(6.r)),
                  border: Border.all(
                      width: controller.tabIndex.value == 0 ? 0 : 0.5.w,
                      color: controller.tabIndex.value == 0
                          ? Theme.of(context).primaryColor
                          : kColorGreyLight),
                ),
                child: Text("Tất cả",
                    style: subTitleStyle.copyWith(
                        fontSize: 12.sp,
                        color: controller.tabIndex.value == 0
                            ? Theme.of(context).backgroundColor
                            : kColorGreyLight)),
              ),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                controller.handleChangeTab(1);
              },
              child: Container(
                height: 28.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: controller.tabIndex.value == 1
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).backgroundColor,
                    border: Border(
                        top: BorderSide(
                            width: 0.5.w,
                            color: controller.tabIndex.value == 1
                                ? Theme.of(context).primaryColor
                                : kColorGreyLight),
                        bottom: BorderSide(
                            width: 0.5.w,
                            color: controller.tabIndex.value == 1
                                ? Theme.of(context).primaryColor
                                : kColorGreyLight))),
                child: Text("Đã ký",
                    style: subTitleStyle.copyWith(
                        fontSize: 12.sp,
                        color: controller.tabIndex.value == 1
                            ? Theme.of(context).backgroundColor
                            : kColorGreyLight)),
              ),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                controller.handleChangeTab(2);
              },
              child: Container(
                height: 28.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: controller.tabIndex.value == 2
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6.r),
                        bottomRight: Radius.circular(6.r)),
                    border: Border.all(
                        width: controller.tabIndex.value == 2 ? 0 : 0.5.w,
                        color: controller.tabIndex.value == 2
                            ? Theme.of(context).primaryColor
                            : kColorGreyLight)),
                child: Text("Chưa ký",
                    style: subTitleStyle.copyWith(
                        fontSize: 12.sp,
                        color: controller.tabIndex.value == 3
                            ? Theme.of(context).backgroundColor
                            : kColorGreyLight)),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget renderEmptyBooing(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("cantFindResult2".tr,
          textAlign: TextAlign.center, style: titleStyle),
    );
  }

  Widget renderFilterTab(BuildContext context) {
    return Container(
      height: 33.h,
      padding: EdgeInsets.symmetric(
          vertical: 5.h, horizontal: kDefaultPaddingScreen.w),
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            renderCategory(context),
            SizedBox(
              width: defaultPaddingItem.w,
            ),
            renderBookingStatusPopup(context),
          ],
        ),
      ),
    );
  }

  Widget renderCategory(BuildContext context) {
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
                    width: 0.5.w,
                    color: controller.selectedCategory.isNotEmpty
                        ? kColorPrimaryLight
                        : Colors.black54),
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
                        : "category2".tr,
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: controller.selectedCategory.isNotEmpty
                            ? FontWeight.w500
                            : FontWeight.w400,
                        color: controller.selectedCategory.isNotEmpty
                            ? kColorPrimaryLight
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
                    color: controller.selectedCategory.isNotEmpty
                        ? kColorPrimaryLight
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
              listStatus: controller.listStatus,
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
                    width: 0.5.w,
                    color: controller.selectedOrderStatus.value != ""
                        ? kColorPrimaryLight
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
                            ? FontWeight.w500
                            : FontWeight.w400,
                        color: controller.selectedOrderStatus.value != ""
                            ? kColorPrimaryLight
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
                    color: controller.selectedOrderStatus.value != ""
                        ? kColorPrimaryLight
                        : HexColor(greyTextColor),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
