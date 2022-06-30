// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/profile/affiliate/affiliate_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class AffiliateScreen extends StatelessWidget {
  const AffiliateScreen({Key? key, required this.account}) : super(key: key);
  final AccountModel account;
  @override
  Widget build(BuildContext context) {
    GlobalKey _globalKey = GlobalKey();

    final AffiliateController controller =
        Get.put(AffiliateController(getIt.get<ApiClient>()));
    return RepaintBoundary(
      key: _globalKey,
      child: Screenshot(
        controller: controller.screenshotController,
        child: Scaffold(
          backgroundColor: ThemeServices().isDarkMode
              ? kColorBackgroundDark
              : kColorPrimaryLight,
          body: SafeArea(
            bottom: false,
            child: Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: ThemeServices().isDarkMode
                      ? kColorBackgroundDark
                      : kColorPrimaryLight),
              child: Column(
                children: [
                  renderHeader(context, controller),
                  Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPaddingWidget.w,
                            vertical: kDefaultPaddingItem.h),
                        child: Center(
                            child: ClipRect(
                                child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: kDefaultPaddingWidget.h,
                                horizontal: kDefaultPaddingWidget.w * 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    defaultBorderRadius.r),
                                color: Colors.grey.shade200.withOpacity(0.2)),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "getFriendScan".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      height: 1.5),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.h, horizontal: 8.w),
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: Stack(
                                    children: [
                                      QrImage(
                                        data: account.affiliate?.link ?? "",
                                        version: QrVersions.auto,
                                        // embeddedImage: CachedNetworkImageProvider(
                                        //     account.urlUserAvatar ?? ""),
                                        // embeddedImageStyle: QrEmbeddedImageStyle(
                                        //     size: ui.Size(36.w, 36.w)),
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                      ),
                                      Positioned(
                                          top: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5 /
                                                  2) -
                                              26,
                                          left: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5 /
                                                  2) -
                                              26,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                account.urlUserAvatar ?? "",
                                            memCacheHeight: 600,
                                            imageBuilder: (context, image) =>
                                                CircleAvatar(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "yourReferralCode".tr,
                                          style: TextStyle(
                                              fontSize: 13.sp,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: kDefaultPaddingItem.h,
                                        ),
                                        Text(
                                          account.affiliate!.key ?? "",
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ]),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        controller.screenshotController
                                            .capture(
                                                delay:
                                                    Duration(milliseconds: 10))
                                            .then((capturedImage) async {
                                          Map<Permission, PermissionStatus>
                                              statuses = await [
                                            Permission.storage,
                                          ].request();
                                          final info =
                                              statuses[Permission.storage]
                                                  .toString();
                                          var status =
                                              await Permission.storage.status;

                                          if (status.isGranted) {
                                            if (capturedImage != null) {
                                              await ImageGallerySaver.saveImage(
                                                  capturedImage,
                                                  name: "hello");
                                              Clipboard.setData(ClipboardData(
                                                  text:
                                                      account.affiliate?.link));
                                              EasyLoading.showSuccess(
                                                  'saved'.tr);
                                              Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
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
                                            horizontal:
                                                kDefaultPaddingWidget.w + 5.w,
                                            vertical: 3.h),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6.r)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3.h),
                                              child: Icon(
                                                Ionicons.download_outline,
                                                color:
                                                    ThemeServices().isDarkMode
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
                                                "saveQr".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: ThemeServices()
                                                            .isDarkMode
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
                                            account.affiliate!.link ?? "",
                                            subject: account.affiliate!.link);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                kDefaultPaddingWidget.w + 5.w,
                                            vertical: 3.h),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6.r)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 3.h),
                                              child: Icon(
                                                Ionicons.share_outline,
                                                color:
                                                    ThemeServices().isDarkMode
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
                                                "share".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: ThemeServices()
                                                            .isDarkMode
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
                      )),
                  Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ThemeServices().isDarkMode
                                    ? AppPath.affiliateDark
                                    : AppPath.affiliateLight),
                                fit: BoxFit.cover)),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget renderHeader(BuildContext context, AffiliateController controller) {
  return Obx(() => Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
        margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 3.h),
              child: IconButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  icon: Icon(
                    Ionicons.chevron_back_outline,
                    size: 22.sp,
                    color: Colors.white,
                  )),
            ),
            Text("inviteFriends".tr,
                style: titleStyle.copyWith(color: Colors.white)),
            controller.isLoading.isTrue
                ? Container(
                    alignment: Alignment.center,
                    child: SizedBox(
                      child: Lottie.asset(AppPath.appLoading,
                          frameRate: FrameRate.max),
                      height: 30.h,
                      width: 50.w,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingScreen.w),
                    alignment: Alignment.centerRight,
                    width: 100.w,
                    child: GestureDetector(
                      onTap: () {
                        context.router.push(AffiliateHistoryPage(
                            firstLevel: controller.firstLevel,
                            secondLevel: controller.secondLevel));
                      },
                      child: Text("history".tr,
                          style: subTitleStyle.copyWith(color: Colors.white)),
                    ),
                  )
          ],
        ),
      ));
}

Widget renderAffiliateLink(BuildContext context, AccountModel account) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    margin: EdgeInsets.only(top: kDefaultPaddingWidget.h * 1.2),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("linkInviteFriends".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: ThemeServices().isDarkMode
                          ? kColorGreyDark
                          : Colors.black87)),
              SizedBox(
                height: kDefaultPaddingItem.h,
              ),
              Container(
                padding: EdgeInsets.zero,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              bottomLeft: Radius.circular(8.r))),
                      padding: EdgeInsets.symmetric(
                          vertical: defaultPaddingItem.h,
                          horizontal: defaultPaddingItem.w),
                      child: Text(
                        account.affiliate?.link ?? "",
                        style: TextStyle(fontSize: 12.sp),
                        maxLines: 1,
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: account.affiliate?.link));
                        EasyLoading.showSuccess('copied'.tr);
                        Future.delayed(const Duration(seconds: 1), () {
                          EasyLoading.dismiss();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kColorPrimaryLight,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r))),
                        padding: EdgeInsets.symmetric(
                            vertical: defaultPaddingItem.h,
                            horizontal: defaultPaddingItem.w),
                        child: Text(
                          "copy".tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Future<dynamic> ShowCapturedWidget(
    BuildContext context, Uint8List capturedImage) {
  return showDialog(
    useSafeArea: false,
    context: context,
    builder: (context) => Scaffold(
      appBar: AppBar(
        title: const Text("Captured widget screenshot"),
      ),
      body: Center(
          child: capturedImage != null
              ? Image.memory(capturedImage)
              : Container()),
    ),
  );
}
