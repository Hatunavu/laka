import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/message/get_list_message_response.dart';
import 'package:get/get.dart';

class VendorMessageController extends GetxController {
  final String title = "vendor_message";
  final isLoading = false.obs;
  final limit = 20.obs;
  final page = 0.obs;
  final listMessage = <MessageItemInList>[].obs;
  final ApiClient _apiClient;
  VendorMessageController(this._apiClient);
  @override
  void onInit() {
    getListMessage();
    super.onInit();
  }

  getListMessage() async {
    try {
      isLoading.value = true;
      final response = await _apiClient.getListMessage(limit.value, page.value);
      if (response.status == 200) {
        final data = response.data.docs;
        listMessage.value = data ?? [];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
