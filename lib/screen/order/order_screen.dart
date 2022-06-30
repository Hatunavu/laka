import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/order/order_controller.dart';
import 'package:client_tggt/screen/order/widget/service_item.dart';
import 'package:client_tggt/screen/order/widget/time_block_slider.dart';
import 'package:client_tggt/screen/rewards/voucher/voucher_controller.dart';
import 'package:client_tggt/screen/vendors_detail/vendors_detail.controller.dart';
import 'package:client_tggt/screen/vendors_list/vendors_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:table_calendar/table_calendar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen(
      {Key? key,
      required this.id,
      required this.textfieldController,
      required this.voucher,
      required this.type,
      required this.vendorInfo})
      : super(key: key);

  final String id;
  final TextEditingController textfieldController;
  final String type;
  final VoucherModel voucher;
  final VendorModel vendorInfo;
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

// class _OrderScreenState extends State<OrderScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
class _OrderScreenState extends State<OrderScreen> {
  // const OrderScreen(
  //     {Key? key, required this.id, required this.textfieldController})
  //     : super(key: key);
  // final String id;
  // final TextEditingController textfieldController;

  OrderController controller = Get.put(OrderController(getIt.get<ApiClient>()));
  @override
  void initState() {
    super.initState();
    controller.selectedVoucher.value = widget.voucher;
    controller.serviceID.value = widget.id;
    controller.getDetailOption(widget.id);
    controller.initTimes();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildGreyBarHeader(),
          buildContent(context, controller),
        ],
      ),
    );
  }

  Expanded buildContent(BuildContext context, OrderController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: [
            configPage(controller, context),
            orderPage(controller, context),
            confirmPage(controller, context),
          ],
        ),
      ),
    );
  }

  Padding configPage(OrderController controller, BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: kDefaultPadding.w, right: kDefaultPadding.w),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("addMoreServices".tr,
                      style: AppTextStyle().heading2Regular20),
                  SizedBox(height: kDefaultPaddingWidget.h),
                  buildServices(controller),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: controller.serviceList.length,
                  //   itemBuilder: (context, index) {
                  //     return Obx(
                  //       () => Padding(
                  //         padding: EdgeInsets.only(bottom: kDefaultPaddingItem.h),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(controller.serviceList[index].label ?? '',
                  //                 style: AppTextStyle().titleRegular16),
                  //             CupertinoSwitch(
                  //               activeColor: kColorPrimaryLight,
                  //               value: controller.serviceList[index].isSelected ??
                  //                   false,
                  //               onChanged: (value) {
                  //                 controller.setValue(value, index);
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildConfirmConfigButton(context, controller),
            ],
          )
        ],
      ),
    );
  }

  Padding orderPage(OrderController controller, BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: kDefaultPadding.w, right: kDefaultPadding.w),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("booking".tr, style: AppTextStyle().heading2Regular20),
                  SizedBox(height: kDefaultPaddingWidget.h),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCalendar(controller),
                      SizedBox(height: kDefaultPadding.h),
                      morningTimePicker(controller),
                      SizedBox(height: kDefaultPadding.h),
                      buildSelectPersonNumber(controller),
                      SizedBox(height: kDefaultPadding.h),
                      if (controller.selectedProduct.isNotEmpty)
                        Row(
                          children: [
                            Text('${'additionalService'.tr}:',
                                style: AppTextStyle().titleRegular16),
                          ],
                        ),
                      SizedBox(height: kDefaultPaddingItem.h),
                      Row(
                        children: [
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...controller.listOption.map(
                                  (element) {
                                    if (element.quantity != 0 ||
                                        element.isSelect == true) {
                                      return Column(
                                        children: [
                                          if (element.quantity != 0)
                                            Text(
                                                "${element.name ?? ''} - ${'amount'.tr}: ${element.quantity}")
                                          else
                                            Text(element.name ??
                                                ''), // - Số Lượng: ${element.quantity == 0 ? 1 : element.quantity}
                                          SizedBox(
                                              height: kDefaultPaddingWidget.h),
                                        ],
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5.h),
                      addServiceButton(controller),
                      renderTicket(context, controller, widget.vendorInfo),
                      clientNote(context, controller),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildConfirmButton(context, controller),
            ],
          )
        ],
      ),
    );
  }

  Padding confirmPage(OrderController controller, BuildContext context) {
    VendorsDetailController vendorsDetailController = Get.find();

    return Padding(
      padding:
          EdgeInsets.only(left: kDefaultPadding.w, right: kDefaultPadding.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Confirm".tr,
                          style: AppTextStyle().heading2Regular20),
                      SizedBox(height: kDefaultPaddingWidget.h),
                      Expanded(
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('confirmPageDescription'.tr),
                              SizedBox(height: kDefaultPadding.h),
                              buildConfirmPageBrandName(
                                  vendorsDetailController),
                              SizedBox(height: kDefaultPaddingItem.h),
                              buildConfirmPageAddress(vendorsDetailController),
                              SizedBox(height: kDefaultPadding.h),
                              Wrap(
                                direction: Axis.horizontal,
                                runSpacing: kDefaultPaddingItem.h,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          kDefaultPadding,
                                      child: buildConfirmPageType()),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          kDefaultPadding,
                                      child: buildConfirmPageSlot(controller)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          kDefaultPadding,
                                      child:
                                          buildConfirmPageDateTime(controller)),
                                  Visibility(
                                    visible:
                                        controller.selectedVoucher.value.code !=
                                            "",
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          kDefaultPadding,
                                      child: renderVoucherInfo(context,
                                          controller.selectedVoucher.value),
                                    ),
                                  ),
                                ],
                              ),
                              if (controller.clientNote.value.isNotEmpty)
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: kDefaultPaddingItem.h),
                                    child:
                                        buildConfirmPageClientNote(controller),
                                  ),
                                ),
                              if (controller.selectedProduct.isNotEmpty)
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: kDefaultPaddingItem.h),
                                    child: buildConfirmPageProducts(controller),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                Visibility(
                  visible: widget.vendorInfo.category == CategoryType.massage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('temporaryPrice'.tr,
                          style: AppTextStyle().titleRegular16),
                      Obx(() => Container(
                            padding: EdgeInsets.zero,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                controller.preCalculatePriceWithDiscount
                                            .value !=
                                        '0 đ'
                                    ? RichText(
                                        text: TextSpan(
                                          text: controller
                                              .preCalculatePrice.value,
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: ThemeServices().isDarkMode
                                                  ? kColorGreyDark
                                                  : kColorGreyLight),
                                          children: <TextSpan>[
                                            const TextSpan(
                                                text: '  ',
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none)),
                                            TextSpan(
                                                text: controller
                                                    .preCalculatePriceWithDiscount
                                                    .value,
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18.sp,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ],
                                        ),
                                      )
                                    : Text(controller.preCalculatePrice.value,
                                        style: AppTextStyle().heading1Semi24),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.vendorInfo.category == CategoryType.massage,
                  child: Container(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text("notIncludeIncidentalCosts".tr,
                        textAlign: TextAlign.center,
                        style: subTitleStyle.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: buildBackButton(context, controller)),
                    SizedBox(width: kDefaultPaddingWidget.w),
                    Expanded(
                      child: buildSubmitButton(context, controller),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderVoucherInfo(BuildContext context, VoucherModel voucher) {
    return Container(
        padding: EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Ionicons.pricetag_sharp,
                color: Theme.of(context).primaryColor),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "discountCode".tr,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: kDefaultPaddingItem.h),
                    Flexible(
                      child: Text(voucher.title),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Row buildConfirmPageType() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Ionicons.list_circle, color: Theme.of(context).primaryColor),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "type".tr,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPaddingItem.h),
                Flexible(
                  child: Text(widget.type),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget renderTicket(BuildContext context, OrderController controller,
      VendorModel vendorsInfo) {
    return Obx(() => GestureDetector(
          onTap: () {
            context.router
                .push(
                  VoucherPage(
                      onBack: (VoucherModel voucher) {
                        controller.selectedVoucher.value = voucher;
                        controller.isSelectedVoucher.value = true;
                      },
                      selectedVoucher: controller.selectedVoucher.value,
                      isSelectedVoucher: controller.isSelectedVoucher.value,
                      vendorInfo: widget.vendorInfo,
                      vendorId: widget.vendorInfo.id ?? ""),
                )
                .then((value) => {Get.delete<VoucherController>()});
          },
          child: Container(
            margin: EdgeInsets.only(top: 0.h, bottom: kDefaultPaddingItem.h),
            // padding: EdgeInsets.only(bottom: 10.h),
            // decoration: BoxDecoration(
            //     border: Border(
            //         bottom: BorderSide(
            //             width: 1, color: Theme.of(context).primaryColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Ionicons.pricetag_outline,
                        size: 15.sp, color: Theme.of(context).primaryColor),
                    SizedBox(
                      width: kDefaultPaddingItem.w,
                    ),
                    controller.selectedVoucher.value.id != ""
                        ? Container(
                            margin: EdgeInsets.only(top: 3.h),
                            child: Text(controller.selectedVoucher.value.title,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ThemeServices().isDarkMode
                                        ? Colors.grey[400]
                                        : Colors.black)),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 3.h),
                            child: Text("Laka Voucher",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ThemeServices().isDarkMode
                                        ? Colors.grey[400]
                                        : Colors.black)),
                          )
                  ],
                ),
                Container(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 3.h),
                        padding: EdgeInsets.zero,
                        child: Text(
                            controller.selectedVoucher.value.id == ""
                                ? "pickOrEnterCode".tr
                                : "change".tr,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: ThemeServices().isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.black)),
                      ),
                      Icon(
                        Ionicons.chevron_forward_outline,
                        size: 16.sp,
                        color: ThemeServices().isDarkMode
                            ? kColorGreyDark
                            : kColorGreyLight,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Row buildConfirmPageClientNote(OrderController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Ionicons.document, color: Theme.of(context).primaryColor),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "note".tr,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPaddingItem.h),
                Flexible(
                  child: AutoSizeText(controller.clientNote.value),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildConfirmPageProducts(OrderController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Ionicons.star, color: Theme.of(context).primaryColor, size: 22),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "service".tr,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPaddingItem.h),
                Flexible(
                  child: Obx(
                    () => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: controller.listOption.length,
                      itemBuilder: (context, index) {
                        final element = controller.listOption[index];
                        if (element.quantity != 0 || element.isSelect == true) {
                          return element.quantity != 0
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(
                                      "${element.name ?? ''} - ${'amount'.tr}: ${element.quantity}"),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Text(element.name ?? ''),
                                );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildConfirmPageSlot(OrderController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Ionicons.people, color: Theme.of(context).primaryColor),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Số ${categoryTypeToSymbol(widget.vendorInfo.category)}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPaddingItem.h),
                Flexible(
                  child: Text(controller.personCount.toString()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row buildConfirmPageDateTime(OrderController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Ionicons.time, color: Theme.of(context).primaryColor),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "time".tr,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: kDefaultPaddingItem.h),
                Flexible(
                  child: AutoSizeText.rich(
                    TextSpan(
                      // style: const TextStyle(color: kColorTextLight),
                      children: [
                        TextSpan(
                            text: controller.splitText(controller.morningTimes[
                                controller.timeSelectValue.value])),
                        TextSpan(
                            text:
                                ' ${TGGTUtils().formatDateFromDateTime(controller.selectedRequestDay.value)}'),
                      ],
                    ),
                    maxLines: 1,
                  ),
                  // Row(
                  //   children: [
                  //     Text(controller.splitText(controller
                  //         .morningTimes[controller.timeSelectValue.value])),
                  //     Text(
                  //         ' ${TGGTUtils().formatDateFromDateTime(controller.selectedRequestDay.value)}'),
                  //   ],
                  // ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text buildConfirmPageAddress(
      VendorsDetailController vendorsDetailController) {
    return Text(
      vendorsDetailController.currentVendor.value.address.fullAddress,
      style: AppTextStyle().subtitleRegular14Grey.copyWith(height: 1.2),
    );
  }

  Text buildConfirmPageBrandName(
      VendorsDetailController vendorsDetailController) {
    return Text(
      vendorsDetailController.currentVendor.value.brandName,
      style: AppTextStyle().heading2Bold20,
    );
  }

  Obx buildServices(OrderController controller) {
    return Obx(
      () => Column(
        children: [
          ...controller.listOption.map((element) {
            if (element.type == 'option') {
              return Padding(
                padding: EdgeInsets.only(bottom: kDefaultPaddingItem.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(element.name ?? '',
                        style: AppTextStyle().titleRegular16),
                    CupertinoSwitch(
                      activeColor: Theme.of(context).primaryColor,
                      value: element.isSelect ?? false,
                      onChanged: (value) {
                        element.isSelect = value;
                        controller.listOption.refresh();
                      },
                    ),
                  ],
                ),
              );
            } else {
              return ServiceItem(
                label: element.name ?? '',
                value: element.quantity ?? 0,
                onSubtract: () {
                  var newValue = (element.quantity ?? 1) - 1;
                  element.quantity = newValue.clamp(0, 100);
                  controller.listOption.refresh();
                },
                onAdd: () {
                  var newValue = (element.quantity ?? 1) + 1;
                  element.quantity = newValue.clamp(0, 100);
                  controller.listOption.refresh();
                },
                onChanged: (value) {
                  element.quantity = value;
                  controller.listOption.refresh();
                },
                minValue: 0,
                maxValue: 100,
              );
            }
          }),
        ],
      ),
    );
  }

  Container addServiceButton(OrderController controller) {
    return Container(
      margin: EdgeInsets.only(top: kDefaultPaddingWidget.h, right: 5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 30.h,
            child: GestureDetector(
              onTap: () {
                // controller.pageController.nextPage(
                //     duration: const Duration(milliseconds: 300),
                //     curve: Curves.easeIn);
                controller.pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              child: Text(
                'addMoreServices'.tr,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding clientNote(BuildContext context, OrderController controller) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: TextField(
        controller: widget.textfieldController,
        decoration: InputDecoration(
          hintText: 'note'.tr,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: kColorGreyLight),
          ),
        ),
        autocorrect: false,
        maxLength: 200,
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }

  Column morningTimePicker(OrderController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("timePick".tr, style: AppTextStyle().titleRegular16),
        SizedBox(height: kDefaultPaddingItem.h),
        Obx(
          () => TimeBlockSlider(
              // ignore: invalid_use_of_protected_member
              timeList: controller.morningTimes.value,
              itemsSelectedValue: controller.timeSelectValue.value,
              selectItem: (index) {
                controller.timeSelectValue.value = index;
                controller.selectedRequestTime.value =
                    controller.timeList[index];
              }),
        ),
      ],
    );
  }

  Padding buildConfirmConfigButton(
      BuildContext context, OrderController controller) {
    return Padding(
      padding:
          EdgeInsets.only(top: kDefaultPadding.h, bottom: kDefaultPadding.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: kDefaultButtonHeight35.h,
            width: (Get.width / 2).w,
            child: ElevatedButton(
                onPressed: () {
                  controller.pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
                child: Text('confirm'.tr),
                style: roundedButtonStyle),
          ),
        ],
      ),
    );
  }

  Padding buildConfirmButton(BuildContext context, OrderController controller) {
    return Padding(
      padding:
          EdgeInsets.only(top: kDefaultPadding.h, bottom: kDefaultPadding.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: kDefaultButtonHeight35.h,
            width: (Get.width / 2).w,
            child: ElevatedButton(
                onPressed: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  controller.checkAdditionalService();
                  controller.clientNote.value = widget.textfieldController.text;
                  var isAvailble = await controller.requestPreCalculate();
                  if (isAvailble) {
                    controller.pageController.animateToPage(2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn);
                  } else {
                    showAlertDialog(
                        context: context,
                        title: 'outOfSlot2'.tr,
                        content: 'outOfSlot3'.tr,
                        cancelActionText: 'Ok');
                  }
                },
                child: Text('confirm'.tr),
                style: roundedButtonStyle),
          ),
        ],
      ),
    );
  }

  Padding buildBackButton(BuildContext context, OrderController controller) {
    return Padding(
      padding:
          EdgeInsets.only(top: kDefaultPadding.h, bottom: kDefaultPadding.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SizedBox(
              height: kDefaultButtonHeight35.h,
              child: ElevatedButton(
                  onPressed: () {
                    controller.pageController.animateToPage(1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                  },
                  child: Text('back'.tr),
                  style: roundedButtonStyle),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildSubmitButton(BuildContext context, OrderController controller) {
    return Padding(
      padding:
          EdgeInsets.only(top: kDefaultPadding.h, bottom: kDefaultPadding.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SizedBox(
              height: kDefaultButtonHeight35.h,
              child: ElevatedButton(
                  onPressed: () async {
                    await controller.requestOrder().then((value) {
                      if (controller.isSuccess) {
                        final MainController mainController =
                            Get.put(MainController(getIt.get<ApiClient>()));
                        Get.delete<OrderController>();
                        // Get.delete<VendorsDetailController>();
                        Get.delete<VendorsController>();
                        context.router.popUntilRoot();
                        mainController.changeTabIndex(1);
                        context.router.push(
                            ActivityDetailPage(id: value, isFromQr: false));
                      } else {
                        showAlertDialog(
                          context: context,
                          title: "failToOrder".tr,
                          content: "outOfSlot".tr,
                          cancelActionText: "OK",
                        );
                      }
                    });
                  },
                  child: Text('confirm'.tr),
                  style: roundedButtonStyle),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String cancelActionText,
  }) async {
    if (!GetPlatform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
              child: Text(cancelActionText),
              onPressed: () {
                context.router.pop();
              },
            ),
          ],
        ),
      );
    }

    // todo : showDialog for ios
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () {
              context.router.pop();
            },
          ),
        ],
      ),
    );
  }

  SizedBox buildSelectPersonNumber(OrderController controller) {
    return SizedBox(
      height: 50.h,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Số ${categoryTypeToSymbol(widget.vendorInfo.category)}",
              style: AppTextStyle().titleRegular16),
          SizedBox(width: kDefaultPaddingItem.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  var newValue = controller.personCount.value - 1;
                  controller.personCount.value = newValue.clamp(1, 100);
                },
                child: Icon(
                  Ionicons.remove_circle,
                  color: Theme.of(context).primaryColor,
                  size: 36.r,
                ),
              ),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(top: 4.0.h),
                child: Obx(() => NumberPicker(
                    value: controller.personCount.value,
                    axis: Axis.horizontal,
                    itemWidth: 36.w,
                    itemHeight: 36.h,
                    minValue: 1,
                    maxValue: 100,
                    haptics: true,
                    selectedTextStyle: AppTextStyle()
                        .heading2Bold20
                        .copyWith(color: Theme.of(context).primaryColor),
                    onChanged: (value) =>
                        controller.personCount.value = value)),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () {
                  var newValue = controller.personCount.value + 1;
                  controller.personCount.value = newValue.clamp(1, 100);
                },
                child: Icon(
                  Ionicons.add_circle,
                  color: Theme.of(context).primaryColor,
                  size: 36.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildGreyBarHeader() {
    return Padding(
      padding: EdgeInsets.only(
          top: kDefaultPaddingWidget.h, bottom: kDefaultPaddingWidget.h),
      child: Container(
        width: 100.w,
        height: 7.h,
        decoration: BoxDecoration(
          color:
              ThemeServices().isDarkMode ? kColorPrimaryDark : kColorGreyLight,
          borderRadius: BorderRadius.circular(3.5.r),
        ),
      ),
    );
  }

  Column buildCalendar(OrderController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("datePick".tr, style: AppTextStyle().titleRegular16),
        Obx(
          () => TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2099, 1, 1),
            focusedDay: controller.focusedDay.value,
            availableCalendarFormats: const {CalendarFormat.week: 'Week'},
            calendarFormat: controller.calendarFormat.value,
            headerStyle: const HeaderStyle(titleCentered: true),
            daysOfWeekStyle: ThemeServices().isDarkMode
                ? DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondaryVariant),
                    weekendStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                : const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Color(0xFF4F4F4F)),
                    weekendStyle: TextStyle(color: Color(0xFF6A6A6A)),
                  ),
            selectedDayPredicate: (day) {
              return isSameDay(controller.focusedDay.value, day);
            },
            onFormatChanged: (format) {
              controller.calendarFormat.value = format;
            },
            onDaySelected: (selectedDay, focusedDay) {
              controller.selectedDay.value =
                  TGGTUtils().formatDateFromDateTime(selectedDay);
              controller.selectedRequestDay.value = selectedDay;
              controller.focusedDay.value = focusedDay;
              controller.initTimes();
            },
            locale: AccountServices().getLanguageCode(),
            calendarBuilders: CalendarBuilders(
              // markerBuilder: (context, day, events) => Container(
              //   width: 6.w,
              //   height: 6.h,
              //   margin: EdgeInsets.only(bottom: kChipPadding.h),
              //   alignment: Alignment.center,
              //   decoration: const BoxDecoration(
              //     color: kColorActionSuccess,
              //     shape: BoxShape.circle,
              //   ),
              // ),
              selectedBuilder: (context, date, events) => Container(
                height: 62.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                      color: Theme.of(context).backgroundColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              todayBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                child: Text(
                  date.day.toString(),
                  style: AppTextStyle()
                      .heading3Bold18
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            // eventLoader: (day) {
            //   return ['Cyclic event'];
            // },
          ),
        ),
      ],
    );
  }
}

