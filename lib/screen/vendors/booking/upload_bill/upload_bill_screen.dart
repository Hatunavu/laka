import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/vendors/booking/confirm_complete/confirm_complete_controller.dart';
import 'package:client_tggt/screen/vendors/booking/upload_bill/upload_bill_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/textfield/custome_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadBillScreen extends StatelessWidget {
  const UploadBillScreen({Key? key, required this.onBack}) : super(key: key);
  final Function(List<String> listImage)? onBack;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final UploadBillController controller =
        Get.put(UploadBillController(getIt.get<ApiClient>()));
    return BaseScreen(
        title: "Cập nhật ảnh hoá đơn",
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            //chevron-back-outline
            icon: const Icon(
              Ionicons.chevron_back_outline,
              size: 23,
              color: Colors.black,
            )),
        child: Obx(() => Container(
              padding:
                  EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
              child: Column(
                children: [
                  SizedBox(
                    height: kDefaultPaddingWidget.h,
                  ),
                  Visibility(
                      visible: controller.listError.contains("image"),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 6.h),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "imageEmpty".tr,
                          textAlign: TextAlign.start,
                          style: subTitleStyle.copyWith(color: Colors.red),
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
                  Expanded(child: renderListGalleryImage(context, controller)),
                  SizedBox(height: kDefaultPaddingWidget.h),
                  InkwellButtonLoading(
                    onPressed: () {
                      final check = controller.handleConfirm();
                      if (check == false) return;
                      onBack?.call(controller.listUrlImageUpload);
                      context.router.pop();
                    },
                    label: "confirm".tr,
                  ),
                ],
              ),
            )));
  }
}

Widget renderListGalleryImage(
    BuildContext context, UploadBillController controller) {
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
                              controller
                                  .handleUploadImageGallery(ImageSource.camera);
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
