import 'dart:developer';
import 'dart:io' show Platform;

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/auth/add_deceive_token_request.dart';
import 'package:client_tggt/model/auth/device_enum.dart';
import 'package:client_tggt/model/auth/signin_request.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/admin_page/admin_main/admin_main_controller.dart';
import 'package:client_tggt/screen/auth/signin/sigin_telephone_controller.dart';
import 'package:client_tggt/screen/auth/signin/signin_verify_controller.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/newfeed_controller.dart';
import 'package:client_tggt/screen/profile/profile_controller.dart';
import 'package:client_tggt/screen/vendors/booking/vendor_booking_controller.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:client_tggt/screen/vendors/product/vendor_product_controller.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_profile_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final String title = "signin";
  final phoneController = TextEditingController(text: "").obs;
  final passwordController = TextEditingController(text: "").obs;
  final isLoading = false.obs;
  final errorMessage = "".obs;
  SigninController(this._apiClient);
  final ApiClient _apiClient;

  handleSignIn() async {
    var phoneNumber = phoneController.value.text;
    var password = passwordController.value.text;
    final request = SigninRequest(phone: phoneNumber, password: password);
    try {
      EasyLoading.show(status: 'loading...');
      isLoading.value = true;
      var response = await _apiClient.login(request);
      if (response.status == 200) {
        final userSession = response.userSession;
        if (userSession != null) {
          final token = userSession.token;
          final userId = userSession.userId;
          final account = userSession.account;
          final type = account.type;
          // final id = account.id;
          await AccountServices().saveUserToken(token);
          AccountServices().saveUserId(userId);
          AccountServices()
              .saveAccountType(type ?? AccountType.customer.getType());

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

          errorMessage.value = "";
          phoneController.value.text = "";
          passwordController.value.text = "";
          if (type == "admin") {
            AccountServices().saveLanguageCode("vi");
            if (ThemeServices().isDarkMode) {
              ThemeServices().switchTheme();
            }
            AccountServices().saveAccountType("admin");
            Get.delete<AdminMainController>();
            Get.delete<SigninVerifyController>();
            Get.delete<SigninTelephoneController>();
            Get.delete<HomeController>();
            Get.find<RouterController>()
                .replace(SplashPage(isFristLoad: false));
          } else {
            AccountServices().saveAccountType(AccountType.customer.getType());
            Get.delete<SigninVerifyController>();
            Get.delete<SigninTelephoneController>();
            Get.delete<HomeController>();
            Get.find<RouterController>()
                .replace(SplashPage(isFristLoad: false));
          }

          // if (type == AccountType.vendor.display()) {
          //   Get.delete<VendorMainController>();
          //   Get.delete<VendorProductController>();
          //   Get.delete<VendorBookingController>();
          //   Get.delete<VendorProfileController>();
          //   AccountServices().saveLanguageCode("vi");
          //   if (ThemeServices().isDarkMode) {
          //     ThemeServices().switchTheme();
          //   }
          //   Get.find<RouterController>().popUtilRoot();
          //   Get.find<RouterController>()
          //       .replace(SplashPage(isFristLoad: false));
          // } else if (type == AccountType.customer.getType()) {
          //   final MainController mainController =
          //       Get.put(MainController(getIt.get<ApiClient>()));
          //   await mainController.handleLoggedSuccess(token, userId);
          //   mainController.changeTabIndex(0);
          //   Get.delete<MainController>();
          //   Get.delete<HomeController>();
          //   Get.delete<ProfileController>();
          //   Get.delete<NewfeedController>();
          //   Get.find<RouterController>().popUtilRoot();
          //   Get.find<RouterController>()
          //       .replace(SplashPage(isFristLoad: false));
          // } else if (type == "admin") {
          //   AccountServices().saveLanguageCode("vi");
          //   if (ThemeServices().isDarkMode) {
          //     ThemeServices().switchTheme();
          //   }
          //   AccountServices().saveAccountType("admin");
          //   Get.delete<AdminMainController>();
          //   Get.delete<SigninVerifyController>();
          //   Get.delete<SigninTelephoneController>();
          //   Get.delete<HomeController>();
          //   Get.find<RouterController>()
          //       .replace(SplashPage(isFristLoad: false));
          // }
        }
      } else {
        if (response.status == 401 || response.status == 400) {
          errorMessage.value = "Sai tên đăng nhập hoặc mật khẩu";
          phoneController.value.text = "";
          passwordController.value.text = "";
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
      Get.delete<ProfileController>();
      Get.delete<HomeController>();
      Get.delete<MainController>();
      EasyLoading.dismiss();
    }
  }
}