// Padding buildDateTime(OrderController controller, BuildContext context) {
//   return Padding(
//     padding: EdgeInsets.only(top: kDefaultPaddingWidget.h),
//     child: Row(
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: 45.h,
//             child: OutlinedButton(
//                 onPressed: () {
//                   controller.isSelectDate.value =
//                       !controller.isSelectDate.value;
//                   controller.setSelectDate();
//                 },
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       CupertinoIcons.calendar_today,
//                       color: kColorPrimaryLight,
//                     ),
//                     SizedBox(width: 8.w),
//                     Obx(() => Text(
//                           controller.selectedDay.value,
//                           style: AppTextStyle().titleRegular16,
//                         )),
//                   ],
//                 ),
//                 style: outlinedRoundedStyle),
//           ),
//         ),
//         SizedBox(width: kDefaultPaddingWidget.w),
//         SizedBox(
//           height: 45.h,
//           child: OutlinedButton(
//               onPressed: () {
//                 controller.isSelectTime.value = !controller.isSelectTime.value;
//                 controller.setSelectTime();
//               },
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     CupertinoIcons.clock,
//                     color: kColorPrimaryLight,
//                   ),
//                   SizedBox(width: 8.w),
//                   Obx(() => Text(
//                         controller.selectedTime.value,
//                         style: AppTextStyle().titleRegular16,
//                       )),
//                 ],
//               ),
//               style: outlinedRoundedStyle),
//         ),
//       ],
//     ),
//   );
// }

