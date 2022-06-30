import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:get/get.dart';

class ListMenuController extends GetxController {
  final String title = "list_menu_controller";
  final isLoading = false.obs;
  final ApiClient _apiClient;
  ListMenuController(this._apiClient);
  final listMenu = <MenuModel>[].obs;
  final isLoadingUpdateThubnail = false.obs;
  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    getListStaff();
    super.onInit();
  }

  handleAddMenu(MenuModel item) {
    listMenu.value = [item, ...listMenu];
  }

  getListStaff() async {
    // final userToken = AccountServices().getUserToken();

    try {
      isLoading(true);
      var response = await _apiClient.vendorGetListMenu();
      if (response.status == 200) {
        final data = response.data;
        listMenu.value = data.docs ?? [];
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
