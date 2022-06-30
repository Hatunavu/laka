import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:get/get.dart';

class VendorProfileController extends GetxController {
  final String title = "vendor_profile";
  final isLoading = false.obs;
  final ApiClient _apiClient;
  VendorProfileController(this._apiClient);
  final account = VendorInfoModel().obs;
  final isLoadingUpdateThubnail = false.obs;
  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    getMe();
    super.onInit();
  }

  getMe() async {
    final userToken = AccountServices().getUserToken();
    if (userToken != "") {
      try {
        isLoading(true);
        var data = await _apiClient.getVendorInfor();
        if (data.status == 200) {
          final accountData = data.data!.account!;
          // final profile = accountData.profile;
          // final phone = accountData.phone;
          // final type = accountData.type;
          // final authentication = accountData.authentication;
          // final gender = accountData.profile!.gender;
          account.value = accountData;
        } else if (data.status == 401) {
          log("Lấy thông tin thất bại");
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        isLoading(false);
      }
    }
  }
}
