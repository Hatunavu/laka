import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/notification/notification_model.dart';
import 'package:get/get.dart';

class VendorNotificationController extends GetxController {
  final String title = "vendor_notification";
  final isLoading = false.obs;
  final ApiClient _apiClient;
  final limit = 20.obs;
  final page = 1.obs;
  final isEmptyNotification = false.obs;
  final listNotification = <NotificationModal>[].obs;
  final totalDocs = 0.obs;
  VendorNotificationController(this._apiClient);
  @override
  void onInit() {
    getListNotification();
    super.onInit();
  }

  getListNotification() async {
    try {
      isLoading(true);
      final response =
          await _apiClient.getListNotification(limit.value, page.value);
      if (response.status == 200) {
        if (response.data.docs!.isEmpty) {
          isEmptyNotification.value = true;
        } else {
          final data = response.data;
          final docs = data.docs;
          listNotification.value = docs ?? [];
          totalDocs.value = data.totalDocs ?? 0;
        }
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
}
