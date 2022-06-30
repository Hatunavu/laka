import 'dart:developer';
import 'dart:io' show Platform;

import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/model/auth/add_deceive_token_request.dart';
import 'package:client_tggt/model/auth/device_enum.dart';
import 'package:client_tggt/model/auth/signin_telephone_request.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/admin_page/admin_main/admin_main_controller.dart';
import 'package:client_tggt/screen/auth/signin/sigin_telephone_controller.dart';
import 'package:client_tggt/screen/home/home_controller.dart';

import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SigninVerifyController extends GetxController {
  final String title = "signin_verify";
  final phoneController = TextEditingController(text: "").obs;
  final isLoading = false.obs;
  final isFullCode = false.obs;
  final errorMessage = "".obs;
  final isLoad = false.obs;
  SigninVerifyController(this._apiClient);
  final ApiClient _apiClient;
  final box1Controller = TextEditingController(text: "").obs;
  final box2Controller = TextEditingController(text: "").obs;
  final box3Controller = TextEditingController(text: "").obs;
  final box4Controller = TextEditingController(text: "").obs;
  final List listEmptyBox = [].obs;
  final telephone = "".obs;
  handleUpdatePhone(String phone) {
    telephone.value = phone;
  }

  handleUpdateOtp() {
    if (isLoad.isTrue) {
      isLoad.value = false;
    } else {
      isLoad.value = true;
    }
  }

  handleVerify(BuildContext context) async {
    final verifyOtpString = box1Controller.value.text;

    final request =
        SigninTelephoneRequest(phone: telephone.value, code: verifyOtpString);
    try {
      isLoading.value = true;
      var response = await _apiClient.signInTelephone(request);
      if (response.status == 200) {
        final userSession = response.userSession;
        if (userSession != null) {
          final token = userSession.token;
          final userId = userSession.userId;
          final account = userSession.account;
          final type = account.type;
          await AccountServices().saveUserToken(token);
          await AccountServices().saveUserId(userId);

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
          // if (type == AccountType.vendor.getType()) {
          //   AccountServices().saveAccountType(AccountType.customer.getType());
          //   Get.delete<VendorMainController>();
          //   Get.delete<VendorProductController>();
          //   Get.delete<VendorBookingController>();
          //   Get.delete<VendorProfileController>();
          //   context.router.popUntilRoot();
          //   Get.find<RouterController>()
          //       .replace(SplashPage(isFristLoad: false));
          // } else if (type == "customer") {
          //   AccountServices().saveAccountType(AccountType.customer.getType());
          //   context.router.popUntilRoot();
          //   Get.find<RouterController>()
          //       .replace(SplashPage(isFristLoad: false));
          // }
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
            context.router.popUntilRoot();
            Get.find<RouterController>()
                .replace(SplashPage(isFristLoad: false));
          }
        }
      } else {
        errorMessage.value = "Mã xác thực không đúng.";
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }
}
