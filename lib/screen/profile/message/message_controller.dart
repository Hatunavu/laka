import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/message/get_list_message_response.dart';

import 'package:get/get.dart';

class MessageController extends GetxController {
  final String title = "message";
  final isLoading = false.obs;
  final limit = 20.obs;
  final page = 0.obs;
  final listMessage = <MessageItemInList>[].obs;
  final ApiClient _apiClient;
  MessageController(this._apiClient);
  @override
  void onReady() async {
    log("ready");
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    log("message controller init");
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
}
