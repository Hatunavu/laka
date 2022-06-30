import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/booking/create_order/vendor_create_order_controller.dart';
import 'package:client_tggt/screen/vendors/booking/vendor_booking_controller.dart';
import 'package:client_tggt/screen/vendors/booking/widget/booking_item.dart';
import 'package:client_tggt/screen/vendors/booking/widget/booking_list_shimmer.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class VendorBookingScreen extends StatefulWidget {
  VendorBookingScreen({Key? key}) : super(key: key);

  @override
  State<VendorBookingScreen> createState() => _VendorBookingScreenState();
}

class _VendorBookingScreenState extends State<VendorBookingScreen> {
  final VendorBookingController controller =
      Get.put(VendorBookingController(getIt.get<ApiClient>()));
  @override
  void initState() {
    setState(() {
      controller.getListBooking("", "", "", controller.limit.value, 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.router.push(VendorsCreateOrderPage(onBack: () {
              controller.getListBooking("", "", "", controller.limit.value, 1);
            })).then((value) => {Get.delete<VendorCreateOrderController>()});
          },
          backgroundColor: kColorPrimaryLight,
          child: const Icon(Ionicons.add, color: Colors.white),
        ),
        child: Container(
          decoration:
              BoxDecoration(color: HexColor(greyLightColor).withOpacity(.3)),
          margin: EdgeInsets.only(
              top: kDefaultPaddingWidget.h - 5,
              bottom: kDefaultPaddingWidget.h),
          child: Obx(() => controller.isLoading.isTrue
              ? const BookingListShimmer()
              : Column(
                  children: [
                    renderSeachBar(context, controller),
                    controller.listBooking.isNotEmpty
                        ? renderListBooking(context, controller)
                        : renderEmptyBooing(context)
                  ],
                )),
        ));
  }
}

Widget renderEmptyBooing(BuildContext context) {
  return Expanded(
      child: Container(
    alignment: Alignment.center,
    child: Text("cantFindResult2".tr,
        textAlign: TextAlign.center, style: titleStyle),
  ));
}

Widget renderListBooking(
    BuildContext context, VendorBookingController controller) {
  return Expanded(
      child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 1000));
              controller.getListBooking("", "", "", controller.limit.value, 1);
            },
            child: ListView.builder(
                shrinkWrap: true,
                controller: controller.listViewBookingController,
                padding: EdgeInsets.zero,
                itemCount: controller.listBooking.length,
                itemBuilder: (context, int index) {
                  final BookingItemModel item = controller.listBooking[index];
                  return BookingItem(
                    bookingItem: item,
                    controller: controller,
                    // callback: (BookingItemModel orderItem) {
                    //   // controller.getListBooking(
                    //   //     "", "", "", controller.limit.value, 1);
                    //   inspect(orderItem);
                    // },
                  );
                }),
          )));
}

Widget customeCheckBox(BuildContext context) {
  return Container(
    width: 26.w,
    height: 26.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        border: Border.all(color: HexColor("#949AA9"))),
  );
}

Widget renderLineContainer(BuildContext context) {
  return Container(
    height: kDefaultPaddingWidget.h * 2,
    alignment: Alignment.center,
    child: Container(
      height: 1,
      decoration: BoxDecoration(color: HexColor("#D8D8D8")),
    ),
  );
}

Widget renderSeachBar(
    BuildContext context, VendorBookingController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    color: Colors.white,
    child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
        width: double.infinity,
        height: 40.h,
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
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => renderBottomSheet(context),
                  isScrollControlled: true,
                  enableDrag: true,
                );
              },
              // child: Image.asset(AppPath.iconFilterRed,
              //     width: 30.w, height: 30.w),
              child: const Icon(
                Ionicons.filter_sharp,
                size: 30,
              ),
            )
          ],
        )),
  );
}

Widget renderBottomSheet(BuildContext context) {
  final VendorBookingController controller =
      Get.put(VendorBookingController(getIt.get<ApiClient>()));
  return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.only(
          left: kDefaultPaddingScreen.w,
          right: kDefaultPaddingScreen.w,
          top: kDefaultPaddingScreen.h * 2,
          bottom: kDefaultPaddingWidget.h * 2),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "filter".tr,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: HexColor(secondaryColorLight)),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  color: HexColor(secondaryColorLight),
                ),
              )
            ],
          ),
          renderLineContainer(context),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: controller.listStatus.length,
                  itemBuilder: (item, int index) {
                    return Obx(
                      () => Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: defaultPaddingItem.w),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.listStatus[index],
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              InkWell(
                                  onTap: () {
                                    controller.handleChangeSelectedIndex(index);
                                  },
                                  child: Container(
                                    width: 24.w,
                                    height: 24.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: HexColor(controller
                                                        .selectedIndex.value ==
                                                    index
                                                ? "#ED1D1D"
                                                : "#949AA9"))),
                                    child: Visibility(
                                      visible: controller.selectedIndex.value ==
                                          index,
                                      child: Icon(Icons.check,
                                          size: 20,
                                          color: HexColor(secondaryColorLight)),
                                    ),
                                  ))
                            ]),
                      ),
                    );
                  })),
          renderLineContainer(context),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "time".tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Obx(() => Container(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          getStartDateFromUser(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width:
                              (MediaQuery.of(context).size.width - 20) / 2 - 8,
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: HexColor("#979797"), width: 1),
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius)),
                          child: Text(DateFormat("dd / MM / yyyy")
                              .format(controller.startDate.value)),
                        )),
                    InkWell(
                        onTap: () {
                          getEndDateFromUser(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width:
                              (MediaQuery.of(context).size.width - 20) / 2 - 8,
                          padding: const EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: HexColor("#979797"), width: 1),
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius)),
                          child: Text(DateFormat("dd / MM / yyyy")
                              .format(controller.endDate.value)),
                        ))
                  ],
                ),
              )),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          InkWellButton(
              label: "apply".tr,
              borderWidth: 1,
              onPressed: () {
                controller.handleChangeStatusListBooking();
              },
              borderColor: HexColor(secondaryColorLight),
              backgroundColor: Colors.transparent,
              textColor: HexColor(secondaryColorLight))
        ],
      ));
}

getStartDateFromUser(dynamic context) async {
  final VendorBookingController controller =
      Get.put(VendorBookingController(getIt.get<ApiClient>()));
  DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: controller.startDate.value,
      firstDate: DateTime(2016),
      lastDate: DateTime.now());

  if (_pickerDate != null) {
    controller.handleChangeStartDate(_pickerDate);
  } else {
    log("it's null or something is wrong");
  }
}

getEndDateFromUser(dynamic context) async {
  final VendorBookingController controller =
      Get.put(VendorBookingController(getIt.get<ApiClient>()));
  DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime.now());

  if (_pickerDate != null) {
    controller.handleChangeEndDate(_pickerDate);
  } else {
    log("it's null or something is wrong");
  }
}

getStartDateFromUser2(dynamic context) async {
  final todayDate = DateTime.now();
  showDatePicker(
    context: context,
    initialDatePickerMode: DatePickerMode.year,
    initialEntryMode: DatePickerEntryMode.calendar,
    initialDate: DateTime(todayDate.year - 18, todayDate.month, todayDate.day),
    firstDate: DateTime(todayDate.year - 90, todayDate.month, todayDate.day),
    lastDate: DateTime(todayDate.year - 18, todayDate.month, todayDate.day),
  ).then((value) {
    inspect(value);
  });
}
