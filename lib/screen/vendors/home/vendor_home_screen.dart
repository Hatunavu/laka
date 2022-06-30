import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor_page/dashboard/vendor_dashboard_response.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/home/vendor_home_controller.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class VendorHomeScreen extends StatelessWidget {
  const VendorHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorsHomeController controller =
        Get.put(VendorsHomeController(getIt.get<ApiClient>()));
    final VendorMainController mainController =
        Get.put(VendorMainController(getIt.get<ApiClient>()));

    return Obx(() => controller.isLoading.isTrue
        ? const LoadingScreen()
        : Scaffold(
            backgroundColor: kColorPrimaryLight,
            body: SafeArea(
                child: Column(
              children: [
                renderHeader(context, controller, mainController),
                Expanded(
                  child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPaddingScreen.w,
                          vertical: kDefaultPaddingWidget.h),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  child: Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              32.w,
                                          padding: EdgeInsets.zero,
                                          height: 36,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  controller.listStatus.length,
                                              itemBuilder: (item, int index) {
                                                return Obx(
                                                  () => InkWell(
                                                      onTap: () {
                                                        controller
                                                            .changeSelectedIndex(
                                                                index);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w,
                                                                vertical: 6.h),
                                                        decoration: BoxDecoration(
                                                            color: controller
                                                                        .selectedIndex
                                                                        .value ==
                                                                    index
                                                                ? Colors.white
                                                                : Colors
                                                                    .grey[100],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.r),
                                                            border: Border.all(
                                                                color: controller
                                                                            .selectedIndex
                                                                            .value ==
                                                                        index
                                                                    ? kColorPrimaryLight
                                                                    : Colors
                                                                        .transparent)),
                                                        margin: EdgeInsets.only(
                                                            right: 8.w),
                                                        child: Text(controller
                                                            .listStatus[index]),
                                                      )),
                                                );
                                              })),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                  visible: controller.selectedIndex.value == 3,
                                  child: renderTimer(context, controller)),
                              SizedBox(
                                height: kDefaultPaddingItem.h - 3.h,
                              ),
                              renderListDashboard(context, controller),
                              controller.isShowChangeTime.isTrue &&
                                      controller.selectedIndex.value == 3
                                  ? renderSelectTimeContainer(
                                      context, controller)
                                  : Container(),
                              controller.chartData.length > 1
                                  ? renderRevenue(context, controller)
                                  : Container(),
                              renderManagerService(context, controller),
                            ]),
                      )),
                ),
              ],
            ))));
  }
}

Widget renderHeader(BuildContext context, VendorsHomeController controller,
    VendorMainController mainController) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: kDefaultPaddingItem.h),
    decoration: const BoxDecoration(color: kColorPrimaryLight),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
          child: Container(
            width: 86.w,
            height: 68.h,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius.r),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        mainController.account.value.getVendorThumnail ?? ""),
                    fit: BoxFit.cover)),
          ),
        ),
        SizedBox(
          width: kDefaultPaddingItem.w,
        ),
        Expanded(
          child: Container(
            height: 68.h,
            padding: EdgeInsets.symmetric(vertical: defaultPaddingItem.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  mainController.account.value.vendorBrandname ?? "",
                  style: titleStyle.copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: defaultPaddingItem.h,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 15.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      if (mainController.account.value.vendor!.avgRating ==
                          null) {
                        return Container(
                            padding: EdgeInsets.only(right: 3.w),
                            child: Icon(Ionicons.star_outline,
                                color: Colors.white, size: 15.sp));
                      } else {
                        return Container(
                            padding: EdgeInsets.only(right: 3.w),
                            child: index <
                                    (mainController.account.value.vendor!
                                                .avgRating ??
                                            0)
                                        .toInt()
                                ? Icon(Ionicons.star,
                                    color: Colors.white, size: 15.sp)
                                : Icon(Ionicons.star_outline,
                                    color: Colors.white, size: 15.sp));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            context.router.push(const ScanQRScreenPage());
          },
          child: Icon(
            MaterialCommunityIcons.qrcode_scan,
            color: Theme.of(context).backgroundColor,
            size: 25.h,
          ),
        ),
        SizedBox(
          width: kDefaultPaddingWidget.w,
        )
      ],
    ),
  );
}

Widget renderTimer(BuildContext context, VendorsHomeController controller) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultBorderRadius.r),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: const Offset(0, 3),
              blurRadius: 5.0,
              spreadRadius: 0)
        ]),
    padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingItem.w, vertical: kDefaultPaddingItem.h),
    margin: EdgeInsets.only(top: kDefaultPaddingItem.h),
    child: GestureDetector(
      onTap: () {
        if (controller.isShowChangeTime.isTrue) {
          controller.isShowChangeTime.value = false;
        } else {
          controller.isShowChangeTime.value = true;
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("timeReport".tr),
            Icon(
              controller.isShowChangeTime.isTrue
                  ? Ionicons.chevron_up_outline
                  : Ionicons.chevron_down_outline,
              size: 18,
            )
          ],
        ),
      ),
    ),
  );
}

renderSelectTimeContainer(
    BuildContext context, VendorsHomeController controller) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(defaultBorderRadius.r),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: const Offset(0, 3),
              blurRadius: 5.0,
              spreadRadius: 0)
        ]),
    margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
    padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingItem.w, vertical: kDefaultPaddingWidget.h),
    child: Column(
      children: [
        SfDateRangePicker(
          onSelectionChanged: controller.onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.range,
          initialSelectedRange: PickerDateRange(
              controller.startDate.value.subtract(const Duration(days: 4)),
              controller.endDate.value.add(const Duration(days: 3))),
        ),
        InkwellButtonLoading(
            label: "showResult".tr,
            maxHeight: 35.h,
            onPressed: () {
              controller.handleGetVendorDashboardByTime();
            })
      ],
    ),
  );
}

