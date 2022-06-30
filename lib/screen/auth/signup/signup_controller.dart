import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/auth/signup_customer/check_telephone_request.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final String title = "signup";
  final isCheckRules = true.obs;
  final step = 0.obs;
  final phoneController = TextEditingController(text: "").obs;
  final fullnameController = TextEditingController(text: "").obs;
  final passwordController = TextEditingController(text: "").obs;
  final isLoading = false.obs;
  final errorMessage = "".obs;

  SignupController(this._apiClient);
  final ApiClient _apiClient;

  changeCheckRules(bool status) {
    isCheckRules.value = status;
  }

  Future<bool> handleCheckTelephone() async {
    final referralBy = AccountServices().getReferralId();
    final checkValid = isValidPhoneNumber(phoneController.value.text);
    if (checkValid == false) return false;
    final phone = phoneController.value.text;
    print("ref $referralBy");
    final request = CheckTelephoneRequest(
        phone: phone,
        referralBy: referralBy,
        fullName: fullnameController.value.text);
    try {
      isLoading.value = true;
      var data = await _apiClient.checkTelephoneSignupCustomer(request);
      if (data.status == 200) {
        // phoneController.value.text = "";
        return true;
      } else {
        errorMessage.value = data.message;
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  bool isValidPhoneNumber(String string) {
    if (string.isEmpty) {
      return false;
    }
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return false;
    }
    return true;
  }

  handleSignUp() async {
    // var fullname = fullnameController.value.text;
    // var phoneNumber = phoneController.value.text;
    // var password = passwordController.value.text;

    // final request = SignupRequest(
    //     phone: phoneNumber, fullName: fullname, password: password);
    // try {
    //   isLoading.value = true;
    //   var data = await _apiClient.create(request);
    //   if (data.status == 200) {
    //     // var routeParam = {"phone": phoneNumber};
    //     step.value = 0;
    //     phoneController.value.text = "";
    //     fullnameController.value.text = "";
    //     passwordController.value.text = "";
    //     // Get.toNamed(AppRoutes.Verify, parameters: routeParam);
    //     await Get.delete<VerifyController>();
    //     Get.find<RouterController>().push(VerifyPage(telePhone: phoneNumber));
    //   } else {
    //     errorMessage.value = "Số điện thoại đã tồn tại.";
    //   }
    // } on Exception catch (err) {
    //   log("err $err");
    // } finally {
    //   isLoading.value = false;
    // }

    debugPrint("123");
  }

  nextStep(int value) {
    step.value = value;
  }
}