// Obx buildTimePicker(BuildContext context, OrderController controller) {
//   return Obx(() => AnimatedSize(
//         duration: const Duration(milliseconds: 200),
//         child: Padding(
//           padding: EdgeInsets.only(top: kDefaultPaddingWidget.h),
//           child: Container(
//             height: controller.isSelectTime.value ? null : 0.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(defaultBorderRadius.r),
//               border:
//                   Border.all(color: Theme.of(context).primaryColor, width: 2),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 NumberPicker(
//                     zeroPad: true,
//                     value: controller.selectHour.value,
//                     axis: Axis.vertical,
//                     itemWidth: 50,
//                     minValue: 1,
//                     maxValue: 24,
//                     selectedTextStyle: AppTextStyle()
//                         .heading1Bold24
//                         .copyWith(color: kColorPrimaryLight),
//                     onChanged: (value) {
//                       controller.selectHour.value = value;
//                       controller.buildTime();
//                     }),
//                 SizedBox(width: kDefaultPadding.w),
//                 const Text(':'),
//                 SizedBox(width: kDefaultPadding.w),
//                 NumberPicker(
//                     zeroPad: true,
//                     value: controller.selectMinute.value,
//                     axis: Axis.vertical,
//                     itemWidth: 50,
//                     minValue: 0,
//                     maxValue: 59,
//                     selectedTextStyle: AppTextStyle()
//                         .heading1Bold24
//                         .copyWith(color: kColorPrimaryLight),
//                     onChanged: (value) {
//                       controller.selectMinute.value = value;
//                       controller.buildTime();
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ));
// }

