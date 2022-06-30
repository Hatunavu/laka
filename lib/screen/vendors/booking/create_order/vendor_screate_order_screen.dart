import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/booking/create_order/vendor_create_order_controller.dart';
import 'package:client_tggt/screen/vendors/booking/create_order/widget/vendor_product_item.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/dialog/dialog_textfield.dart';
import 'package:client_tggt/shared/widget/textfield/custome_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class VendorsCreateOrderScreen extends StatefulWidget {
  VendorsCreateOrderScreen({Key? key, this.onBack}) : super(key: key);

  final Function()? onBack;
  @override
  State<VendorsCreateOrderScreen> createState() =>
      _VendorsCreateOrderScreenState();
}

class _VendorsCreateOrderScreenState extends State<VendorsCreateOrderScreen> {
  final VendorCreateOrderController controller =
      Get.put(VendorCreateOrderController(getIt.get<ApiClient>()));
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "createOrder".tr,
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(
              Ionicons.chevron_back_outline,
              size: 23.sp,
              color: Colors.black,
            )),
        child: Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
            margin: EdgeInsets.only(top: kDefaultPaddingItem.h),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.router.push(VendorListProductPage(
                                    listProduct: controller.listServices,
                                    selectedProduct: controller
                                                .selectedServices.value.name !=
                                            ""
                                        ? controller.selectedServices.value
                                        : null,
                                    onBack: (ServicesModel item) {
                                      controller.selectedServices.value = item;
                                    }));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: kDefaultPaddingItem.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "servicePack".tr,
                                      style: titleStyle,
                                    ),
                                    Icon(
                                      Ionicons.chevron_forward_outline,
                                      // color: ,
                                      size: 23.sp,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            controller.selectedServices.value.name == ""
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: kDefaultPaddingItem.h),
                                    child: Text("notPickRoomType".tr,
                                        style: subTitleStyle.copyWith(
                                            color: Colors.red)),
                                  )
                                : VendorProductItem(
                                    item: controller.selectedServices.value,
                                  )
                          ],
                        ),
                        CustomeTextField(
                          title: "billTotal".tr,
                          hint: "",
                          keyboardType: TextInputType.number,
                          controller: controller.priceController.value,
                          isReadOnly: false,
                          onChanged: (text) {
                            controller.handleSaveServicesPrice();
                          },
                          widget: Container(
                              margin: EdgeInsets.only(
                                  right: kDefaultPaddingScreen.w),
                              child: Text(
                                "đ",
                                style: titleStyle,
                              )),
                        ),
                        Visibility(
                            visible:
                                controller.listError.contains("totalPrice"),
                            child: Container(
                              margin: EdgeInsets.only(top: 6.h),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "billEmpty".tr,
                                textAlign: TextAlign.start,
                                style:
                                    subTitleStyle.copyWith(color: Colors.red),
                              ),
                            )),
                        SizedBox(
                          height: kDefaultPaddingScreen.h,
                        ),
                        CustomeTextField(
                          title: "discount2".tr,
                          hint: "",
                          keyboardType: TextInputType.number,
                          isReadOnly: false,
                          onChanged: (text) {
                            controller.handleUpdateDiscount();
                          },
                          controller: controller.discountController.value,
                          widget: Container(
                              margin: EdgeInsets.only(
                                  right: kDefaultPaddingScreen.w),
                              child: Text(
                                "%",
                                style: titleStyle,
                              )),
                        ),
                        SizedBox(
                          height: kDefaultPaddingWidget.h * 1.5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "paymentAmount".tr,
                              style: titleStyle,
                            ),
                            RichText(
                              text: TextSpan(
                                text: controller.finalPrice.value,
                                style: titleStyle.copyWith(
                                    color: kColorPrimaryLight),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: ' ',
                                  ),
                                  TextSpan(text: 'đ'),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPaddingScreen.h,
                        ),
                        SizedBox(
                          height: kDefaultPaddingScreen.h * 1.5,
                        ),
                        Visibility(
                            visible: controller.listError.contains("image"),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 6.h),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "imageEmpty".tr,
                                textAlign: TextAlign.start,
                                style:
                                    subTitleStyle.copyWith(color: Colors.red),
                              ),
                            )),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "imageBill".tr,
                                style: titleStyle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: kDefaultPaddingScreen.h,
                        ),
                        Expanded(child: renderListGalleryImage(context)),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  child: InkwellButtonLoading(
                      label: "confirm".tr,
                      isLoading: controller.isLoading.value,
                      onPressed: () async {
                        final createOrderStatus =
                            await controller.handleCreateOrder();
                        if (createOrderStatus == true) {
                          widget.onBack?.call();
                          Navigator.of(context).pop();
                        }
                      }),
                )
                // renderAddPrice(context)
              ],
            ),
          ),
        ));
  }

  Widget renderAddPrice(BuildContext context) {
    final currencyFormatter = NumberFormat('#,##0  đ', 'ID');

    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // renderErrorMessage(context, "Giá dịch vụ: ", "Giá dịch vụ là bắt buộc",
          //     controller.listError.contains("price")),
          Text(
            "servicePrice".tr,
            style: titleStyle,
          ),
          SizedBox(
            height: kDefaultPaddingItem.h,
          ),
          InkWell(
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext dialogContext) {
                    return DialogTextField(
                      context: context,
                      controller: controller.priceController.value,
                      hint: "addPrice".tr,
                      title: 'addPrice'.tr,
                      minLines: 1,
                      inputType: TextInputType.number,
                      onConfirm: () {
                        controller.handleSaveServicesPrice();
                        Navigator.pop(context);
                      },
                      onDismiss: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              child: Container(
                  padding: EdgeInsets.only(
                      left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
                  // height: 45.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: controller.listError.contains("price")
                              ? Colors.red
                              : Colors.grey,
                          width: 1.0)),
                  child: Stack(
                    children: [
                      Visibility(
                        visible: controller.orderPrice.value == "0",
                        child: Text(
                          "0",
                          style: subTitleStyle,
                        ),
                      ),
                      Visibility(
                          visible: controller.orderPrice.value != "0",
                          child: Text(
                            currencyFormatter.format(
                                double.parse(controller.orderPrice.value)),
                            style: const TextStyle(fontSize: 15),
                          )),
                    ],
                  ))),
        ],
      ),
    );
  }

  Widget renderListGalleryImage(BuildContext context) {
    return controller.isLoadingPick.isTrue
        ? Container(
            alignment: Alignment.center,
            width: 50.w,
            height: 5.0.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          )
        : GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: controller.listLocalImages.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < controller.listLocalImages.length) {
                final GalleryModel item = controller.listLocalImages[index];
                return Container(
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: [
                      Positioned(
                          child: FittedBox(
                              fit: BoxFit.contain,
                              child: Container(
                                color: Colors.teal,
                                width: MediaQuery.of(context).size.width - 6,
                                height: MediaQuery.of(context).size.width - 6,
                                child: Image.file(
                                  File(item.path!),
                                  fit: BoxFit.cover,
                                ),
                              ))),
                      Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () {
                              controller.handleRemoveImageBill(index);
                            },
                            child: Container(
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Ionicons.close_circle_outline,
                                size: 20.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              }
              return InkWell(
                onTap: () {
                  showCupertinoModalPopup<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) {
                        return CupertinoActionSheet(
                          title: Text('action'.tr),
                          // message: const Text('Message'),
                          actions: <CupertinoActionSheetAction>[
                            CupertinoActionSheetAction(
                              child: Text('camera'.tr),
                              onPressed: () {
                                controller.handleUploadImageGallery(
                                    ImageSource.camera);
                                context.router.pop();
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text('photoLibrary'.tr),
                              onPressed: () {
                                controller.handleUploadImageGallery(
                                    ImageSource.gallery);
                                context.router.pop();
                              },
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => context.router.pop(),
                            child: Text(
                              'cancel'.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ),
              );
            });
  }
}
