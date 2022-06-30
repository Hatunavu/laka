import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/custome_cupertino_alert.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupVendorFifth extends StatelessWidget {
  const SignupVendorFifth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateVendorController controller =
        Get.put(CreateVendorController(getIt.get<ApiClient>()));
    return Obx(() => BaseScreen(
          backgroundColor: Theme.of(context).backgroundColor,
          title: "serviceImage".tr,
          child: Container(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPaddingWidget.w),
                        child: Text(
                          "provide5Image".tr,
                          style: subTitleStyle,
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPaddingWidget.h,
                      ),
                      Visibility(
                          visible: controller.listLocalImage.isEmpty,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPaddingScreen.w),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller
                                        .handleUploadImage(ImageSource.camera);
                                  },
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: defaultPaddingItem.w,
                                        vertical: defaultPaddingItem.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                          width: 0.5, color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Ionicons.camera_outline,
                                          size: 23.sp,
                                        ),
                                        SizedBox(
                                          width: kDefaultPaddingWidget.w,
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 6.h),
                                            child: Text("takeNewPhoto".tr,
                                                style: subTitleStyle))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: defaultPaddingItem.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller
                                        .handleUploadImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: defaultPaddingItem.w,
                                        vertical: defaultPaddingItem.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                          width: 0.5, color: Colors.grey),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Ionicons.images_outline,
                                          size: 23.sp,
                                        ),
                                        SizedBox(
                                          width: kDefaultPaddingWidget.w,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 6.h),
                                          child: Text("openGallery".tr,
                                              style: subTitleStyle),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      controller.listLocalImage.isNotEmpty
                          ? renderListImage(context, controller)
                          : Container(),
                    ],
                  ),
                )),
                renderBottomAction(context, controller),
              ],
            ),
          ),
        ));
  }
}

Widget renderBottomAction(
    BuildContext context, CreateVendorController controller) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingScreen.w, vertical: kDefaultPaddingWidget.h),
    decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5.h))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(children: [
          GestureDetector(
            onTap: () {
              context.router.pop();
            },
            child: Text(
              "back".tr,
              style: titleStyle,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            color: Colors.black,
          )
        ]),
        Visibility(
            visible: controller.listLocalImage.length > 4,
            child: InkwellButtonLoading(
                label: "next".tr,
                isLoading: controller.isLoadingApply.value,
                onPressed: () async {
                  bool createStatus = await controller.handleApplyVendor();

                  if (createStatus == true) {
                    context.router.replace(const SignupVendorSuccessPage());
                  } else {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) {
                        return CustomCupertinoAlert(
                          context: context,
                          title: "haveError".tr,
                          content: 'tryLater'.tr,
                          rightButtonTitle: 'confirm'.tr,
                          rightAction: () async {
                            await Get.delete<CreateVendorController>();
                            Navigator.pop(context);
                            context.router.popUntilRoot();
                            context.router.replace(MainPage());
                          },
                        );
                      },
                    );
                  }
                }))
      ],
    ),
  );
}

Widget renderTitleStep(BuildContext context, String title) {
  return Container(
    padding: EdgeInsets.zero,
    child: Text(
      title,
      style: titleStyle,
    ),
  );
}

Widget renderListImage(
    BuildContext context, CreateVendorController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    child: Column(
      children: [
        renderThumbnailImage(context, controller),
        renderListImageVendor(context, controller),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        renderButtonUpload(context, controller),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
      ],
    ),
  );
}

Widget renderThumbnailImage(
    BuildContext context, CreateVendorController controller) {
  final thubnailImage = controller.listLocalImage[0];

  return Stack(
    children: [
      Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
        ),
        width: double.infinity,
        child: Image.file(
          File(thubnailImage.path ?? ""),
          fit: BoxFit.fill,
        ),
      ),
      Positioned(
          right: kDefaultPaddingScreen.w - 5.w,
          top: kDefaultPaddingScreen.h - 5.h,
          child: GestureDetector(
            onTap: () {
              controller.handleRemoveImage(0);
            },
            child: Container(
              width: 23.w,
              height: 23.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23.r),
                  color: Colors.white),
              child: Icon(
                Ionicons.close_outline,
                size: 18.sp,
              ),
            ),
          )),
      Positioned(
          left: kDefaultPaddingScreen.w - 5.w,
          top: kDefaultPaddingScreen.h - 2.h,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPaddingItem.w, vertical: 5.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(defaultBorderRadius.r)),
            child: Text("avatar".tr, style: subTitleSecondaryStyle),
          ))
    ],
  );
}

Widget renderButtonUpload(
    BuildContext context, CreateVendorController controller) {
  return GestureDetector(
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
                    controller.handleUploadImage(ImageSource.camera);
                    context.router.pop();
                  },
                ),
                CupertinoActionSheetAction(
                  child: Text('photoLibrary'.tr),
                  onPressed: () {
                    controller.handleUploadImage(ImageSource.gallery);
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
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
          horizontal: defaultPaddingItem.w, vertical: defaultPaddingItem.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Ionicons.arrow_up_outline,
            size: 23.sp,
          ),
          SizedBox(
            width: kDefaultPaddingWidget.w,
          ),
          Container(
              margin: EdgeInsets.only(top: 6.h),
              child: Text("uploadImage".tr, style: subTitleStyle))
        ],
      ),
    ),
  );
}

Widget renderListImageVendor(
    BuildContext context, CreateVendorController controller) {
  final List<GalleryModel> listImage = controller.listLocalImage
      .where((item) => item.path != controller.listLocalImage[0].path)
      .toList();
  return listImage.isEmpty
      ? Container()
      : GridView.builder(
          padding: EdgeInsets.only(top: kDefaultPaddingScreen.h),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: kDefaultPaddingScreen.w,
            crossAxisSpacing: kDefaultPaddingScreen.w,
          ),
          itemCount: listImage.length,
          itemBuilder: (context, index) {
            final GalleryModel item = listImage[index];
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  width: double.infinity,
                  child: Image.file(
                    File(item.path ?? ""),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    right: kDefaultPaddingScreen.w - 5.w,
                    top: kDefaultPaddingScreen.h - 5.h,
                    child: GestureDetector(
                      onTap: () {
                        controller.handleRemoveImage(index);
                      },
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: Colors.white),
                        child: Icon(
                          Ionicons.close_outline,
                          size: 16.sp,
                        ),
                      ),
                    )),
                // Positioned(
                //     left: kDefaultPaddingScreen.w,
                //     top: kDefaultPaddingScreen.h + 3.h,
                //     child: Container(
                //       padding: EdgeInsets.symmetric(
                //           horizontal: defaultPaddingItem.w, vertical: 5.h),
                //       decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(defaultBorderRadius.r)),
                //       child: Text("Đă", style: subTitleSecondaryStyle),
                //     ))
              ],
            );
          },
        );
}