// DatePicker buildDatePicker(BuildContext context, OrderController controller) {
//   return DatePicker.showTimePicker(
//     context,
//     currentTime: controller.focusedTime.value,
//     showSecondsColumn: false,
//     onConfirm: (time) {
//       controller.focusedTime.value = time;
//       controller.selectedTime.value = TGGTUtils().formatDateTimeToTime(time);
//       controller.selectedRequestTime.value = time;
//     },
//   );
// }

// chooseService(BuildContext context, VendorsDetailController controller) {
//   return Get.bottomSheet(
//     Container(
//       color: Colors.white,
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: controller.currentVendor.value.products!.length,
//         itemBuilder: (_, index) {
//           return SizedBox(
//             width: double.infinity,
//             child: Padding(
//               padding: EdgeInsets.only(
//                   left: kDefaultPadding.w,
//                   right: kDefaultPadding.w,
//                   top: kDefaultPaddingItem.h),
//               child: OutlinedRoundedButton(
//                   label: controller.currentVendor.value.products![index].name,
//                   callback: () {
//                     controller.setProduct(
//                         controller.currentVendor.value.products![index].name,
//                         controller.currentVendor.value.products![index].price
//                             .toDouble(),
//                         controller
//                             .currentVendor.value.products![index].details);
//                     //Get.back();
//                     context.router.pop();
//                   }),
//             ),
//           );
//         },
//       ),
//     ),
//     enableDrag: true,
//   );
// }
