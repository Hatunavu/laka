import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/auth/forgot_password/forgot_password_request.dart';
import 'package:client_tggt/model/auth/forgot_password/verify/forgot_password_verify_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordVerifyController extends GetxController {
  final String title = "forgot_password";
  final box1Controller = TextEditingController(text: "").obs;
  final isLoading = false.obs;
  final isError = false.obs;
  final isFullCode = false.obs;
  final errorMessage = "".obs;
  final telephone = "".obs;
  final isLoad = false.obs;
  final ApiClient _apiClient;
  final token = "".obs;
  ForgotPasswordVerifyController(this._apiClient);

  handleUpadatePhone(String phone) {
    telephone.value = phone;
  }

  Future<bool> handleVerify() async {
    if (box1Controller.value.text == "") return false;

    final request = ForgotPasswordVerifyRequest(
        phone: telephone.value, code: box1Controller.value.text);
    try {
      isLoading.value = true;
      isError.value = false;
      var response = await _apiClient.verifyForgotPassword(request);
      if (response.status == 200) {
        token.value = response.data!.token;
        return true;
      } else {
        isError.value = true;
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      box1Controller.value.text = "";
      errorMessage.value = "";
      isLoading.value = false;
    }
  }
}
