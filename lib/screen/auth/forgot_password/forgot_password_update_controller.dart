import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/auth/forgot_password/update_password/forgot_password_update_request.dart';
import 'package:client_tggt/model/auth/forgot_password/verify/forgot_password_verify_request.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordUpdateController extends GetxController {
  final String title = "forgot_password";
  final passwordController = TextEditingController(text: "").obs;
  final isLoading = false.obs;
  final isError = false.obs;
  final errorMessage = "".obs;
  final token = "".obs;
  final isLoad = false.obs;
  final ApiClient _apiClient;
  ForgotPasswordUpdateController(this._apiClient);

  handleUpadateToken(String phone) {
    token.value = phone;
  }

  Future<bool> handleChangePassword() async {
    if (passwordController.value.text == "") return false;
    await AccountServices().saveUserToken(token.value);
    final request =
        ForgotPasswordUpdateRequest(password: passwordController.value.text);
    try {
      isLoading.value = true;
      isError.value = false;
      var response = await _apiClient.changePassword(request);
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
      passwordController.value.text = "";
      errorMessage.value = "";
      isLoading.value = false;
      AccountServices().saveUserToken("");
    }
  }
}
