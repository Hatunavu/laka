import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/model/auth/forgot_password/forgot_password_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final String title = "forgot_password";
  final phoneController = TextEditingController(text: "").obs;
  final isLoading = false.obs;
  final isError = false.obs;
  final errorMessage = "".obs;
  final ApiClient _apiClient;
  ForgotPasswordController(this._apiClient);

  Future<bool> handleForgotPassword() async {
    if (phoneController.value.text == "") return false;

    final request = ForgotPasswordRequest(phone: phoneController.value.text);
    try {
      isLoading.value = true;
      isError.value = false;
      var response = await _apiClient.forgotPassword(request);
      if (response.status == 200) {
        return true;
      } else {
        isError.value = true;
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      phoneController.value.text = "";
      errorMessage.value = "";
      isLoading.value = false;
    }
  }
}
