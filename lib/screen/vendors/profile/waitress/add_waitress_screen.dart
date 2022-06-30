import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/screen/vendors/profile/waitress/add_waitress_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/textfield/secondary_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class AddWaitressScreen extends StatelessWidget {
  const AddWaitressScreen({Key? key, this.onBack}) : super(key: key);
  final Function(StaffModel item)? onBack;
  @override
  Widget build(BuildContext context) {
    final AddWaitressController controller =
        Get.put(AddWaitressController(getIt.get<ApiClient>()));
    final _formKey = GlobalKey<FormState>();

    return BaseScreen(
      title: "Thêm kỹ thuật viên",
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Icon(
            Ionicons.chevron_back_outline,
            color: Theme.of(context).iconTheme.color,
          )),
      child: Obx(
        () => Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingScreen.w,
              vertical: kDefaultPaddingWidget.h),
          child: Column(
            children: [
              Container(
                // height: MediaQuery.of(context).size.height,
                child: Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
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
                                              File(controller
                                                      .avatar.value.path ??
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
                                        child: SvgPicture.asset(
                                          AppPath.avatarDefault,
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
                                            actions: <
                                                CupertinoActionSheetAction>[
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
                                label: "Tên kỹ thuật viên",
                                onChanged: (text) {
                                  // controller.handleCheckInformation();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Họ tên là bắt buộc";
                                  }
                                  return null;
                                },
                                controller:
                                    controller.fullNameController.value),
                            SizedBox(
                              height: kDefaultPaddingWidget.h,
                            ),
                            SecondaryTextfield(
                                label: "Giới thiệu",
                                minLines: 5,
                                maxLines: 15,
                                onChanged: (text) {
                                  // controller.handleCheckInformation();
                                },
                                controller:
                                    controller.descriptionController.value),
                          ],
                        ),
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
                                    await controller.handleAddStaff();
                                if (status == true) {
                                  onBack?.call(controller.staffItem.value);
                                  context.router.pop();
                                }
                              }
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
