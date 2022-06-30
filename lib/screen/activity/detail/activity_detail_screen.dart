import 'dart:developer';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/extensions/currency_formatting.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/activity/activity_controller.dart';
import 'package:client_tggt/screen/activity/detail/activity_detail_controller.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/profile/message/message_detail_controller.dart';
import 'package:client_tggt/screen/review/widgets/create_review.dart';
import 'package:client_tggt/screen/review/widgets/create_review_controller.dart';
import 'package:client_tggt/screen/vendors/booking/widget/menu_order_item.dart';
import 'package:client_tggt/screen/vendors_detail/vendors_detail.controller.dart';
import 'package:client_tggt/screen/vendors_gallery/widgets/vendors_gallery_detail_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/custome_cupertino_alert.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ActivityDetailScreen extends StatefulWidget {
  ActivityDetailScreen(
      {Key? key, required this.id, this.orderId, required this.isFromQr})
      : super(key: key);
  final String id;
  final String? orderId;
  final bool isFromQr;

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  ActivityDetailController controller =
      Get.put(ActivityDetailController(getIt.get<ApiClient>()));
  @override
  void initState() {
    if (widget.isFromQr == true) {
      controller.getBillByQrCode(widget.orderId ?? "");
    } else {
      controller.id.value = widget.id;
      controller.getDetailOrder(context, widget.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      title: "activityDetail".tr,
      leading: IconButton(
        onPressed: () {
          print("onback");
          Get.delete<ActivityDetailController>();
          Get.delete<CreateReviewController>();
          Get.delete<ActivityController>();
          if (widget.isFromQr == true) {
            Get.delete<HomeController>();
            context.router.replace(MainPage());
          } else {
            context.router.pop();
          }
        },
        icon: Icon(Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color),
      ),
      trailing: [
        buildAppBarDropDownMenu(context),
      ],
      child: Obx(() => Column(
            children: [
              Expanded(child: buildBody(context)),
              Container(),
              Visibility(
                  visible: controller.isData.value == 100,
                  child: Text(controller.isData.toString()))
            ],
          )),
    );
  }

  Obx buildBody(BuildContext context) {
    return Obx(() => controller.isLoading.value == true
        ? const LoadingScreen()
        : controller.isErrorScanByQr.isTrue
            ? renderErrorScanWithQr(context)
            : activityDetailBody(context));
  }

  Widget activityDetailBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RepaintBoundary(
                      key: controller.ticketQRKey,
                      child: buildContent(context, controller)),
                  SizedBox(height: kDefaultPaddingWidget.h),
                ],
              ),
            ),
          ),
          controller.docData.value.status == BookingStatus.billPending
              ? renderCustomerConfirmButton(context)
              : buildBottomButton(context, controller),
        ],
      ),
    );
  }

  Widget renderErrorScanWithQr(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Text(
            'qrOutDate'.tr,
            style: titleStyle,
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          InkWellButton(
            label: "confirm".tr,
            onPressed: () async {
              await Get.delete<HomeController>();
              context.router.replace(MainPage());
            },
          ),
        ],
      ),
    );
  }

  PopupMenuButton buildAppBarDropDownMenu(BuildContext context) {
    return PopupMenuButton<int>(
      color: Theme.of(context).backgroundColor,
      icon: Icon(Icons.more_vert, color: Theme.of(context).iconTheme.color),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Text(
            "report".tr,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0.r))),
      onSelected: (item) => {
        //TODO: Report
      },
    );
  }

  Widget renderCustomerConfirmButton(BuildContext context) {
    return InkwellButtonLoading(
      isLoading: controller.isLoadingConfirm.isTrue,
      textColor: Theme.of(context).backgroundColor,
      label: "billConfirm".tr,
      onPressed: () async {
        final status = await controller
            .handleConfirmBillQr(controller.docData.value.orderId ?? "");
        if (status == true) {
        } else {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text("notification".tr),
                    content: Text('errorTryAgain'.tr),
                    actions: [
                      CupertinoDialogAction(
                          child: Text('confirm'.tr),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ));
        }
      },
    );
  }

  Widget buildBottomButton(
      BuildContext context, ActivityDetailController controller) {
    inspect(controller.docData.value);
    if (controller.docData.value.status == BookingStatus.reviewed) {
      return InkWellButton(
        textColor: Theme.of(context).backgroundColor,
        label: "seeReview".tr,
        onPressed: () {
          controller.showReviewModal(context);
        },
      );
    } else if (controller.docData.value.status == BookingStatus.completed) {
      return InkWellButton(
        textColor: Theme.of(context).backgroundColor,
        label: 'review'.tr,
        onPressed: () {
          controller.showReviewModal(context);
        },
      );
    } else if (controller.docData.value.status != BookingStatus.completed) {
      return Column(
        children: [
          Visibility(
              visible:
                  controller.docData.value.status == BookingStatus.confirmed,
              child: InkWellButton.outline(
                onPressed: () {
                  context.router.push(
                      OrderQrPage(orderId: controller.docData.value.id ?? ""));
                },
                label: "Mã xác nhận",
              )),
          Visibility(
              visible:
                  controller.docData.value.status == BookingStatus.confirmed,
              child: SizedBox(
                height: 10.h,
              )),
          Visibility(
              visible:
                  controller.docData.value.status == BookingStatus.confirmed ||
                      controller.docData.value.status == BookingStatus.pending,
              child: InkWellButton.outline(
                onPressed: () {
                  context.router.push(MapsDerectionPage(
                      vendorInfo: controller.docData.value.vendor!));
                },
                label: "Chỉ đường đến",
              )),
          Visibility(
              visible:
                  controller.docData.value.status == BookingStatus.confirmed ||
                      controller.docData.value.status == BookingStatus.pending,
              child: SizedBox(
                height: 10.h,
              )),
          InkWellButton(
            textColor: Theme.of(context).backgroundColor,
            label: 'Chat'.tr,
            onPressed: () {
              // log(controller.docData.value.chatRoomId ?? '');
              context.router
                  .push(MessageDetailPage(
                      roomId: controller.docData.value.chatRoomId ?? '',
                      vendorId: controller.docData.value.vendor == null
                          ? ""
                          : controller.docData.value.vendor!.id ?? "",
                      vendorInfo: controller.docData.value.vendor,
                      onBack: (List<StaffModel> listStaff) {
                        if (listStaff.isNotEmpty) {
                          controller.listStaff.value = listStaff;
                          controller.totalStaffPrice.value =
                              listStaff.length * 500000;
                        }
                      }))
                  .then((value) async {
                final MessageDetailController messageDetailController =
                    Get.put(MessageDetailController(getIt.get<ApiClient>()));
                await messageDetailController.disposeSocket();
                Get.delete<MessageDetailController>();
              });
            },
          ),
          Visibility(
              visible: controller.docData.value.status == BookingStatus.pending,
              child: SizedBox(
                height: kDefaultPaddingItem.h,
              )),
          Visibility(
              visible: controller.docData.value.status == BookingStatus.pending,
              child: InkWellButton.outline(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return CustomCupertinoAlert(
                        context: context,
                        title: "cancelOrder".tr,
                        content: "confirmCancelOrder".tr,
                        rightButtonTitle: 'confirm'.tr,
                        rightAction: () async {
                          Navigator.pop(context);
                          final bool status = await controller.requestCancel();

                          if (status == true) {
                            getIt.get<IToast>().show(
                                title: "notification".tr,
                                message: 'Huỷ lịch hẹn thành công',
                                hasDismissButton: false,
                                duration: const Duration(milliseconds: 1000));
                          } else {
                            getIt.get<IToast>().show(
                                title: "notification".tr,
                                message:
                                    'Đã có lỗi xảy ra. Vui lòng thử lại sau',
                                hasDismissButton: false,
                                duration: const Duration(milliseconds: 1000));
                          }
                        },
                      );
                    },
                  );
                },
                label: "cancel".tr,
              ))
        ],
      );
    } else {
      return Container();
    }
  }

  Column buildContent(
      BuildContext context, ActivityDetailController controller) {
    return Column(
      children: [
        SizedBox(
          child: Column(
            children: [
              buildTopContent(context, controller),
              // SizedBox(height: 20.h),
              // buildTopContent2(context, controller)
              //TODO

              Visibility(
                  visible: controller.listMenu.isNotEmpty,
                  child: renderMenu(context)),
              Visibility(
                  visible: controller.listSubFee.isNotEmpty,
                  child: SizedBox(
                    height: 10.h,
                  )),
              Visibility(
                  visible: controller.listSubFee.isNotEmpty,
                  child: renderSubFees(context)),
            ],
          ),
        ),
        renderSupportInfo(context),
        if (controller.docData.value.status == BookingStatus.completed ||
            controller.docData.value.status != BookingStatus.reviewed)
          Column(
            children: [
              SizedBox(height: kDefaultPadding.h),
            ],
          )
        else
          SizedBox(height: 30.h),
        Container(
            child: controller.docData.value.status == BookingStatus.pending
                ? buildPendingLoading(context)
                : controller.docData.value.status == BookingStatus.canceled
                    ? const SizedBox()
                    : (controller.docData.value.status ==
                                BookingStatus.completed ||
                            controller.docData.value.status ==
                                BookingStatus.reviewed)
                        ? Container()
                        : Container()
            // : buildBottomContent(context),
            )
      ],
    );
  }

  Container renderSupportInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 0.8.w, color: Colors.grey)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    child: Icon(Ionicons.help_circle_outline,
                        size: 21.sp,
                        color: ThemeServices().isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[600])),
                SizedBox(
                  width: kDefaultPaddingItem.w,
                ),
                Text('frequentlyQuestion'.tr,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: ThemeServices().isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[600]))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 0.8.w, color: Colors.grey)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(bottom: 5.h),
                    child: Icon(Ionicons.call_outline,
                        size: 21.sp,
                        color: ThemeServices().isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[600])),
                SizedBox(
                  width: kDefaultPaddingItem.w,
                ),
                RichText(
                  text: TextSpan(
                    text: 'switchboard'.tr,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: ThemeServices().isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[600]),
                    children: <TextSpan>[
                      TextSpan(
                          text: '19001188',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor)),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Visibility(
          //   visible:
          //       (controller.docData.value.status == BookingStatus.pending ||
          //           controller.docData.value.status == BookingStatus.confirmed),
          //   child: InkWell(
          //     onTap: () {
          //       context.router.push(MapsDerectionPage(
          //           vendorInfo: controller.docData.value.vendor!));
          //     },
          //     child: Container(
          //       padding: EdgeInsets.symmetric(vertical: 6.h),
          //       decoration: BoxDecoration(
          //         border:
          //             Border(top: BorderSide(width: 0.8.w, color: Colors.grey)),
          //       ),
          //       child: Row(
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Container(
          //               margin: EdgeInsets.only(bottom: 5.h),
          //               child: Icon(Ionicons.navigate_circle_outline,
          //                   size: 21.sp,
          //                   color: ThemeServices().isDarkMode
          //                       ? Colors.grey[400]
          //                       : Colors.grey[600])),
          //           SizedBox(
          //             width: kDefaultPaddingItem.w,
          //           ),
          //           RichText(
          //             text: TextSpan(
          //               text: 'Chỉ đường tới: ',
          //               style: TextStyle(
          //                   fontSize: 12.sp,
          //                   color: ThemeServices().isDarkMode
          //                       ? Colors.grey[400]
          //                       : Colors.grey[600]),
          //               children: <TextSpan>[
          //                 TextSpan(
          //                     text: controller.docData.value.vendor!.brandName,
          //                     style: TextStyle(
          //                         fontWeight: FontWeight.w500,
          //                         color: Theme.of(context).primaryColor)),
          //               ],
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  SizedBox buildReceiptList() {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          primary: false,
          itemCount: controller.docData.value.receipt?.images!.length,
          itemBuilder: (context, index) {
            final item = controller.docData.value.receipt?.images![index];
            return GestureDetector(
              onTap: () {
                context.router
                    .push(VendorsGalleryDetailPage(
                        index: index,
                        listImage: controller.docData.value.receipt!.images!))
                    .then((value) {
                  Get.delete<VendorsGalleryDetailController>();
                });
              },
              child: Hero(
                tag: 'popup-Image$index',
                child: Padding(
                  padding: EdgeInsets.only(right: kDefaultPaddingItem.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: item?.path ?? '',
                        memCacheHeight: 200,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  SizedBox buildPendingLoading(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(AppPath.appLoading,
              frameRate: FrameRate.max, height: 68.h),
          Text('waitForConfirmation'.tr),
        ],
      ),
    );
  }

  QrImage buildBottomContent(BuildContext context) {
    return QrImage(
      size: Get.width / 2,
      data: controller.docData.value.id ?? "",
      version: QrVersions.auto,
      backgroundColor: ThemeServices().isDarkMode
          ? Theme.of(context).primaryColor
          : Theme.of(context).backgroundColor,
    );
  }

  IntrinsicHeight buildTopContent(
      BuildContext context, ActivityDetailController controller) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          Positioned(right: 0, child: buildStatusBadge(context)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: buildLeftContent(context),
              ),
              Expanded(
                flex: 2,
                child: buildRightContent(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderMenu(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10.h),
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0.5.h, color: Colors.grey))),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Đồ đã gọi", style: titleStyle.copyWith(fontSize: 13.sp)),
            SizedBox(
              height: 10.h,
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
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  child: Text(
                    "total".tr,
                    style: titleStyle.copyWith(
                        color: kColorPrimaryLight, fontSize: 13.sp),
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  // child: Text(
                  //   controller.docData.value.totalMenuPrice.toString(),
                  //   style: subTitleStyle,
                  // ),
                  child: Text(
                    '${controller.docData.value.totalMenuPrice?.toInt().formatCurrency()}',
                    style: titleStyle.copyWith(
                        fontSize: 14.sp, color: kColorPrimaryLight),
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget renderSubFees(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top: 8.h),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0.5.h, color: Colors.grey))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Phụ phí", style: titleStyle),
            SizedBox(
              height: kDefaultPaddingItem.h,
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
                              style: titleStyle.copyWith(fontSize: 13.sp),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  child: Text(
                    "total".tr,
                    style: titleStyle.copyWith(
                        color: kColorPrimaryLight, fontSize: 13.sp),
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  // child: Text(
                  //   controller.docData.value.totalMenuPrice.toString(),
                  //   style: subTitleStyle,
                  // ),
                  child: Text(
                    '${controller.docData.value.totalSubFeePrice?.toInt().formatCurrency()}',
                    style: titleStyle.copyWith(
                        fontSize: 14.sp, color: kColorPrimaryLight),
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget buildTopContent2(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("finalPrice".tr, style: AppTextStyle().heading2Bold20),
                SizedBox(height: 3.h),
                Text(
                    "${TGGTUtils().formatMoney((controller.docData.value.receipt?.finalPrice ?? 0).toDouble())} đ",
                    style: AppTextStyle()
                        .specialBold32
                        .copyWith(color: Theme.of(context).primaryColor)),
              ],
            ),
          ],
        ),
        SizedBox(height: kDefaultPadding.h * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("roomType".tr),
            Text(controller.docData.value.product?.name ?? "",
                style: AppTextStyle().subtitleRegular14),
          ],
        ),
        SizedBox(height: kDefaultPaddingItem.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("numberPeople".tr),
            Text("${controller.docData.value.totalPeople ?? 0} ${'people'.tr}",
                style: AppTextStyle().subtitleRegular14),
          ],
        ),
        SizedBox(height: kDefaultPaddingItem.h),
        if (controller.docData.value.productOptions!.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("service".tr),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ...controller.docData.value.productOptions!.map(
                    (e) => Padding(
                      padding: EdgeInsets.only(bottom: kDefaultPaddingItem.h),
                      child: Text("${e.amount} ${e.option?.name}",
                          style: AppTextStyle().subtitleRegular14),
                    ),
                  )
                ],
              )
            ],
          ),
        if (controller.docData.value.note!.isNotEmpty)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("note".tr),
                  Text(controller.docData.value.note ?? "",
                      style: AppTextStyle()
                          .titleBold16
                          .copyWith(color: Theme.of(context).primaryColor)),
                ],
              ),
              SizedBox(height: kDefaultPaddingItem.h),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("totalPrice".tr),
            Text(
                "${TGGTUtils().formatMoney((controller.docData.value.receipt?.totalPrice ?? 0).toDouble())} đ",
                style: AppTextStyle()
                    .titleBold16
                    .copyWith(color: Theme.of(context).primaryColor)),
          ],
        ),
        SizedBox(height: kDefaultPaddingItem.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("discount".tr),
            Text("${controller.docData.value.receipt?.discountPercent} %",
                style: AppTextStyle()
                    .titleBold16
                    .copyWith(color: Theme.of(context).primaryColor)),
          ],
        ),
        SizedBox(height: kDefaultPaddingItem.h),
        const Divider(thickness: 2),
        SizedBox(height: kDefaultPaddingItem.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Booking ID", style: AppTextStyle().paragraphRegular12Grey),
            Text(controller.docData.value.orderId ?? '',
                style: AppTextStyle().paragraphRegular12Grey),
          ],
        ),
        SizedBox(height: kDefaultPaddingItem.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("brandName".tr, style: AppTextStyle().paragraphRegular12Grey),
            Text(controller.docData.value.vendor?.brandName ?? "",
                style: AppTextStyle().paragraphRegular12Grey),
          ],
        ),
        SizedBox(height: kDefaultPaddingItem.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text("address".tr,
                    style: AppTextStyle().paragraphRegular12Grey)),
            Flexible(
              child: Text(
                  controller.docData.value.vendor?.address.fullAddress ?? "",
                  // textDirection: TextDirection.RTL,
                  style: AppTextStyle()
                      .paragraphRegular12Grey
                      .copyWith(height: 1.2)),
            ),
          ],
        ),
      ],
    );
  }

  Obx buildRightContent(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Flexible(child: buildStatusBadge(context)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              controller.docData.value.receipt == null
                  ? controller.docData.value.vendor!.category ==
                          CategoryType.massage
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("provisionalFee".tr,
                                style: AppTextStyle().eyebrowRegular10Grey),
                            SizedBox(height: 3.h),
                            // Text(
                            //     "${TGGTUtils().formatMoney((controller.docData.value.totalPrice ?? 0).toDouble())} đ",
                            //     style: AppTextStyle().titleBold16.copyWith(
                            //         color: Theme.of(context).primaryColor))
                            controller.docData.value.getPrePriceWithDiscount ==
                                    0
                                ? Text(
                                    "${TGGTUtils().formatMoney((controller.docData.value.totalPrice! + controller.totalStaffPrice.value))} đ",
                                    style: AppTextStyle().titleBold16.copyWith(
                                        color: Theme.of(context).primaryColor))
                                : RichText(
                                    text: TextSpan(
                                      text:
                                          "${TGGTUtils().formatMoney(controller.docData.value.totalPrice! + controller.totalStaffPrice.value)} đ",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: ThemeServices().isDarkMode
                                              ? kColorGreyDark
                                              : kColorGreyLight),
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: ' ',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.none)),
                                        TextSpan(
                                            text:
                                                "${TGGTUtils().formatMoney(controller.docData.value.getPrePriceWithDiscount + controller.totalStaffPrice.value)} đ",
                                            style: TextStyle(
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15.sp,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ],
                                    ),
                                  )
                          ],
                        )
                      : Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 26.h),
                        Text("${"totalPrice".tr}:",
                            style: AppTextStyle().eyebrowRegular10Grey),
                        SizedBox(height: 3.h),
                        Text(
                            "${TGGTUtils().formatMoney((controller.docData.value.receipt?.totalPrice ?? 0).toDouble())} đ",
                            style: AppTextStyle().titleBold16.copyWith(
                                color: Theme.of(context).primaryColor)),
                        SizedBox(height: kDefaultPaddingItem.h),
                        Text("${"discount".tr}:",
                            style: AppTextStyle().eyebrowRegular10Grey),
                        SizedBox(height: 3.h),
                        Text(
                            "${controller.docData.value.receipt?.discountPercent} %",
                            style: AppTextStyle().titleBold16.copyWith(
                                color: Theme.of(context).primaryColor)),
                        controller.docData.value.getPrePriceWithDiscount != 0
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: kDefaultPaddingItem.h),
                                  Text("discountCode".tr + ": ",
                                      style:
                                          AppTextStyle().eyebrowRegular10Grey),
                                  SizedBox(height: 3.h),
                                  Text(
                                      controller
                                          .docData.value.getDiscountAmount,
                                      style: AppTextStyle()
                                          .titleBold16
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                ],
                              )
                            : Container(),
                        SizedBox(height: kDefaultPaddingItem.h),
                        Text("${"finalPrice".tr}:",
                            style: AppTextStyle().eyebrowRegular10Grey),
                        SizedBox(height: 3.h),
                        Text(
                            "${TGGTUtils().formatMoney((controller.docData.value.receipt?.finalPrice ?? 0).toDouble())} đ",
                            style: AppTextStyle().titleBold16.copyWith(
                                color: Theme.of(context).primaryColor)),
                      ],
                    ),
              SizedBox(height: kDefaultPaddingWidget.h),
              Text(controller.docData.value.getOrderTime,
                  // TGGTUtils().formatDateFromString(
                  //     DateFormat("yyyy-MM-dd HH:mm:ss").format(
                  //         controller.docData.value.orderAt ?? DateTime.now())),
                  style: AppTextStyle().subtitleBold14,
                  textAlign: TextAlign.right),
            ],
          )
        ],
      ),
    );
  }

  SizedBox buildStatusBadge(BuildContext context) {
    return SizedBox(
      height: 19.h,
      child: Badge(
        elevation: 0,
        toAnimate: false,
        shape: BadgeShape.square,
        badgeColor: ThemeServices().isDarkMode
            ? controller.docData.value.status.color()
            : controller.docData.value.status.color().withOpacity(0.1),
        borderRadius: BorderRadius.circular(defaultBorderRadiusItem),
        badgeContent: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: controller.docData.value.status == BookingStatus.pending
                  ? SpinKitRing(
                      size: 10,
                      lineWidth: 1,
                      color: ThemeServices().isDarkMode
                          ? Theme.of(context).backgroundColor
                          : controller.docData.value.status.color(),
                    )
                  : Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: ThemeServices().isDarkMode
                            ? Theme.of(context).backgroundColor
                            : controller.docData.value.status.color(),
                        shape: BoxShape.circle,
                      ),
                    ),
            ),
            SizedBox(
              width: 4.w,
            ),
            controller.docData.value.status == BookingStatus.pending
                ? Flexible(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'processing1'.tr,
                          textStyle: AppTextStyle().eyebrowRegular10.copyWith(
                              color: ThemeServices().isDarkMode
                                  ? Theme.of(context).backgroundColor
                                  : controller.docData.value.status.color(),
                              height: 1.2),
                        ),
                        TyperAnimatedText(
                          'processing2'.tr,
                          textStyle: AppTextStyle().eyebrowRegular10.copyWith(
                              color: ThemeServices().isDarkMode
                                  ? Theme.of(context).backgroundColor
                                  : controller.docData.value.status.color(),
                              height: 1.2),
                        ),
                      ],
                      repeatForever: true,
                    ),
                  )
                : Text(
                    controller.docData.value.status.display(),
                    style: AppTextStyle().eyebrowRegular10.copyWith(
                        color: ThemeServices().isDarkMode
                            ? Theme.of(context).backgroundColor
                            : controller.docData.value.status.color(),
                        height: 1.2),
                  ),
          ],
        ),
      ),
    );
  }

  showReviewModal(BuildContext context, ActivityDetailController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateReview(
            orderID: controller.id.value,
            review: controller.docData.value.review,
            callback: (bool isReview) {
              if (isReview) {
                controller.getDetailOrder(context, controller.id.value);
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text('success'.tr),
                    content: Text('sendReviewSuccess'.tr),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                          // context.router.pop(false);
                        },
                      ),
                    ],
                  ),
                );
              }
              Navigator.pop(context);
              // context.router.pop(false);
            },
          ),
        );
      },
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
    );
  }

  Obx buildLeftContent(BuildContext context) {
    inspect(controller.docData.value.vendor);
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Clipboard.setData(
                  ClipboardData(text: controller.docData.value.orderId ?? ''));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  // elevation: 1,
                  backgroundColor: Colors.transparent,
                  content: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      child: Text(
                        'copySuccessDes'.tr,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              );

              // Get.snackbar('copySuccessTitle'.tr, 'copySuccessDes'.tr);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Text(
                'Booking: #${controller.docData.value.orderId ?? ''}',
                style: AppTextStyle().eyebrowRegular10Grey,
              ),
            ),
          ),
          SizedBox(height: kDefaultPaddingItem.h),
          Hero(
            tag: "activity-detail-${controller.docData.value.vendor!.id}",
            child: GestureDetector(
              onTap: () {
                context.router
                    .push(VendorsDetailPage(
                        first: controller.docData.value.vendor!.id ?? "",
                        last:
                            controller.docData.value.vendor?.category.getType(),
                        tagId:
                            "activity-detail-${controller.docData.value.vendor!.id}",
                        imageUrl:
                            controller.docData.value.vendor?.thumbnail?.path ??
                                "",
                        vendorTitle: controller.docData.value.vendor?.brandName,
                        vendorsInfo: controller.docData.value.vendor!,
                        voucher: null))
                    .then((value) => {Get.delete<VendorsDetailController>()});
              },
              child: Text(controller.docData.value.vendor?.brandName ?? "",
                  style: AppTextStyle().titleBold16),
            ),
          ),
          SizedBox(height: kDefaultPaddingWidget.h),
          Text(controller.docData.value.vendor?.address.fullAddress ?? "",
              style:
                  AppTextStyle().paragraphRegular12Grey.copyWith(height: 1.2)),
          SizedBox(height: kDefaultPaddingWidget.h),
          Text(controller.docData.value.product?.name ?? ""),
          SizedBox(height: kDefaultPaddingWidget.h),
          Text(
              "${controller.docData.value.totalPeople ?? 0} ${categoryTypeToSymbol(controller.docData.value.vendor!.category)}",
              style: AppTextStyle().paragraphRegular12),
          controller.listStaff.isNotEmpty
              ? Container(
                  margin: EdgeInsets.only(top: kDefaultPaddingItem.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("technicians".tr),
                      SizedBox(
                        width: kDefaultPaddingItem.w,
                      ),
                      Text("${controller.listStaff.length}",
                          style: AppTextStyle().subtitleRegular14),
                    ],
                  ),
                )
              : Container(),
          controller.docData.value.getPrePriceWithDiscount != 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: kDefaultPaddingWidget.h),
                    Text(
                      'discountCode'.tr +
                          (controller
                                  .docData.value.voucherDiscount!.voucherCode ??
                              ''),
                      style: AppTextStyle().paragraphRegular12,
                    ),
                  ],
                )
              : Container(),
          SizedBox(height: kDefaultPaddingWidget.h),
          if ((controller.docData.value.note ?? '').isNotEmpty)
            Text('note'.tr + ': ${controller.docData.value.note ?? ''}'),
        ],
      ),
    );
  }
}

class SmallFillRoundButton extends StatelessWidget {
  const SmallFillRoundButton({
    Key? key,
    required this.label,
    required this.callback,
  }) : super(key: key);

  final String label;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWellButton(
        onPressed: callback,
        maxHeight: 35.h,
        label: label,
        backgroundColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular((35 / 2).r),
        textColor: Theme.of(context).backgroundColor,
        style: AppTextStyle().subtitleRegular14,
      ),
    );
  }
}
