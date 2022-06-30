import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/activity/detail/activity_detail_controller.dart';
import 'package:client_tggt/screen/profile/message/message_detail/body.dart';
import 'package:client_tggt/screen/profile/message/message_detail_controller.dart';
import 'package:client_tggt/screen/profile/message/staff/customer_staff_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/widget/textfield/custome_textfile_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageDetailScreen extends StatefulWidget {
  MessageDetailScreen(
      {Key? key,
      required this.roomId,
      this.onBack,
      required this.vendorId,
      this.vendorInfo})
      : super(key: key);
  final String roomId;
  final Function(List<StaffModel> listStaff)? onBack;
  final String vendorId;
  final VendorModel? vendorInfo;
  @override
  State<MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  final MessageDetailController controller =
      Get.put(MessageDetailController(getIt.get<ApiClient>()));

  @override
  void initState() {
    super.initState();
    if (widget.roomId != "") {
      controller.updateRoomId(widget.roomId);
      controller.getListMessage(widget.roomId);
    } else {
      controller.isOrder.value = false;
      controller.handleGetChatRoomByVendorId(widget.vendorId);
      controller.checkStaff(widget.vendorId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BaseScreen(
          backgroundColor: Theme.of(context).backgroundColor,
          child: Obx(
            () => controller.isLoading.isTrue
                ? const LoadingScreen()
                : InkWell(
                    onTap: () {
                      if (controller.isShowOptions.isTrue) {
                        controller.isShowOptions.value = false;
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          renderHeaderChat(context, controller),
                          controller.isOrder.isTrue
                              ? renderOrderInfo(context, controller)
                              : Container(),
                          Expanded(
                            child: Body(
                                // ignore: invalid_use_of_protected_member
                                listMessage: controller.listMessages.value,
                                messageController:
                                    controller.messageDetailController),
                          ),
                          SingleChildScrollView(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  (widget.roomId != "" &&
                                          controller.orderStatus.value !=
                                              BookingStatus.canceled)
                                      ? Visibility(
                                          visible:
                                              controller.isHaveStaff.isTrue,
                                          child: GestureDetector(
                                            onTap: () {
                                              context.router
                                                  .push(CustomerStaffPage(
                                                      vendorId: controller
                                                                  .vendorInfo
                                                                  .value
                                                                  .id ==
                                                              null
                                                          ? widget.vendorId
                                                          : controller
                                                                  .vendorInfo
                                                                  .value
                                                                  .id ??
                                                              "",
                                                      orderId: controller
                                                          .orderId.value,
                                                      onBack: (List<StaffModel>
                                                          listStaff) {
                                                        controller.listStaff
                                                            .value = listStaff;
                                                        controller
                                                                .totalStaffPrice
                                                                .value =
                                                            listStaff.length *
                                                                500000;
                                                      }))
                                                  .then((value) => {
                                                        Get.delete<
                                                            CustomerStaffController>()
                                                      });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      kDefaultPaddingItem.w),
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        kDefaultPaddingItem.w,
                                                    vertical: 6.h),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Text("technician".tr,
                                                    style:
                                                        subTitleStyle.copyWith(
                                                            color: Colors.white,
                                                            fontSize: 12.sp)),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        // Visibility(
                                        //   visible:
                                        //       controller.orderStatus.value !=
                                        //           BookingStatus.canceled,
                                        //   child: GestureDetector(
                                        //     onTap: () {
                                        //       FocusScopeNode currentFocus =
                                        //           FocusScope.of(context);
                                        //       if (!currentFocus
                                        //           .hasPrimaryFocus) {
                                        //         currentFocus.unfocus();
                                        //       }

                                        //       controller.isShowOptions.value =
                                        //           true;
                                        //     },
                                        //     child: Icon(
                                        //       Ionicons.add_circle_outline,
                                        //       size: 28.sp,
                                        //       color: Theme.of(context)
                                        //           .colorScheme
                                        //           .secondaryVariant,
                                        //     ),
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: CustomeTextFieldComment(
                                            hint: "typeYourMessage".tr,
                                            // autoFocus: true,
                                            isLoading:
                                                controller.isSendMessage.value,
                                            focusNode: controller.focusNode,
                                            controller:
                                                controller.contentMessage.value,
                                            onTap: () {
                                              if (controller.roomId.value ==
                                                  "") {
                                                controller
                                                    .handleSendFirstMessage(
                                                        widget.vendorId);
                                              } else {
                                                controller.handleSendMessage();
                                              }
                                              // _handleSendPressed;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Visibility(
                                  //     visible: controller.isShowOptions.isTrue,
                                  //     child: InkWell(
                                  //       onTap: () {},
                                  //       child: Container(
                                  //         width:
                                  //             MediaQuery.of(context).size.width,
                                  //         padding: EdgeInsets.symmetric(
                                  //             horizontal: kDefaultPaddingItem.w,
                                  //             vertical: kDefaultPaddingItem.h),
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.grey[50]),
                                  //         height: MediaQuery.of(context)
                                  //                 .size
                                  //                 .height *
                                  //             .3,
                                  //         child: Column(
                                  //           children: [
                                  //             Row(
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.start,
                                  //               children: [
                                  //                 Visibility(
                                  //                   visible: controller
                                  //                       .listStaff.isEmpty,
                                  //                   child: GestureDetector(
                                  //                     onTap: () {
                                  //                       context.router
                                  //                           .push(
                                  //                               CustomerStaffPage(
                                  //                                   vendorId: controller
                                  //                                           .vendorInfo
                                  //                                           .value
                                  //                                           .id ??
                                  //                                       "",
                                  //                                   orderId: controller
                                  //                                       .orderId
                                  //                                       .value,
                                  //                                   onBack: (List<
                                  //                                           StaffModel>
                                  //                                       listStaff) {
                                  //                                     controller
                                  //                                         .listStaff
                                  //                                         .value = listStaff;
                                  //                                     controller
                                  //                                         .totalStaffPrice
                                  //                                         .value = listStaff
                                  //                                             .length *
                                  //                                         500000;
                                  //                                   }))
                                  //                           .then((value) => {
                                  //                                 Get.delete<
                                  //                                     CustomerStaffController>()
                                  //                               });
                                  //                     },
                                  //                     child: Container(
                                  //                       padding: EdgeInsets.symmetric(
                                  //                           horizontal:
                                  //                               kDefaultPaddingItem
                                  //                                   .w,
                                  //                           vertical:
                                  //                               kDefaultPaddingWidget
                                  //                                   .h),
                                  //                       decoration: BoxDecoration(
                                  //                           color: Theme.of(
                                  //                                   context)
                                  //                               .backgroundColor,
                                  //                           borderRadius:
                                  //                               BorderRadius
                                  //                                   .circular(
                                  //                                       8.r)),
                                  //                       child: Column(
                                  //                         crossAxisAlignment:
                                  //                             CrossAxisAlignment
                                  //                                 .center,
                                  //                         children: [
                                  //                           Icon(
                                  //                               Ionicons
                                  //                                   .body_outline,
                                  //                               size: 25.sp),
                                  //                           SizedBox(
                                  //                             height:
                                  //                                 kDefaultPaddingItem
                                  //                                     .h,
                                  //                           ),
                                  //                           Text(
                                  //                               "Kỹ thuật viên",
                                  //                               style: TextStyle(
                                  //                                   fontSize:
                                  //                                       13.sp))
                                  //                         ],
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 )
                                  //               ],
                                  //             )
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ))
                                  // AnimatedContainer(
                                  //     duration: const Duration(milliseconds: 200),
                                  //     //padding: const EdgeInsets.symmetric(horizontal: 8),
                                  //     color: Theme.of(context).backgroundColor,
                                  //     alignment: Alignment.center,
                                  //     height: controller.isShowOptions.value
                                  //         ? MediaQuery.of(context).size.height *
                                  //             .3
                                  //         : 0,
                                  //     child: Container(
                                  //       height:
                                  //           MediaQuery.of(context).size.height *
                                  //               .3,
                                  //       child: Text("123"),
                                  //     ))
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }

  Widget renderHeaderChat(
      BuildContext context, MessageDetailController controller) {
    // controller.room
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.2.w, color: Colors.grey))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 3.h),
            child: IconButton(
              onPressed: () async {
                if (controller.isConnectSocket.isTrue) {
                  await controller.disposeSocket();
                }
                widget.onBack?.call(controller.listStaff);
                context.router.pop();
              },
              icon: Icon(
                Ionicons.chevron_back_outline,
                size: 25.sp,
                color: ThemeServices().isDarkMode
                    ? kColorGreyDark
                    : kColorGreyLight,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 3.h),
            child: Text(
              widget.vendorId == ""
                  ? controller.chatWithUser.value.profile!.fullName ?? ""
                  : widget.vendorInfo!.brandName,
              maxLines: 1,
              style: titleStyle,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget renderOrderInfo(
      BuildContext context, MessageDetailController controller) {
    final currencyFormatter = NumberFormat('#,##0  đ', 'ID');

    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingScreen.w, vertical: 6.h),
        // decoration: BoxDecoration(
        // border: Border(bottom: BorderSide(width: 0.w, color: Colors.grey))
        // ),
        child: GestureDetector(
          onTap: () {
            final accountType = AccountServices().getAccountType();
            if (accountType == AccountType.vendor.display()) {
              context.router.push(BookingDetailPage(
                  bookingId: controller.orderCode.value,
                  parentPage: "booking_list"));
            } else if (accountType == AccountType.customer.display()) {
              context.router
                  .push(ActivityDetailPage(
                      id: controller.orderCode.value, isFromQr: false))
                  .then((value) => {Get.delete<ActivityDetailController>()});
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            controller.productThumbnail.value),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: kDefaultPaddingWidget.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'scheduleCode'.tr,
                      style:
                          subTitleStyle.copyWith(fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(text: controller.orderCode.value),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'temporaryPrice'.tr,
                      style:
                          subTitleStyle.copyWith(fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: currencyFormatter.format(
                                controller.orderPrice.value +
                                    controller.totalStaffPrice.value)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(controller.orderStatus.value.display(),
                      style: titleStyle.copyWith(
                          color: ThemeServices().isDarkMode
                              ? kColorPrimaryDark
                              : kColorPrimaryLight,
                          fontWeight: FontWeight.w400))
                ],
              )
            ],
          ),
        ));
  }
}



// Widget renderStaffInfo(
//     BuildContext context, MessageDetailController controller) {
//   return Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: kDefaultPaddingScreen.w, vertical: 6.h),
//       // decoration: BoxDecoration(
//       // border: Border(bottom: BorderSide(width: 0.w, color: Colors.grey))
//       // ),
//       child:);
// }
