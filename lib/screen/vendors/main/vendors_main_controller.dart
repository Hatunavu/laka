import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/model/auth/fcm_enum.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/notification/firebase_notification.dart';
import 'package:client_tggt/notification/notification_service.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/profile/message/message_detail_controller.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_controller.dart';
import 'package:client_tggt/screen/vendors/booking/vendor_booking_screen.dart';
import 'package:client_tggt/screen/vendors/home/vendor_home_screen.dart';
import 'package:client_tggt/screen/vendors/message/vendor_massage_screen.dart';
import 'package:client_tggt/screen/vendors/product/vendor_product_screen.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_profile_screen.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorMainController extends GetxController {
  final isLoading = false.obs;
  var tabIndex = 0;
  late PageController pageController;
  // final Rx<VendorModel> account = VendorModel().obs;
  // final Rx<AccountModel> account = AccountModel().obs;
  // final Rx<VendorModel> account = VendorModel(
  //         brandName: "",
  //         address:
  //             VendorAddressModel(fullAddress: "", location: VendorLocaltion()),
  //         category: CategoryType.bar)
  //     .obs;

  final account = VendorInfoModel().obs;

  VendorMainController(this._apiClient);

  final userToken = AccountServices().getUserToken().obs;
  final userId = AccountServices().getUserId().obs;
  final ApiClient _apiClient;
  final notifyHelper =
      NotifyHelper(selectNotification: (String? payload) async {
    if (payload != null) {
      final splitPayload = payload.split("+");
      final notifType = splitPayload[0];
      final refId = splitPayload[1];
      final accountType = splitPayload[2];
      if (notifType == FcmType.Order.getType()) {
        if (accountType == AccountType.vendor.getType()) {
          await Get.delete<BookingDetailController>();
          Get.find<RouterController>().push(BookingDetailPage(
            bookingId: refId,
            parentPage: "booking_list",
          ));
        }
      } else if (notifType == FcmType.Chat.getType()) {
        await Get.delete<MessageDetailController>();
        Get.find<RouterController>()
            .push(MessageDetailPage(roomId: refId, vendorId: ""));
      }
    } else {
      log("Notification Done");
    }
  });
  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    getMe();

    super.onInit();
  }

  @override
  void onReady() {
    registerNotification(onActive, onInActive);
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    super.onReady();
  }

  void onActive(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    final data = message.data;
    final notifType = data["type"];
    final refId = data["refId"];
    final accountType = data["accountType"];
    if (notifType == FcmType.Order.getType()) {
      if (accountType == AccountType.vendor.getType()) {
        await Get.delete<BookingDetailController>();
        Get.find<RouterController>().push(BookingDetailPage(
          bookingId: refId,
          parentPage: "booking_list",
        ));
      }
    } else if (notifType == FcmType.Chat.getType()) {
      await Get.delete<MessageDetailController>();
      Get.find<RouterController>()
          .push(MessageDetailPage(roomId: refId, vendorId: ""));
    }
  }

  void onInActive(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    final data = message.data;
    notifyHelper.displayNotification(
        body: notification!.body ?? "",
        title: notification.title ?? "",
        payload: '${data["type"]}+${data["refId"]}+${data["accountType"]}');
  }

  // getAccountInfo(Profile profile, String phone, String type, String id,
  //     Authentication authentication, GenderType gender) {
  //   final accountInfo = AccountModel(
  //     profile: profile,
  //     phone: phone,
  //     type: type,
  //     id: id,
  //     authentication: authentication,
  //   );
  //   account.value = accountInfo;
  // }

  handleLogoutAccount() async {
    final getToken = AccountServices().getUserToken();
    if (getToken != "") {
      try {
        var data = await _apiClient.logoutAccount();
        if (data.status == 200) {
          AccountServices().saveUserToken("");
          AccountServices().saveUserId("");
          AccountServices().saveAccountType("");
          // AccountServices().saveNotificationToken("");
          userToken.value = "";
        } else if (data.status == 401) {
          AccountServices().saveUserToken("");
          AccountServices().saveUserId("");
          AccountServices().saveAccountType("");
          userToken.value = "";
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {}
    } else {
      AccountServices().saveUserToken("");
      AccountServices().saveUserId("");
      AccountServices().saveAccountType("");
      userToken.value = "";
    }
  }

  // getMyProfile
  getMe() async {
    try {
      isLoading(true);

      var data = await _apiClient.getVendorInfor();
      if (data.status == 200) {
        final accountData = data.data!.account!;
        account.value = accountData;
      } else if (data.status == 401) {
        handleLogoutAccount();
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    // _socket.dispose();
    pageController.dispose();
    super.onClose();
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  final List<Widget> _screenList = [
    const VendorHomeScreen(),
    VendorBookingScreen(),
    const VendorProductScreen(),
    const VendorMessageScreen(),
    const VendorProfileScreen()
  ];

  getScreen() => _screenList[tabIndex];
  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
