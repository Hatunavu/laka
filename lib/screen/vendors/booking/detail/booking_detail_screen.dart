import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/extensions/currency_formatting.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:client_tggt/router/app_router.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/booking/confirm_complete/confirm_complete_controller.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_controller.dart';
import 'package:client_tggt/screen/vendors/booking/upload_bill/upload_bill_controller.dart';
import 'package:client_tggt/screen/vendors/booking/widget/booking_detail_shimmer.dart';
import 'package:client_tggt/screen/vendors/booking/widget/menu_order_item.dart';
import 'package:client_tggt/screen/vendors/profile/menu/select_menu/selected_menu_controller.dart';
import 'package:client_tggt/screen/vendors_gallery/widgets/vendors_gallery_detail_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/booking_status.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/dialog/dialog_textfield.dart';
import 'package:client_tggt/shared/widget/text_currency.dart';
import 'package:client_tggt/shared/widget/textfield/custome_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BookingDetailScreen extends StatefulWidget {
  BookingDetailScreen({Key? key, this.bookingId, this.parentPage, this.onBack})
      : super(key: key);
  final String? bookingId;
  final String? parentPage;
  final Function(
    BookingItemModel orderItem,
  )? onBack;
  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  final BookingDetailController controller =
      Get.put(BookingDetailController(getIt.get<ApiClient>()));

  @override
  void initState() {
    controller.handlegetBookingDetail(widget.bookingId!, widget.parentPage!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseScreen(
          title: "bookingInfor".tr,
          leading: IconButton(
              onPressed: () async {
                if (controller.parentPage.value == "booking_list") {
                  await widget.onBack?.call(controller.bookingDetail.value);

                  context.router.pop();
                } else if (controller.parentPage.value == "qrcode") {
                  // Get.toNamed(AppRoutes.vendorListScreen);

                  context.router.pushNamed(AppRoutes.vendorListScreen);
                }
              },
              //chevron-back-outline
              icon: const Icon(
                Ionicons.chevron_back_outline,
                size: 23,
                color: Colors.black,
              )),
          child: controller.isLoading.isTrue
              ? const BookingDetailShimmer()
              : Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPaddingScreen.w,
                      vertical: kDefaultPaddingWidget.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            padding: EdgeInsets.zero,
                            child: controller.statusResponse.value == 1
                                ? renderBookingInfo(context)
                                : Container(
                                    alignment: Alignment.center,
                                    child: Text("cantFindBookingInfor".tr,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        textAlign: TextAlign.center)),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (controller.bookingDetail.value.status !=
                                BookingStatus.completed ||
                            controller.bookingDetail.value.status !=
                                BookingStatus.reviewed),
                        child: SizedBox(
                          height: defaultPaddingItem.w * 2,
                        ),
                      ),
                      Visibility(
                        visible: (controller.bookingDetail.value.status !=
                                BookingStatus.completed ||
                            controller.bookingDetail.value.status !=
                                BookingStatus.reviewed),
                        child: renderActionButton(context),
                      ),
                    ],
                  )),
        ));
  }

  Widget renderActionButton(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Visibility(
                visible: (controller.bookingDetail.value.status ==
                        BookingStatus.checkedIn) &&
                    controller.statusResponse.value == 1,
                child: Column(
                  children: [
                    InkWellButton.outline(
                      label: "Thêm đồ",
                      borderRadius: BorderRadius.circular(12.r),
                      onPressed: () {
                        context.router
                            .push(SelectMenuPage(
                                selectedMenu: controller.listMenu,
                                onBack: (List<SelectedMenuItemModel> listMenu) {
                                  controller
                                      .handleUpdateListSelectedMenu(listMenu);
                                }))
                            .then((value) =>
                                {Get.delete<SelectedMenuController>()});
                      },
                    ),
                    SizedBox(height: 10.h),
                    InkWellButton.outline(
                      label: "Thêm phụ phí",
                      borderRadius: BorderRadius.circular(12.r),
                      onPressed: () {
                        context.router.push(AddSubFeePage(
                            onBack: (String name, double price, String note) {
                          controller.handleUpdateSubFee(name, price, note);
                        }));
                      },
                    ),
                    SizedBox(height: 10.h),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: renderCompleteButton(context),
                          ),
                          Container()
                        ]),
                  ],
                )),
            Visibility(
                visible: (controller.bookingDetail.value.status ==
                        BookingStatus.completed) &&
                    controller.statusResponse.value == 1,
                child: controller.bookingDetail.value.receipt == null
                    ? Container()
                    : controller.bookingDetail.value.receipt!.images!.isEmpty
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                                Expanded(
                                  child: renderUploadBillButton(context),
                                ),
                                Container()
                              ])
                        : Container()),
            Visibility(
                visible: (controller.bookingDetail.value.status ==
                        BookingStatus.confirmed) &&
                    controller.statusResponse.value == 1,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: renderCheckInButton(context),
                      ),
                      SizedBox(
                        width: kDefaultPaddingWidget.w,
                      ),
                      Expanded(
                        child: renderCancelButton(context),
                      )
                    ])),
            Visibility(
                visible: (controller.bookingDetail.value.status ==
                        BookingStatus.pending) &&
                    controller.statusResponse.value == 1,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: renderConfirmButton(context),
                      ),
                      SizedBox(
                        width: kDefaultPaddingWidget.w,
                      ),
                      Expanded(
                        child: renderCancelButton(context),
                      )
                    ])),
          ],
        ));
  }

  Widget renderCheckInButton(BuildContext context) {
    return Column(
      children: [
        InkwellButtonLoading(
          isLoading: controller.isUpdateLoading.isTrue,
          onPressed: () {
            controller.handleUpdateBooking(BookingStatus.checkedIn, false);
          },
          label: "checkin".tr,
        ),
      ],
    );
  }

  Widget renderCompleteButton(BuildContext context) {
    return Column(
      children: [
        InkwellButtonLoading(
          isLoading: controller.isUpdateLoading.isTrue,
          onPressed: () {
            context.router
                .push(ConfirmCompletePage(
                    defaultPrice: controller.bookingDetail.value.getFinalPrice!
                        .toStringAsFixed(0),
                    onBack: (String totalPrice, String discountPercent,
                        String finalPrice, List<String> listImage) {
                      controller.handleUpdateComplete(
                          totalPrice, discountPercent, listImage);
                    }))
                .then((value) {
              Get.delete<ConfirmCompleteController>();
            });
          },
          label: "complete".tr,
        ),
      ],
    );
  }

  Widget renderUploadBillButton(BuildContext context) {
    return Column(
      children: [
        InkwellButtonLoading(
          isLoading: controller.isUpdateLoading.isTrue,
          onPressed: () {
            context.router
                .push(UploadBillPage(onBack: (List<String> listImage) {
              inspect(listImage);
              controller.handleUpdateBillImage(listImage);
            })).then((value) {
              Get.delete<UploadBillController>();
            });
          },
          label: "Cập nhật hoá đơn",
        ),
      ],
    );
  }

  Widget renderCancelButton(BuildContext context) {
    return Column(
      children: [
        InkwellButtonLoading(
            isLoading: controller.isUpdateLoading.isTrue,
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) {
                  return DialogTextField(
                    context: context,
                    controller: controller.cancelController.value,
                    hint: "reasonCancel".tr,
                    title: 'cancelService'.tr,
                    minLines: 1,
                    confirmTitlel: "confirm".tr.toLowerCase(),
                    onConfirm: () {
                      Navigator.pop(context);
                      controller.handleUpdateBooking(
                          BookingStatus.canceled, true);
                    },
                    onDismiss: () {
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
            label: "canceled".tr,
            backgroundColor: Colors.grey[300],
            textColor: Colors.black),
      ],
    );
  }

  Widget renderConfirmButton(BuildContext context) {
    return Column(
      children: [
        InkwellButtonLoading(
          isLoading: controller.isUpdateLoading.isTrue,
          onPressed: () {
            controller.handleUpdateBooking(BookingStatus.confirmed, false);
          },
          label: "confirm".tr,
        ),
      ],
    );
  }

  Widget renderBookingInfo(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 4,
                      child: Text(
                        "scheduleCode".tr,
                        style: titleStyle,
                      )),
                  Expanded(
                      flex: 6,
                      child: Text(
                        '${controller.bookingDetail.value.orderId}',
                        style: titleStyle,
                      ))
                ],
              ),
              SizedBox(
                height: kDefaultPaddingWidget.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 4,
                      child: Text(
                        "schedule".tr,
                        style: titleStyle,
                      )),
                  Expanded(
                      flex: 6,
                      child: Text(
                        DateFormat("dd-MM-yyyy")
                            .format(controller.bookingDetail.value.createdAt!),
                        style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                      ))
                ],
              ),
              SizedBox(
                height: kDefaultPaddingWidget.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 4,
                      child: Text(
                        "status".tr + ": ",
                        style: titleStyle,
                      )),
                  Expanded(
                      flex: 6,
                      child: BookingStatusWidget(
                          type: controller.bookingDetail.value.status))
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(color: Colors.grey.withOpacity(.6)),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        controller.bookingDetail.value.status == BookingStatus.billPending
            ? renderQrCode(context)
            : renderOrderInformation(context),
        SizedBox(
          height: kDefaultPaddingWidget.h * 2,
        ),
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(color: Colors.grey.withOpacity(.6)),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        Visibility(
            visible: controller.bookingDetail.value.menuItems != null,
            child: controller.bookingDetail.value.menuItems!.isNotEmpty
                ? renderMenu(context)
                : Container()),
        Visibility(
            visible: controller.bookingDetail.value.subFees != null,
            child: controller.bookingDetail.value.subFees!.isNotEmpty
                ? renderSubFees(context)
                : Container()),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "paymentInfor".tr,
                    style: titleStyle,
                  ),
                  Expanded(
                    child:
                        Text(controller.bookingDetail.value.statusPayment ?? "",
                            maxLines: 2,
                            style: TextStyle(
                              color: HexColor(secondaryColorLight),
                              fontSize: 14.sp,
                            )),
                  )
                ],
              ),
              SizedBox(
                height: kDefaultPaddingWidget.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "servicePrice".tr,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  TextCurrency(
                    title: '${controller.bookingDetail.value.getTotalPrice}',
                    textStyle: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              Visibility(
                visible: controller.bookingDetail.value.totalMenuPrice != null,
                child: SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
              ),
              Visibility(
                visible: controller.bookingDetail.value.totalMenuPrice != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tổng menu:",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    TextCurrency(
                      title: '${controller.bookingDetail.value.totalMenuPrice}',
                      textStyle: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: kDefaultPaddingWidget.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tổng phụ phí:",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  // Text(
                  //     controller.bookingDetail.value.totalSubFeePrice
                  //         .toString(),
                  //     style: titleStyle.copyWith(
                  //         fontSize: 13.sp, color: kColorPrimaryLight))
                  TextCurrency(
                    title: '${controller.bookingDetail.value.totalSubFeePrice}',
                    textStyle: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              SizedBox(
                height: kDefaultPaddingWidget.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "discount3".tr,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  // TextCurrency(
                  //   title:
                  //       '${controller.bookingDetail.value.getDiscountPercent ?? ""}',
                  //   textStyle: TextStyle(fontSize: 14.sp),
                  // ),
                  RichText(
                    text: TextSpan(
                      text:
                          '${controller.bookingDetail.value.getDiscountPercent}',
                      style: subTitleStyle.copyWith(color: kColorPrimaryLight),
                      children: const <TextSpan>[
                        TextSpan(text: ' %'),
                      ],
                    ),
                  )
                ],
              ),
              if (controller.bookingDetail.value.voucherDiscount != null)
                Container(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        SizedBox(
                          height: kDefaultPaddingWidget.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Voucher:",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            Text(
                              controller.bookingDetail.value.getDiscountAmount,
                              style: subTitleStyle.copyWith(
                                  color: kColorPrimaryLight),
                            ),
                          ],
                        ),
                      ],
                    )),
              SizedBox(
                height: defaultPaddingItem.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                width: double.infinity,
                height: 1,
                decoration: BoxDecoration(color: Colors.grey.withOpacity(.6)),
              ),
              SizedBox(
                height: defaultPaddingItem.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "total".tr,
                    style: titleStyle,
                  ),
                  TextCurrency(
                    title: '${controller.bookingDetail.value.getFinalPrice}',
                    textStyle: titleStyle.copyWith(color: kColorPrimaryLight),
                  ),
                  // Text(
                  //   '${controller.bookingDetail.value.totalPrice! + (controller.bookingDetail.value.totalPrice! / 10)}',
                  //   style: TextStyle(fontSize: 14.sp),
                  // )
                ],
              ),
              SizedBox(
                height: defaultPaddingItem.h * 2,
              ),
              controller.bookingDetail.value.receipt == null
                  ? Container()
                  : controller.bookingDetail.value.receipt!.images!.isEmpty
                      ? Container()
                      : renderImageBill(context,
                          controller.bookingDetail.value.receipt!.images!)
            ],
          ),
        ),
      ],
    );
  }

  Widget renderMenu(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 10.h),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 0.5.h, color: Colors.grey))),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Đồ đã thêm", style: titleStyle),
            SizedBox(
              height: kDefaultPaddingWidget.h,
            ),
            Container(
              height: controller.listMenu.length * 40.h,
              padding: EdgeInsets.zero,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.listMenu.length,
                  itemBuilder: (ctx, index) {
                    return MenuOrderItem(
                      item: controller.listMenu[index],
                    );
                  }),
            ),
          ],
        ));
  }

  Widget renderSubFees(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 6.h),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 0.5.h, color: Colors.grey))),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phụ phí", style: titleStyle),
            SizedBox(
              height: kDefaultPaddingWidget.h,
            ),
            Container(
              height: controller.listSubFee.length * 30.h,
              padding: EdgeInsets.zero,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.listSubFee.length,
                  itemBuilder: (ctx, index) {
                    final item = controller.listSubFee[index];
                    return Container(
                      height: 30.h,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            item.name,
                            style: titleStyle.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 13.sp),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.zero,
                            child: Text(
                              item.price.toInt().formatCurrency(),
                              style: titleStyle.copyWith(
                                  fontSize: 13.sp, color: kColorPrimaryLight),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ));
  }

  Widget renderQrCode(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("confirmCode".tr, style: titleStyle),
          SizedBox(
            height: kDefaultPaddingItem.h,
          ),
          QrImage(
            data: "order-${controller.bookingDetail.value.orderId}",
            version: QrVersions.auto,
            // embeddedImage: CachedNetworkImageProvider(
            //     account.urlUserAvatar ?? ""),
            // embeddedImageStyle: QrEmbeddedImageStyle(
            //     size: ui.Size(36.w, 36.w)),
            size: MediaQuery.of(context).size.width * 0.5,
          ),
        ],
      ),
    );
  }

  Widget renderImageBill(BuildContext context, List<GalleryModel> listImage) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
            child: Text(
              "imageBill".tr + ":",
              style: titleStyle,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.zero,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listImage.length,
              itemBuilder: (ctx, index) {
                final GalleryModel item = listImage[index];
                return InkWell(
                  onTap: () {
                    context.router
                        .push(VendorsGalleryDetailPage(
                            index: index, listImage: listImage))
                        .then((value) {
                      Get.delete<VendorsGalleryDetailController>();
                    });
                    ;
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10.w),
                    width: MediaQuery.of(context).size.width * .3,
                    height: MediaQuery.of(context).size.width * .3,
                    child: CachedNetworkImage(
                      imageUrl: item.path ?? "",
                      fit: BoxFit.cover,
                      memCacheHeight: 200,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget dialogTimeOrder(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(kDefaultPaddingScreen.w),
      child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(
                      left: kDefaultPaddingScreen.w,
                      right: kDefaultPaddingScreen.w,
                      bottom: 16.sp,
                      top: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: () {
                              // close
                              controller.handleCloseUpdateTime();
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Ionicons.close_circle_sharp,
                              color: HexColor(secondaryColorLight),
                              size: 30,
                            )),
                      ),
                      const SizedBox(
                        height: kDefaultPaddingWidget,
                      ),
                      Text(
                        "updateTime".tr,
                        style: titleStyle,
                      ),
                      SizedBox(
                        height: kDefaultPaddingWidget.h,
                      ),
                      Obx(() => CustomeTextField(
                          title: "day2".tr,
                          hint: DateFormat("dd/MM/yyyy")
                              .format(controller.orderAt.value),
                          widget: IconButton(
                              onPressed: () {
                                getDateFromUser(context);
                              },
                              icon: const Icon(Icons.calendar_today_outlined,
                                  color: Colors.grey)))),
                      Obx(() => CustomeTextField(
                            title: "hour2".tr,
                            hint: DateFormat("hh:mm")
                                .format(controller.orderAt.value),
                            widget: IconButton(
                              icon: const Icon(
                                Icons.access_time_rounded,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                getTimeFromUser(
                                    context: context, isStarTime: true);
                              },
                            ),
                          )),
                      SizedBox(
                        height: kDefaultPaddingWidget.h * 2,
                      ),
                      InkWellButton(
                          onPressed: () {
                            controller.handleUpdateOrderTime();
                          },
                          label: "confirm".tr,
                          borderWidth: 1,
                          borderColor: HexColor(secondaryColorLight),
                          backgroundColor: Colors.transparent,
                          textColor: HexColor(secondaryColorLight))
                    ],
                  ))
            ],
          )),
    );
  }

  renderOrderInformation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "bookingDetail".tr,
                style: titleStyle,
              ),
              Visibility(
                  visible: controller.bookingDetail.value.status ==
                          BookingStatus.confirmed ||
                      controller.bookingDetail.value.status ==
                          BookingStatus.pending,
                  child: InkWell(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext dialogContext) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              insetPadding:
                                  EdgeInsets.all(kDefaultPaddingScreen.w),
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: kDefaultPaddingScreen.w,
                                              right: kDefaultPaddingScreen.w,
                                              bottom: 16.sp,
                                              top: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: InkWell(
                                                    onTap: () {
                                                      // close
                                                      controller
                                                          .handleCloseUpdateTime();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Icon(
                                                      Ionicons
                                                          .close_circle_sharp,
                                                      color: HexColor(
                                                          secondaryColorLight),
                                                      size: 30,
                                                    )),
                                              ),
                                              const SizedBox(
                                                height: kDefaultPaddingWidget,
                                              ),
                                              Text(
                                                "updateTime".tr,
                                                style: titleStyle,
                                              ),
                                              SizedBox(
                                                height: kDefaultPaddingWidget.h,
                                              ),
                                              Obx(() => CustomeTextField(
                                                  title: "day2".tr,
                                                  hint: DateFormat("dd/MM/yyyy")
                                                      .format(controller
                                                          .orderAt.value),
                                                  widget: IconButton(
                                                      onPressed: () {
                                                        getDateFromUser(
                                                            context);
                                                      },
                                                      icon: const Icon(
                                                          Icons
                                                              .calendar_today_outlined,
                                                          color:
                                                              Colors.grey)))),
                                              Obx(() => CustomeTextField(
                                                    title: "hour2".tr,
                                                    hint: DateFormat("hh:mm")
                                                        .format(controller
                                                            .orderAt.value),
                                                    widget: IconButton(
                                                      icon: const Icon(
                                                        Icons
                                                            .access_time_rounded,
                                                        color: Colors.grey,
                                                      ),
                                                      onPressed: () {
                                                        getTimeFromUser(
                                                            context: context,
                                                            isStarTime: true);
                                                      },
                                                    ),
                                                  )),
                                              SizedBox(
                                                height:
                                                    kDefaultPaddingWidget.h * 2,
                                              ),
                                              InkWellButton(
                                                  onPressed: () {
                                                    controller
                                                        .handleUpdateOrderTime();
                                                  },
                                                  label: "confirm".tr,
                                                  borderWidth: 1,
                                                  borderColor: HexColor(
                                                      secondaryColorLight),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  textColor: HexColor(
                                                      secondaryColorLight))
                                            ],
                                          ))
                                    ],
                                  )),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(defaultPaddingItem.w),
                        child: Text(
                          "fix".tr.toUpperCase(),
                          style: titleStyle.copyWith(
                              color: HexColor(secondaryColorLight),
                              fontSize: 15.sp),
                        ),
                      )))
            ],
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Ionicons.server,
                size: 26,
                color: HexColor(greyTextColor),
              ),
              SizedBox(
                width: kDefaultPaddingWidget.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "servicePack".tr + ": ",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: HexColor(greyTextColor),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Container(
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Wrap(children: [
                        Text(
                          controller.bookingDetail.value.product?.name ?? '',
                          style:
                              titleStyle.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ])),
                ],
              )
            ],
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          controller.bookingDetail.value.customer == null
              ? Container()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Ionicons.person_circle_outline,
                      size: 25.sp,
                      color: HexColor(greyTextColor),
                    ),
                    SizedBox(
                      width: kDefaultPaddingWidget.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "customer".tr,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: HexColor(greyTextColor),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          controller
                              .bookingDetail.value.customer!.profile!.fullName!,
                          style:
                              titleStyle.copyWith(fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
          controller.bookingDetail.value.totalPeople == null
              ? Container()
              : Column(
                  children: [
                    SizedBox(
                      height: kDefaultPaddingWidget.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Ionicons.people_circle_outline,
                          size: 25.sp,
                          color: HexColor(greyTextColor),
                        ),
                        SizedBox(
                          width: kDefaultPaddingWidget.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Số lượng: ",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: HexColor(greyTextColor),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Text(
                              controller.bookingDetail.value.totalPeople
                                  .toString(),
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
          if (controller.bookingDetail.value.voucherDiscount != null)
            renderDiscountInfo(context, controller.bookingDetail.value),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Ionicons.calendar_outline,
                size: 25.sp,
                color: HexColor(greyTextColor),
              ),
              SizedBox(
                width: kDefaultPaddingWidget.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "time".tr + ": ",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: HexColor(greyTextColor),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                      style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: DateFormat("hh:mm ").format(
                                controller.bookingDetail.value.orderAt!)),
                        TextSpan(text: " " + "day".tr + " "),
                        TextSpan(
                            text: DateFormat("dd-MM-yyy").format(
                                controller.bookingDetail.value.orderAt!))
                      ],
                    ),
                  ),
                  // Text(
                  //   "21/12/2021 19:00",
                  //   style: titleStyle.copyWith(
                  //       fontWeight: FontWeight.w400),
                  // )
                ],
              )
            ],
          ),
          Visibility(
            visible: controller.bookingDetail.value.note != null &&
                controller.bookingDetail.value.note != "",
            child: Column(
              children: [
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Ionicons.alert_circle_outline,
                      size: 24.sp,
                      color: HexColor(greyTextColor),
                    ),
                    SizedBox(
                      width: kDefaultPaddingWidget.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "note2".tr,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: HexColor(greyTextColor),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          controller.bookingDetail.value.note ??
                              "noMessage2".tr,
                          style:
                              titleStyle.copyWith(fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: controller.bookingDetail.value.status ==
                    BookingStatus.canceled &&
                controller.bookingDetail.value.cancelNote != null,
            child: Column(
              children: [
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Ionicons.alert_circle_outline,
                      size: 23.sp,
                      color: HexColor(greyTextColor),
                    ),
                    SizedBox(
                      width: kDefaultPaddingWidget.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "reasonCancel2".tr,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: HexColor(greyTextColor),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          controller.bookingDetail.value.cancelNote ?? "",
                          style:
                              titleStyle.copyWith(fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getDateFromUser(dynamic context) async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: controller.orderAt.value,
        firstDate: DateTime.now(),
        lastDate: DateTime(2023));

    if (_pickerDate != null) {
      controller.handleChangeOrderTime(_pickerDate, "date");
    } else {
      log("it's null or something is wrong");
    }
  }

  getTimeFromUser({dynamic context, required bool isStarTime}) async {
    TimeOfDay? _pickerTime = await showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay.fromDateTime(controller.orderAt.value));

    if (_pickerTime == null) {
      log("Time cancelled");
    } else if (isStarTime == true) {
      controller.handleChangeOrderTime(
          timeOfDayToDateTime(_pickerTime), "time");
    }
  }

  DateTime timeOfDayToDateTime(TimeOfDay timeOfDay, {DateTime? dateTime}) {
    if (dateTime != null) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day,
          timeOfDay.hour, timeOfDay.minute);
    } else {
      final now = DateTime.now();
      return DateTime(
          now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    }
  }

  Widget renderDiscountInfo(
      BuildContext context, BookingItemModel bookingItem) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Ionicons.pricetag_outline,
                size: 25.sp,
                color: HexColor(greyTextColor),
              ),
              SizedBox(
                width: kDefaultPaddingWidget.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "discountCode".tr + ": ",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: HexColor(greyTextColor),
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    bookingItem.voucherDiscount!.title ?? "",
                    style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}





// _showTimePicker(dynamic context) {
//   return showTimePicker(
//       initialEntryMode: TimePickerEntryMode.input,
//       context: context,
//       initialTime: const TimeOfDay(hour: 9, minute: 10));
// }


