import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/extensions/currency_formatting.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:client_tggt/screen/vendors/profile/menu/add_menu/add_menu_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/textfield/secondary_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class AddMenuScreen extends StatelessWidget {
  const AddMenuScreen({Key? key, this.onBack}) : super(key: key);
  final Function(MenuModel item)? onBack;
  @override
  Widget build(BuildContext context) {
    final AddMenuController controller =
        Get.put(AddMenuController(getIt.get<ApiClient>()));
    final _formKey = GlobalKey<FormState>();

    return BaseScreen(
      title: "Thêm menu",
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Icon(
            Ionicons.chevron_back_outline,
            color: Theme.of(context).iconTheme.color,
          )),
      child: Obx(
        () => SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPaddingScreen.w,
                vertical: kDefaultPaddingWidget.h),
            child: Column(
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          controller.isLoadingPickImage.isTrue
                              ? Container(
                                  width: 120.w,
                                  height: 120.w,
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    child: Lottie.asset(AppPath.appLoading,
                                        frameRate: FrameRate.max),
                                    height: 68.h,
                                    width: 100.w,
                                  ),
                                )
                              : controller.isPickImage.isTrue
                                  ? Container(
                                      width: 120.w,
                                      height: 120.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(120.r)),
                                      // child: Image.file(
                                      //   File(controller.avatar.value.path ?? ""),
                                      //   fit: BoxFit.cover,
                                      // )
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 60.r,
                                        child: CircleAvatar(
                                          radius: 60.r - 5.r,
                                          backgroundImage: Image.file(
                                            File(controller.avatar.value.path ??
                                                ""),
                                            fit: BoxFit.cover,
                                          ).image,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 120.w,
                                      height: 120.w,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        AppPath.menuIconDefault,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                          SizedBox(
                            height: kDefaultPaddingItem.h,
                          ),
                          Container(
                              padding: EdgeInsets.zero,
                              child: GestureDetector(
                                onTap: () {
                                  showCupertinoModalPopup<void>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext dialogContext) {
                                        return CupertinoActionSheet(
                                          title: Text('action'.tr),
                                          actions: <CupertinoActionSheetAction>[
                                            CupertinoActionSheetAction(
                                              child: Text('camera'.tr),
                                              onPressed: () {
                                                controller.handlePickImage(
                                                    ImageSource.camera);
                                                context.router.pop();
                                              },
                                            ),
                                            CupertinoActionSheetAction(
                                              child: Text('photoLibrary'.tr),
                                              onPressed: () {
                                                controller.handlePickImage(
                                                    ImageSource.gallery);
                                                context.router.pop();
                                              },
                                            ),
                                          ],
                                          cancelButton:
                                              CupertinoActionSheetAction(
                                            onPressed: () =>
                                                context.router.pop(),
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
                                child: Text(
                                    controller.isPickImage.isTrue
                                        ? "Thay đổi"
                                        : "Chọn ảnh",
                                    style: titleStyle.copyWith(
                                        color: kColorPrimaryLight)),
                              )),
                          SizedBox(
                            height: kDefaultPaddingWidget.h * 2,
                          ),
                          SecondaryTextfield(
                              label: "Tên món",
                              onChanged: (text) {
                                // controller.handleCheckInformation();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Tên món ăn là bắt buộc";
                                }
                                return null;
                              },
                              controller: controller.fullNameController.value),
                          SizedBox(
                            height: kDefaultPaddingWidget.h,
                          ),
                          SecondaryTextfield(
                              label: "Giá (vnđ)",
                              isNumber: true,
                              onChanged: (string) {
                                if (string.split("").length > 4) {
                                  final priceString =
                                      string.replaceAll(".", "");
                                  controller.priceController.value.text =
                                      int.parse(priceString).formatCurrency2();
                                  controller.priceController.value.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: controller.priceController
                                              .value.text.length));
                                }

                                print(string);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Giá món ăn là bắt buộc";
                                }
                                return null;
                              },
                              controller: controller.priceController.value),
                          // CustomeTextField(
                          //   title: "Giá",
                          //   hint: "",
                          //   keyboardType: TextInputType.number,
                          //   controller: controller.priceController.value,
                          //   isReadOnly: false,
                          //   onChanged: (text) {
                          //     // controller.handleUpdateFinalPrice();
                          //   },
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Bạn chưa nhập giá';
                          //     }
                          //     return null;
                          //   },
                          //   widget: Container(
                          //       margin: EdgeInsets.only(
                          //           right: kDefaultPaddingScreen.w),
                          //       child: Text(
                          //         "đ",
                          //         style: titleStyle,
                          //       )),
                          // ),
                          SizedBox(
                            height: kDefaultPaddingWidget.h,
                          ),
                          SecondaryTextfield(
                              label: "Mô tả",
                              minLines: 5,
                              maxLines: 15,
                              onChanged: (text) {
                                // controller.handleCheckInformation();
                              },
                              controller:
                                  controller.descriptionController.value),
                        ],
                      ),
                      SizedBox(
                        height: kDefaultPaddingWidget.h * 2,
                      ),
                      Visibility(
                        visible: controller.fullNameController.value.text != "",
                        child: InkwellButtonLoading(
                            label: "Xác nhận",
                            isLoading: controller.isLoading.value,
                            onPressed: () async {
                              if (controller.isPickImage.isFalse) {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CupertinoAlertDialog(
                                          title: const Text("Thông báo"),
                                          content: const Text(
                                              "Bạn chưa chọn ảnh kỹ thuật viên"),
                                          actions: [
                                            CupertinoDialogAction(
                                                child: const Text("Xác nhận"),
                                                onPressed: () {
                                                  context.router.pop();
                                                })
                                          ],
                                        ));
                              } else {
                                final bool status =
                                    await controller.handleAddMenuItem();
                                if (status == true) {
                                  onBack?.call(controller.menuItem.value);
                                  context.router.pop();
                                }
                              }
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
