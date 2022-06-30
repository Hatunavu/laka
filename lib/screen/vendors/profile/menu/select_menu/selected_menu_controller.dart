import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:get/get.dart';

class SelectedMenuController extends GetxController {
  final String title = "list_select_menu_controller";
  final isLoading = false.obs;
  final ApiClient _apiClient;
  SelectedMenuController(this._apiClient);
  final listMenu = <MenuModel>[].obs;
  final listSelectedMenu2 = <SelectedMenuItemModel>[].obs;
  final isLoadingUpdateThubnail = false.obs;
  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  handleAddMenu(MenuModel item) {
    listMenu.value = [item, ...listMenu];
  }

  handleAddSelectedMenu(MenuModel item, bool isSelected) {
    if (isSelected == true) {
      listSelectedMenu2.value =
          listSelectedMenu2.where((i) => i.item.id != item.id).toList();
    } else {
      listSelectedMenu2.value = [
        SelectedMenuItemModel(amount: 1, item: item),
        ...listSelectedMenu2
      ];
    }
  }

  onAddAmount(MenuModel item) {
    final findMenu =
        listSelectedMenu2.where((p0) => p0.item.id == item.id).toList()[0];
    final findIndex = listSelectedMenu2.indexOf(findMenu);
    findMenu.amount = findMenu.amount + 1;
    listSelectedMenu2[findIndex] = findMenu;
  }

  onSubMenu(MenuModel item) {
    final findMenu =
        listSelectedMenu2.where((p0) => p0.item.id == item.id).toList()[0];
    if (findMenu.amount == 1) return;
    final findIndex = listSelectedMenu2.indexOf(findMenu);
    findMenu.amount = findMenu.amount - 1;
    listSelectedMenu2[findIndex] = findMenu;
  }

  handleUpdatelistSelectedMenu(List<SelectedMenuItemModel> listMenu) {
    listSelectedMenu2.value = listMenu;
  }

  getListStaff(List<SelectedMenuItemModel> list) async {
    // final userToken = AccountServices().getUserToken();

    try {
      isLoading(true);
      var response = await _apiClient.vendorGetListMenu();
      if (response.status == 200) {
        final data = response.data;
        listMenu.value = data.docs ?? [];
        listSelectedMenu2.value = list
            .map((e) => SelectedMenuItemModel(amount: e.amount, item: e.item))
            .toList();
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
