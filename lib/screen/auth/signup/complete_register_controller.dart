import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/auth/signup_customer/complete_register_request.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/newfeed_controller.dart';
import 'package:client_tggt/screen/profile/profile_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteRegisterController extends GetxController {
  final String title = "update profile";
  final isCheckRules = true.obs;
  final step = 0.obs;
  final fullnameController = TextEditingController(text: "").obs;
  final isLoading = false.obs;
  final errorMessage = "".obs;

  final Rx<AccountModel> account = AccountModel().obs;

  CompleteRegisterController(this._apiClient);
  final ApiClient _apiClient;

  changeCheckRules(bool status) {
    isCheckRules.value = status;
  }

  handleUpdateUserInfo(AccountModel data) {
    account.value = data;
  }

  handleUpdateFullName() async {
    final request =
        CompleteRegisterRequest(fullName: fullnameController.value.text);
    try {
      isLoading.value = true;
      var data = await _apiClient.completeRegister(request);
      if (data.status == 200) {
        final profile = account.value.profile;
        final phone = account.value.phone;
        final type = account.value.type;
        final authentication = account.value.authentication;
        final blace = account.value.balance;
        fullnameController.value.text = "";

        final MainController mainController =
            Get.put(MainController(getIt.get<ApiClient>()));
        errorMessage.value = "";
        mainController.getAccountInfo(profile as Profile, phone as String,
            type as String, authentication as Authentication, blace);
        mainController.changeTabIndex(0);
        Get.delete<MainController>();
        Get.delete<ProfileController>();
        Get.delete<NewfeedController>();
        Get.find<RouterController>().push(SplashPage(isFristLoad: false));
      } else {
        errorMessage.value = data.message;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
