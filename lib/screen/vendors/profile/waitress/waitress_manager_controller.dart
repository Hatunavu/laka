import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:get/get.dart';

class WaitressManagerController extends GetxController {
  final String title = "waitress_manager";
  final isLoading = false.obs;
  final ApiClient _apiClient;
  WaitressManagerController(this._apiClient);
  final listStaff = <StaffModel>[].obs;
  final isLoadingUpdateThubnail = false.obs;
  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    getListStaff();
    super.onInit();
  }

  getListStaff() async {
    // final userToken = AccountServices().getUserToken();

    try {
      isLoading(true);
      var response = await _apiClient.vendorGetListStaffs();
      if (response.status == 200) {
        final data = response.data;
        listStaff.value = data.docs ?? [];
      } else if (response.status == 401) {
        log("Lấy thông tin thất bại");
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }
}
