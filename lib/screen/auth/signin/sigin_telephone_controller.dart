import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/model/auth/signin_checkphone_request.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SigninTelephoneController extends GetxController {
  final String title = "signintelephone";
  final phoneController = TextEditingController(text: "").obs;
  final isLoading = false.obs;
  final isError = false.obs;
  final errorMessage = "".obs;
  SigninTelephoneController(this._apiClient);
  final ApiClient _apiClient;

  handleCheckTelephone() async {
    if (phoneController.value.text == "") return;

    final request = SigninCheckPhoneRequest(phone: phoneController.value.text);
    try {
      isLoading.value = true;
      isError.value = false;
      var response = await _apiClient.signInCheckPhone(request);
      if (response.status == 200) {
        Get.find<RouterController>()
            .push(SignInVerifyPage(telePhone: phoneController.value.text));
      } else {
        isError.value = true;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      phoneController.value.text = "";
      errorMessage.value = "";
      isLoading.value = false;
    }
  }
}
