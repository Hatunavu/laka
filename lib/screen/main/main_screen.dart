import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/api/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:new_version/new_version.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    this.account,
    this.countPendingOrders,
    this.countUnreadNotifications,
    this.currentOrders,
  }) : super(key: key);
  final AccountModel? account;
  final int? countPendingOrders;
  final int? countUnreadNotifications;
  final BookingItemModel? currentOrders;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MainController mainController =
      Get.put(MainController(getIt.get<ApiClient>()));
  final _apiClient = getIt.get<ApiClient>();
  @override
  void initState() {
    if (widget.account != null) {
      mainController.handleUpdatePendingOrder(widget.countPendingOrders ?? 0);
      mainController
          .handleUpdateUnreadNotification(widget.countUnreadNotifications ?? 0);
      final account = widget.account;
      if (widget.currentOrders != null) {
        mainController.handleUpdateListOrder(widget.currentOrders!);
      }
      mainController.updateAccountInfo(account!);
    }
    super.initState();
    checkVersion();
  }

  checkVersion() async {
    try {
      final response = await _apiClient.getAppVersion();
      if (response.status == 200) {
        final data = response.data;
        if (data == null) return;
        final iosVersion = data.iosVersion;
        final androidVersion = data.androidVersion;
        if (GetPlatform.isIOS) {
          if (iosVersion != ApiConstants.iosVersion) {
            handleCheckVersion();
          }
        }
        if (GetPlatform.isAndroid) {
          if (androidVersion != ApiConstants.androidVersion) {
            handleCheckVersion();
          }
        }
      }
    } on Exception catch (err) {
      log("err $err");
      return null;
    }
  }

  handleCheckVersion() async {
    final newVersion = NewVersion(
        androidId: "vn.com.laka.mobile", iOSId: "vn.com.laka.mobile");
    final status = await newVersion.getVersionStatus();
    if (status == null) return;
    return newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: "notification".tr,
        dialogText: "lakaUpdate".tr,
        dismissButtonText: "skip".tr,
        updateButtonText: "update".tr,
        dismissAction: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: controller.getScreen(),
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 12,
              unselectedFontSize: 12,
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor:
                  Theme.of(context).colorScheme.secondaryVariant,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 8.h, top: 2.h),
                    child: Icon(
                      Ionicons.home_outline,
                      size: 23.sp,
                    ),
                  ),
                  label: "homePage".tr,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                      padding: EdgeInsets.only(bottom: 8.h, top: 2.h),
                      child: Obx(
                        () => controller.countPendingOrders.value > 0
                            ? Badge(
                                badgeColor: Theme.of(context).primaryColor,
                                badgeContent: Text(
                                  '${controller.countPendingOrders.value}',
                                  style: AppTextStyle()
                                      .eyebrowRegular10
                                      .copyWith(
                                          color: Theme.of(context)
                                              .backgroundColor),
                                ),
                                position:
                                    BadgePosition.topEnd(top: -5, end: -7),
                                animationType: BadgeAnimationType.scale,
                                animationDuration:
                                    const Duration(milliseconds: 100),
                                child: Icon(
                                  Ionicons.heart_outline,
                                  size: 23.sp,
                                ),
                              )
                            : Icon(
                                Ionicons.heart_outline,
                                size: 23.sp,
                              ),
                      )),
                  label: 'activity'.tr,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 8.h, top: 2.h),
                    child: Icon(
                      Ionicons.reader_outline,
                      size: 23.sp,
                    ),
                  ),
                  label: 'newfeed'.tr,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 8.h, top: 2.h),
                    child: Icon(
                      Ionicons.ribbon_outline,
                      size: 23.sp,
                    ),
                  ),
                  label: 'rewards'.tr,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 8.h, top: 2.h),
                    child: Icon(
                      Ionicons.person_circle_outline,
                      size: 23.sp,
                    ),
                  ),
                  label: 'account'.tr,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
