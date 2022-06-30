// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/auth/add_deceive_token_request.dart';
import 'package:client_tggt/model/auth/device_enum.dart';
import 'package:client_tggt/model/auth/fcm_enum.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/notification/firebase_notification.dart';
import 'package:client_tggt/notification/notification_service.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/activity/activity_controller.dart';
import 'package:client_tggt/screen/activity/activity_screen.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/home/home_screen.dart';
import 'package:client_tggt/screen/message/newfeed_sceen.dart';
import 'package:client_tggt/screen/message/newfeed_detail_controller.dart';
import 'package:client_tggt/screen/profile/message/message_detail_controller.dart';
import 'package:client_tggt/screen/profile/profile_screen.dart';
import 'package:client_tggt/screen/rewards/rewards_screen.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class MainController extends GetxController {
  var tabIndex = 0;
  late PageController pageController;
  final userToken = AccountServices().getUserToken().obs;
  final isLoading = false.obs;
  final userId = AccountServices().getUserId().obs;
  final countPendingOrders = 0.obs;
  final countUnreadNotifications = 0.obs;
  final Rx<AccountModel> account = AccountModel().obs;
  final isRegisterfCM = false.obs;
  final isLogin = false.obs;
  final currentOrders = BookingItemModel(status: BookingStatus.pending).obs;
  final latitude = defaultLat.obs;
  final longitude = defaultLng.obs;
  final currentLocation = "Hà Nội".obs;
  final currentCityCode = "01".obs;

  MainController(this._apiClient);
  final ApiClient _apiClient;
  final notifyHelper =
      NotifyHelper(selectNotification: (String? payload) async {
    if (payload != null) {
      final splitPayload = payload.split("+");
      final notifType = splitPayload[0];
      final refId = splitPayload[1];
      final accountType = splitPayload[2];
      if (notifType == FcmType.Post.getType()) {
        await Get.delete<NewfeedDetailController>();
        Get.find<RouterController>()
            .push(NewfeedDetailPage(postId: refId, isFocus: false));
      } else if (notifType == FcmType.Comment.getType()) {
        await Get.delete<NewfeedDetailController>();
        Get.find<RouterController>()
            .push(NewfeedDetailPage(postId: refId, isFocus: false));
      } else if (notifType == FcmType.Order.getType()) {
        if (accountType == AccountType.customer.getType()) {
          await Get.delete<ActivityController>();
          Get.find<RouterController>()
              .push(ActivityDetailPage(id: refId, isFromQr: false));
        } else if (accountType == AccountType.vendor.getType()) {
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
    _addTimeAgoLocale();
    registerNotification(onActive, onInActive);
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    super.onInit();
  }

  void onActive(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    final data = message.data;
    final notifType = data["type"];
    final refId = data["refId"];
    final accountType = data["accountType"];
    if (notifType == FcmType.Post.getType()) {
      await Get.delete<NewfeedDetailController>();
      Get.find<RouterController>()
          .push(NewfeedDetailPage(postId: refId, isFocus: false));
    } else if (notifType == FcmType.Order.getType()) {
      if (accountType == AccountType.customer.getType()) {
        getDetailOrder(refId);
        await Get.delete<ActivityController>();
        Get.find<RouterController>()
            .push(ActivityDetailPage(id: refId, isFromQr: false));
      } else if (accountType == AccountType.vendor.getType()) {
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

  getDetailOrder(String id) async {
    try {
      isLoading.value = true;
      var response = await _apiClient.getDetailOrder(id);
      if (response.status == 200) {
        if (response.data != null) {
          final data = response.data!;
          if (data.status == BookingStatus.canceled) {
            currentOrders.value =
                BookingItemModel(status: BookingStatus.pending);
          } else if (data.status == BookingStatus.completed) {
            currentOrders.value =
                BookingItemModel(status: BookingStatus.pending);
          } else if (data.status == BookingStatus.reviewed) {
            currentOrders.value =
                BookingItemModel(status: BookingStatus.pending);
          } else {
            currentOrders.value = data;
          }
        }
      } else {}
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }

  void onInActive(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    final data = message.data;

    if (data["type"] == FcmType.Order.getType()) {
      if (data["accountType"] == AccountType.customer.getType()) {
        getDetailOrder(data["refId"]);
      }
    }
    notifyHelper.displayNotification(
        body: notification!.body ?? "",
        title: notification.title ?? "",
        payload: '${data["type"]}+${data["refId"]}+${data["accountType"]}');
  }

  addDeceiveToken() async {
    final notificationToken = AccountServices().getNotificationToken();
    final deceiveType = Platform.isIOS
        ? DeviceType.ios.display()
        : DeviceType.android.display();

    final request = AddDeceiveTokenRequest(
        deviceToken: notificationToken, deviceType: deceiveType);
    try {
      final response = await _apiClient.updateDeceiveToken(request);
      if (response.status == 200) {
        log("update token success");
      } else {
        log("update token failed");
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {}
  }

  handleUpdatePendingOrder(int count) {
    countPendingOrders.value = count;
  }

  handleUpdateUnreadNotification(int count) {
    countUnreadNotifications.value = count;
  }

  handleUpdateListOrder(BookingItemModel orders) {
    currentOrders.value = orders;
  }

  handleUpdateLocation(String lat, String lng) {
    latitude.value = lat;
    longitude.value = lng;
  }

  handleUpdateCurrentLocation(String text) {
    currentLocation.value = text;
  }

  handleUpdateCityCode(String code) {
    currentCityCode.value = code;
  }

  getAccountInfo(Profile profile, String phone, String type,
      Authentication authentication, Balance? balance) {
    isLogin.value = true;
    account.value = AccountModel(
        profile: profile,
        phone: phone,
        type: type,
        authentication: authentication,
        balance: balance);
  }

  updateAccountInfo(AccountModel data) {
    isLogin.value = true;
    account.value = data;
  }

  handleUpdateCurrentOrder(BookingItemModel item) {
    currentOrders.value = item;
    countPendingOrders.value = countPendingOrders.value + 1;
  }

  handleCancelCurrentOrder() {
    currentOrders.value = BookingItemModel(status: BookingStatus.pending);
    countPendingOrders.value = countPendingOrders.value - 1;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  handleUpdateCountUnreadNotification(int count) {
    if (count <= countUnreadNotifications.value) {
      countUnreadNotifications.value = countUnreadNotifications.value - count;
    }
  }

  handleLoggedSuccess(String token, String id) {
    userToken.value = token;
    userId.value = id;
  }

  handleLogoutAccount() async {
    final getToken = AccountServices().getUserToken();
    if (getToken != "" || getToken != null) {
      try {
        var data = await _apiClient.logoutAccount();
        if (data.status == 200 || data.status == 401) {
          AccountServices().saveUserToken("");
          AccountServices().saveUserId("");
          AccountServices().saveAccountType("");
          // AccountServices().saveNotificationToken("");
          userToken.value = "";
          countPendingOrders.value = 0;
          countUnreadNotifications.value = 0;
          account.value = AccountModel();
          isLogin.value = false;
          currentOrders.value = BookingItemModel(status: BookingStatus.pending);
          getIt.get<IToast>().show(
              title: 'logOutSuccess'.tr,
              message: 'logOutSuccess'.tr,
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1000));
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        changeTabIndex(0);
      }
    } else {
      AccountServices().saveUserToken("");
      AccountServices().saveUserId("");
      AccountServices().saveAccountType("");
      userToken.value = "";
    }
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  final List<Widget> _screenList = [
    HomeScreen(),
    ActivityScreen(),
    const NewfeedScreen(),
    RewardsScreen(),
    const ProfileScreen()
  ];

  getScreen() => _screenList[tabIndex];

  _addTimeAgoLocale() {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());
    timeago.setLocaleMessages('az', timeago.AzMessages());
    timeago.setLocaleMessages('az_short', timeago.AzShortMessages());
    timeago.setLocaleMessages('ca', timeago.CaMessages());
    timeago.setLocaleMessages('ca_short', timeago.CaShortMessages());
    timeago.setLocaleMessages('cs', timeago.CsMessages());
    timeago.setLocaleMessages('cs_short', timeago.CsShortMessages());
    timeago.setLocaleMessages('da', timeago.DaMessages());
    timeago.setLocaleMessages('da_short', timeago.DaShortMessages());
    timeago.setLocaleMessages('de', timeago.DeMessages());
    timeago.setLocaleMessages('de_short', timeago.DeShortMessages());
    timeago.setLocaleMessages('dv', timeago.DvMessages());
    timeago.setLocaleMessages('dv_short', timeago.DvShortMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
    timeago.setLocaleMessages('es', timeago.EsMessages());
    timeago.setLocaleMessages('es_short', timeago.EsShortMessages());
    timeago.setLocaleMessages('fa', timeago.FaMessages());
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    timeago.setLocaleMessages('fr_short', timeago.FrShortMessages());
    timeago.setLocaleMessages('gr', timeago.GrMessages());
    timeago.setLocaleMessages('gr_short', timeago.GrShortMessages());
    timeago.setLocaleMessages('he', timeago.HeMessages());
    timeago.setLocaleMessages('he_short', timeago.HeShortMessages());
    timeago.setLocaleMessages('he', timeago.HeMessages());
    timeago.setLocaleMessages('he_short', timeago.HeShortMessages());
    timeago.setLocaleMessages('hi', timeago.HiMessages());
    timeago.setLocaleMessages('hi_short', timeago.HiShortMessages());
    timeago.setLocaleMessages('id', timeago.IdMessages());
    timeago.setLocaleMessages('it', timeago.ItMessages());
    timeago.setLocaleMessages('it_short', timeago.ItShortMessages());
    timeago.setLocaleMessages('ja', timeago.JaMessages());
    timeago.setLocaleMessages('km', timeago.KmMessages());
    timeago.setLocaleMessages('km_short', timeago.KmShortMessages());
    timeago.setLocaleMessages('ko', timeago.KoMessages());
    timeago.setLocaleMessages('ku', timeago.KuMessages());
    timeago.setLocaleMessages('ku_short', timeago.KuShortMessages());
    timeago.setLocaleMessages('mn', timeago.MnMessages());
    timeago.setLocaleMessages('mn_short', timeago.MnShortMessages());
    timeago.setLocaleMessages('ms_MY', timeago.MsMyMessages());
    timeago.setLocaleMessages('ms_MY_short', timeago.MsMyShortMessages());
    timeago.setLocaleMessages('nb_NO', timeago.NbNoMessages());
    timeago.setLocaleMessages('nb_NO_short', timeago.NbNoShortMessages());
    timeago.setLocaleMessages('nl', timeago.NlMessages());
    timeago.setLocaleMessages('nl_short', timeago.NlShortMessages());
    timeago.setLocaleMessages('nn_NO', timeago.NnNoMessages());
    timeago.setLocaleMessages('nn_NO_short', timeago.NnNoShortMessages());
    timeago.setLocaleMessages('pl', timeago.PlMessages());
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
    timeago.setLocaleMessages('pt_BR_short', timeago.PtBrShortMessages());
    timeago.setLocaleMessages('ro', timeago.RoMessages());
    timeago.setLocaleMessages('ro_short', timeago.RoShortMessages());
    timeago.setLocaleMessages('ru', timeago.RuMessages());
    timeago.setLocaleMessages('ru_short', timeago.RuShortMessages());
    timeago.setLocaleMessages('rw', timeago.RwMessages());
    timeago.setLocaleMessages('rw_short', timeago.RwShortMessages());
    timeago.setLocaleMessages('sv', timeago.SvMessages());
    timeago.setLocaleMessages('sv_short', timeago.SvShortMessages());
    timeago.setLocaleMessages('ta', timeago.TaMessages());
    timeago.setLocaleMessages('th', timeago.ThMessages());
    timeago.setLocaleMessages('th_short', timeago.ThShortMessages());
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    timeago.setLocaleMessages('uk', timeago.UkMessages());
    timeago.setLocaleMessages('uk_short', timeago.UkShortMessages());
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
    timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());
    timeago.setLocaleMessages('zh', timeago.ZhMessages());
  }
}
