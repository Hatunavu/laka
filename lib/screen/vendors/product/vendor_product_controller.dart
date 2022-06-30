import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_request.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VendorProductController extends GetxController {
  final String title = "vendor_manager";
  final isLoading = false.obs;
  final createNewProductStep = 1.obs;
  final RxList<ServicesModel> listServices = RxList<ServicesModel>();
  final ApiClient _apiClient;
  final listStatusServices = ["Tất Cả", "Hoạt động", "Lưu nháp", "Ẩn"].obs;
  ScrollController listServiceController = ScrollController();

  final statusServicesSelected = 0.obs;
  final page = 1.obs;
  final limit = 10.obs;
  final totalDocs = 0.obs;
  final status = "".obs;
  final Rx<ServicesModel> serviceItem = ServicesModel(
    active: true,
    attributes: [],
    details: '',
    name: '',
    price: 0,
  ).obs;

  VendorProductController(this._apiClient);
  final VendorMainController vendorMainController =
      Get.put(VendorMainController(getIt.get<ApiClient>()));
  @override
  void onInit() {
    handleGetListProduct(10, 1, "", "");
    listServiceController.addListener(listenLoadMoreList);

    super.onInit();
  }

  listenLoadMoreList() {
    if (listServiceController.offset ==
        listServiceController.position.maxScrollExtent) {
      if (listServices.length < totalDocs.value) {
        handleLoadmore();
      }
    }
  }

  handleSelecServiceItem(ServicesModel item) {
    serviceItem.value = item;
  }

  handleLoadmore() async {
    try {
      final response = await _apiClient.getListServices(
          limit.value, page.value + 1, "", status.value);
      if (response.status == 200) {
        listServices.value = response.data!.docs!;
        listServices.value = [...listServices, ...response.data!.docs!];
        page.value = page.value + 1;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {}
  }

  handleUpdateStatus(String id, bool status) async {
    try {
      isLoading(true);
      final EditServiceItemRequest request =
          EditServiceItemRequest(active: status);
      final response = await _apiClient.putUpdateServiceItem(id, request);
      if (response.status == 200) {
        final data = response.data!;
        final newListServices = listServices.map((item) {
          if (item.id == data.id) {
            return data;
          }
          return item;
        }).toList();
        listServices.value = newListServices;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleChangeStatus(int index) {
    statusServicesSelected.value = index;
    switch (index) {
      case 0:
        status.value = "";
        handleGetListProduct(limit.value, 1, "", "");
        return;
      case 1:
        status.value = "published";
        handleGetListProduct(limit.value, 1, "", "published");
        return;
      case 2:
        status.value = "draft";
        handleGetListProduct(limit.value, 1, "", "draft");
        return;
      case 3:
        status.value = "";
        handleGetListProduct(limit.value, 1, "", "hidden");
        return;
    }
  }

  handleGetListProduct(
      int limit, int page, String active, String status) async {
    try {
      isLoading(true);
      final response =
          await _apiClient.getListServices(limit, page, active, status);
      if (response.status == 200) {
        listServices.value = response.data!.docs!;
        totalDocs.value = response.data!.totalDocs!;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  handleNextStep(int step) {
    createNewProductStep.value = step;
  }
}
