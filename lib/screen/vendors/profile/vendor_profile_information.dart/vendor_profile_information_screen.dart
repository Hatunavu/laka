import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/service_item_detail_screen.dart';
import 'package:client_tggt/screen/vendors/product/widget/service_detail_shimmer.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_profile_information.dart/vendor_profile_information_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/dialog/dialog_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class VendorProfileInformation extends StatelessWidget {
  const VendorProfileInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorProfileInformationController controller =
        Get.put(VendorProfileInformationController(getIt.get<ApiClient>()));
    return BaseScreen(
        title: "Hồ sơ",
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: const Icon(
              Ionicons.chevron_back_outline,
              size: 23,
              color: Colors.black,
            )),
        child: Obx(() => controller.isLoading.isTrue
            ? const ServiceDetailShimmer()
            : Container(
                padding: EdgeInsets.only(
                    left: kDefaultPaddingWidget.w,
                    // right: kDefaultPaddingWidget,
                    bottom: kDefaultPaddingWidget.h),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        renderThumbnail(context, controller),
                        renderLineWidget(context),
                        renderBrandname(context, controller),
                        renderLineWidget(context),
                        renderDescription(context, controller),
                        renderLineWidget(context),
                        renderAddress(context, controller),
                        SizedBox(
                          height: kDefaultPaddingWidget.h * 2,
                        )
                      ],
                    )))));
  }
}

Widget renderThumbnail(
    BuildContext context, VendorProfileInformationController controller) {
  final profile = controller.account.value;
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ảnh đại diện: ".toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: HexColor(greyTextColor),
              ),
            ),
            InkWell(
              onTap: () {
                showCupertinoModalPopup<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return CupertinoActionSheet(
                        title: const Text('Thao tác'),
                        // message: const Text('Message'),
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            child: const Text('Chụp ảnh'),
                            onPressed: () {
                              controller.handlePickImage(ImageSource.camera);
                              context.router.pop();
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('Thư viện hình ảnh'),
                            onPressed: () {
                              controller.handlePickImage(ImageSource.gallery);
                              context.router.pop();
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () => context.router.pop(),
                          child: const Text(
                            'Huỷ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    });
                // showDialog<String>(
                //     context: context,
                //     builder: (BuildContext context) => CupertinoAlertDialog(
                //           title: const Text("Thông báo"),
                //           content: const Text("Tính năng đang được phát triển"),
                //           actions: [
                //             CupertinoDialogAction(
                //                 child: const Text("Xác nhận"),
                //                 onPressed: () {
                //                   context.router.pop();
                //                 })
                //           ],
                //         ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPaddingWidget.w,
                    vertical: defaultPaddingItem.h),
                child: Icon(
                  Ionicons.create_outline,
                  size: 23,
                  color: HexColor(secondaryColorLight),
                ),
              ),
            )
          ],
        ),
        controller.isLoadingUpdateThubnail.isTrue
            ? Container(
                width: double.infinity,
                height: 200.h,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              )
            : Container(
                width: double.infinity,
                height: 200.h,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadius.r),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            profile.getVendorThumnail ?? ""),
                        fit: BoxFit.cover)),
              ),
      ],
    ),
  );
}

Widget renderBrandname(
    BuildContext context, VendorProfileInformationController controller) {
  final profile = controller.account.value;

  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tên cơ sở dịch vụ: ".toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: HexColor(greyTextColor),
              ),
            ),
            InkWell(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return DialogTextField(
                        context: context,
                        controller: controller.brandNameController.value,
                        hint: "Nhập tên dịch vụ",
                        title: 'Sửa Tên dịch vụ',
                        minLines: 1,
                        confirmTitlel: "Cập nhật",
                        onConfirm: () {
                          controller.handleUpdateVendorProfile();
                          Navigator.pop(context);
                        },
                        onDismiss: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.w,
                        vertical: defaultPaddingItem.h),
                    child: Icon(
                      Ionicons.create_outline,
                      size: 23,
                      color: HexColor(secondaryColorLight),
                    )))
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
          child: Text(
            profile.vendorBrandname ?? '',
            style: titleStyle,
          ),
        )
      ],
    ),
  );
}

Widget renderDescription(
    BuildContext context, VendorProfileInformationController controller) {
  final profile = controller.account.value;
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                "Giới thiệu: ".toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  color: HexColor(greyTextColor),
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return DialogTextField(
                        context: context,
                        controller: controller.detailController.value,
                        hint: "Nhập mô tả dịch vụ",
                        title: 'Sửa mô tả dịch vụ',
                        minLines: 1,
                        confirmTitlel: "Cập nhật",
                        onConfirm: () {
                          controller.handleUpdateVendorProfile();
                          Navigator.pop(context);
                        },
                        onDismiss: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.w,
                        vertical: defaultPaddingItem.h),
                    child: Icon(
                      Ionicons.create_outline,
                      size: 23,
                      color: HexColor(secondaryColorLight),
                    )))
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
          child: Text(
            profile.vendor?.details ?? '',
            style:
                titleStyle.copyWith(fontWeight: FontWeight.w400, height: 1.4),
          ),
        )
      ],
    ),
  );
}

Widget renderAddress(
    BuildContext context, VendorProfileInformationController controller) {
  final profile = controller.account.value;

  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Địa chỉ: ".toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: HexColor(greyTextColor),
              ),
            ),
            InkWell(
                onTap: () {
                  context.router.push(VendorProfileAddressPage(
                      onBack: (double lat, double lng, bool isError) async {
                    if (isError == true) {
                      return;
                    } else {
                      debugPrint("lat $lat");
                      debugPrint("long $lng");
                    }
                  }));
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.w,
                        vertical: defaultPaddingItem.h),
                    child: Icon(
                      Ionicons.create_outline,
                      size: 23,
                      color: HexColor(secondaryColorLight),
                    )))
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
          child: Text(
            profile.vendorFullAddress ?? '',
            style:
                titleStyle.copyWith(fontWeight: FontWeight.w400, height: 1.4),
          ),
        )
      ],
    ),
  );
}