Widget renderListDashboard(
    BuildContext context, VendorsHomeController controller) {
  return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("importantStats".tr,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: renderDashboardItem(
                          context,
                          const Color(0xFF61DA97),
                          controller,
                          AppPath.dashboardRevenue,
                          "turnover".tr,
                          controller.revenueData.value.getRevenueData,
                          false,
                          "14%")),
                  SizedBox(
                    width: kDefaultPaddingWidget.w,
                  ),
                  Expanded(
                    child: renderDashboardItem(
                        context,
                        const Color(0xFF86BEF2),
                        controller,
                        AppPath.dashboardOrder,
                        "billAmount".tr,
                        '${controller.completedOrders.value + controller.canceledOrders.value}',
                        false,
                        "14%"),
                  )
                ],
              ),
              SizedBox(
                height: kDefaultPaddingWidget.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: renderDashboardItem(
                          context,
                          const Color(0xFFF97B4F),
                          controller,
                          AppPath.dashboardCustomer,
                          "customerAmount".tr,
                          '${controller.totalCustomers.value}',
                          false,
                          "18%")),
                  SizedBox(
                    width: kDefaultPaddingWidget.w,
                  ),
                  Expanded(
                    child: renderDashboardItem(
                        context,
                        const Color(0xFFFE7479),
                        controller,
                        AppPath.dashboardSee,
                        "views".tr,
                        '${controller.totalViews.value}',
                        false,
                        "10%"),
                  )
                ],
              ),
              SizedBox(
                height: kDefaultPaddingWidget.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: renderDashboardItem(
                          context,
                          const Color(0xFF979CF3),
                          controller,
                          AppPath.dashboardFavourite,
                          "favorite".tr,
                          '${controller.totalFavorites.value}',
                          true,
                          "12%")),
                  SizedBox(
                    width: kDefaultPaddingWidget.w,
                  ),
                  Expanded(
                    child: renderDashboardItem(
                        context,
                        const Color(0xFFE4A1E2),
                        controller,
                        AppPath.dashboardReview,
                        "review".tr,
                        "150",
                        false,
                        "10%"),
                  )
                ],
              )
            ],
          )
        ],
      ));
}

Widget renderRevenue(BuildContext context, VendorsHomeController controller) {
  return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("revenueChart".tr,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: false),
              // plotAreaBorderWidth: 1,
              margin: EdgeInsets.fromLTRB(0, 20.h, 0, 16.h),
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryYAxis: NumericAxis(
                  // Y axis labels will be rendered with currency format
                  numberFormat: NumberFormat('# m', 'ID')),
              series: <LineSeries<RevenueItem, String>>[
                LineSeries<RevenueItem, String>(
                    dataSource: controller.chartData,
                    xValueMapper: (RevenueItem sales, _) => sales.id,
                    yValueMapper: (RevenueItem sales, _) =>
                        sales.totalAmountItemConver,
                    // controller.revenueData[0].totalAmount,
                    color: kColorPrimaryLight,

                    // Enable data label
                    dataLabelSettings:
                        const DataLabelSettings(isVisible: false))
              ]),
        ],
      ));
}

Widget renderManagerService(
    BuildContext context, VendorsHomeController controller) {
  return Container(
    padding: EdgeInsets.only(
        bottom: kDefaultPaddingWidget.h, top: kDefaultPaddingWidget.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.w),
          child: Text("service".tr,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width - 20.w,
          barRadius: Radius.circular(8.r),
          animation: true,
          lineHeight: 8.0.h,
          animationDuration: 2500,
          percent: 0.8,
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.green,
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        Container(
          padding: EdgeInsets.only(left: 12.w, right: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 15.w,
                    height: 15.w,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: kDefaultPaddingWidget.w,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    child: Text(
                      "checkedIn".tr + ":",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 3.h),
                child: Text(
                  '${controller.totalActiveProducts.value}',
                  style: TextStyle(fontSize: 18.sp, color: Colors.green),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        Container(
          padding: EdgeInsets.only(left: 12.w, right: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 15.w,
                    height: 15.w,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: kDefaultPaddingWidget.w,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    child: Text(
                      "emptyService".tr,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 3.h),
                child: Text(
                  "${controller.totalAvailableProducts.value}",
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget renderDashboardItem(
    BuildContext context,
    Color color,
    VendorsHomeController controller,
    String iconPath,
    String title,
    String content,
    bool isLower,
    String percent) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h),
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: const Offset(0, 3),
              blurRadius: 5.0,
              spreadRadius: 0)
        ]),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              image: DecorationImage(image: AssetImage(iconPath))),
        ),
        SizedBox(
          width: kDefaultPaddingWidget.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              content,
              style: TextStyle(
                  fontSize: 23.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Row(
                children: [
                  isLower == true
                      ? Icon(
                          Ionicons.caret_down_outline,
                          color: Colors.red,
                          size: 18.sp,
                        )
                      : Icon(
                          Ionicons.caret_up_outline,
                          color: Colors.green,
                          size: 18.sp,
                        ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    // child: Text(
                    //   percent,
                    //   style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    // ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}
