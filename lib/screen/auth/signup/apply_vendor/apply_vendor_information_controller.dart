import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/apply_vendor/apply_vendors_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyVendorInformationController extends GetxController {
  final String title = "apply_vendor_information_controller";
  final ApiClient _apiClient;
  ApplyVendorInformationController(this._apiClient);
  final nameController = TextEditingController(text: "").obs;
  final emailController = TextEditingController(text: "").obs;
  final phoneController = TextEditingController(text: "").obs;
  final addressController = TextEditingController(text: "").obs;
  final fullNameController = TextEditingController(text: "").obs;

  final isLoadingApply = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  handleSendApplyVendorsInformation() async {
    final vendorsName = nameController.value.text;
    final email = emailController.value.text;
    final phone = phoneController.value.text;
    final address = addressController.value.text;
    final fullname = fullNameController.value.text;

    final request = ApplyVendorsRequest(
        brandName: vendorsName,
        fullName: fullname,
        fullAddress: address,
        email: email,
        phone: phone);
    try {
      isLoadingApply.value = true;
      var data = await _apiClient.applicationVendor(request);
      if (data.status == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isLoadingApply.value = false;
    }
  }
}
