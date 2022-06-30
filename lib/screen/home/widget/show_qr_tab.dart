import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';

class ShowQrTab extends StatefulWidget {
  ShowQrTab({Key? key}) : super(key: key);

  @override
  State<ShowQrTab> createState() => _ShowQrTabState();
}

class _ShowQrTabState extends State<ShowQrTab> {
  final MainController mainController = Get.find();
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
        decoration: BoxDecoration(
            color: ThemeServices().isDarkMode
                ? kColorPrimaryDark
                : kColorPrimaryLight),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingWidget.w,
              vertical: kDefaultPaddingItem.h),
          decoration: BoxDecoration(
              color: ThemeServices().isDarkMode
                  ? kColorPrimaryDark
                  : kColorPrimaryLight),
          child: Center(
              child: ClipRect(
                  child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: kDefaultPaddingWidget.h,
                  horizontal: kDefaultPaddingWidget.w * 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius.r),
                  color: ThemeServices().isDarkMode
                      ? Colors.grey.shade600.withOpacity(0.2)
                      : Colors.grey.shade200.withOpacity(0.2)),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Đưa bạn bè quyét mã này để tải và dùng ứng dụng Laka",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        height: 1.5),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Stack(
                      children: [
                        QrImage(
                          data: mainController.account.value.affiliate?.link ??
                              "",
                          version: QrVersions.auto,
                          // embeddedImage: CachedNetworkImageProvider(
                          //     account.urlUserAvatar ?? ""),
                          // embeddedImageStyle: QrEmbeddedImageStyle(
                          //     size: ui.Size(36.w, 36.w)),
                          size: MediaQuery.of(context).size.width * 0.5,
                        ),
                        Positioned(
                            top: (MediaQuery.of(context).size.width * 0.5 / 2) -
                                26,
                            left:
                                (MediaQuery.of(context).size.width * 0.5 / 2) -
                                    26,
                            child: CachedNetworkImage(
                              imageUrl:
                                  mainController.account.value.urlUserAvatar ??
                                      "",
                              memCacheHeight: 200,
                              imageBuilder: (context, image) => CircleAvatar(
                                backgroundImage: image,
                                radius: 23,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Mã giới thiệu của bạn",
                            style:
                                TextStyle(fontSize: 13.sp, color: Colors.white),
                          ),
                          SizedBox(
                            height: kDefaultPaddingItem.h,
                          ),
                          Text(
                            mainController.account.value.affiliate!.key ?? "",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          screenshotController
                              .capture(delay: const Duration(milliseconds: 10))
                              .then((capturedImage) async {
                            Map<Permission, PermissionStatus> statuses = await [
                              Permission.storage,
                            ].request();
                            final info =
                                statuses[Permission.storage].toString();
                            var status = await Permission.storage.status;

                            if (status.isGranted) {
                              if (capturedImage != null) {
                                await ImageGallerySaver.saveImage(capturedImage,
                                    name: "hello");
                                Clipboard.setData(ClipboardData(
                                    text: mainController
                                        .account.value.affiliate?.link));
                                EasyLoading.showSuccess('saved'.tr);
                                Future.delayed(const Duration(seconds: 1), () {
                                  EasyLoading.dismiss();
                                });
                              }
                            } else if (status.isDenied) {
                              return;
                            }
                          }).catchError((onError) {
                            print(onError);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPaddingWidget.w + 5.w,
                              vertical: 3.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 3.h),
                                child: Icon(
                                  Ionicons.download_outline,
                                  color: ThemeServices().isDarkMode
                                      ? kColorPrimaryDark
                                      : kColorPrimaryLight,
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPaddingItem.w,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  "LƯU QR",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: ThemeServices().isDarkMode
                                          ? kColorPrimaryDark
                                          : kColorPrimaryLight,
                                      fontSize: 13.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Share.share(
                              mainController.account.value.affiliate!.link ??
                                  "",
                              subject:
                                  mainController.account.value.affiliate!.link);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPaddingWidget.w + 5.w,
                              vertical: 3.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 3.h),
                                child: Icon(
                                  Ionicons.share_outline,
                                  color: ThemeServices().isDarkMode
                                      ? kColorPrimaryDark
                                      : kColorPrimaryLight,
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPaddingItem.w,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  "CHIA SẺ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: ThemeServices().isDarkMode
                                          ? kColorPrimaryDark
                                          : kColorPrimaryLight,
                                      fontSize: 13.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )),
            ),
          ))),
        ),
      ),
    );
  }
}
