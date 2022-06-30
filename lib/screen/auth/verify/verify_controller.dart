import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/auth/verify_request.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/admin_page/admin_main/admin_main_controller.dart';
import 'package:client_tggt/screen/auth/signin/sigin_telephone_controller.dart';
import 'package:client_tggt/screen/auth/signin/signin_verify_controller.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController {
  final String title = "verify";
  final List listEmptyBox = [].obs;
  final isLoading = false.obs;
  final ApiClient _apiClient;
  final telephone = "".obs;
  final errorMessage = "".obs;
  final box1Controller = TextEditingController(text: "").obs;
  final box2Controller = TextEditingController(text: "").obs;
  final box3Controller = TextEditingController(text: "").obs;
  final box4Controller = TextEditingController(text: "").obs;
  final isLoad = false.obs;

  final Rx<AccountModel> userInfo = AccountModel().obs;

  VerifyController(this._apiClient);

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

  Future<bool> handleVerify() async {
    final verifyOtpString = box1Controller.value.text;
    final referralBy = AccountServices().getReferralId();

    final request =
        VerifyRequest(phone: telephone.value, code: verifyOtpString);
    try {
      isLoading.value = true;
      var response = await _apiClient.postVerifyOpt(request);
      if (response.status == 200) {
        final userSession = response.userSession;
        if (userSession != null) {
          final token = userSession.token;
          final userId = userSession.userId;
          userInfo.value = userSession.account;
          final account = userSession.account;
          final profile = account.profile;
          final phone = account.phone;
          final type = account.type;
          final authentication = account.authentication;
          final blace = account.balance;

          final MainController mainController =
              Get.put(MainController(getIt.get<ApiClient>()));
          errorMessage.value = "";
          mainController.getAccountInfo(profile as Profile, phone as String,
              type as String, authentication as Authentication, blace);
          mainController.changeTabIndex(0);
          AccountServices().saveUserToken(token);
          AccountServices().saveUserId(userId);
          AccountServices().saveAccountType(AccountType.customer.display());
          Get.delete<AdminMainController>();
          Get.delete<SigninVerifyController>();
          Get.delete<SigninTelephoneController>();
          Get.delete<HomeController>();
          Get.find<RouterController>().replace(SplashPage(isFristLoad: false));
        }
        return false;
      } else {
        errorMessage.value = "Mã xác thực không đúng.";
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
