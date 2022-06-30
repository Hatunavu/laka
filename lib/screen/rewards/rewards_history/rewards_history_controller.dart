import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/rewards/reward_model.dart';
import 'package:get/get.dart';

class RewardsHistoryController extends GetxController {
  final String title = "voucher_detail";
  final ApiClient _apiClient;
  final isLoading = false.obs;
  final limit = 50.obs;
  final page = 1.obs;
  final total = 0.obs;

  RewardsHistoryController(this._apiClient);
  List<RewardsModel> listRewardsHistory = <RewardsModel>[].obs;

  @override
  void onInit() {
    getListRewardsHistory();
    super.onInit();
  }

  getListRewardsHistory() async {
    try {
      isLoading.value = true;
      final response = await _apiClient.getListRewardsHistory(
          "add", limit.value, page.value);
      if (response.status == 200) {
        final data = response.data;
        listRewardsHistory = data.docs ?? [];
        total.value = data.totalDocs ?? 0;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }
}
