import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/rewards/reward_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardsDetailController extends GetxController {
  final listRewards = [1, 2, 3, 4, 5].obs;

  var scrollController = ScrollController().obs;
  final rewardsData =
      RewardData(currentTier: TierType.none, nextTier: TierType.none).obs;
  final currentPoint = 0.obs;
  final nextTierPoint = 1.obs;
  var isPinned = false.obs;
  final isLoading = false.obs;
  final ApiClient _apiClient;

  RewardsDetailController(this._apiClient);

  @override
  onInit() {
    super.onInit();
    scrollController.value.addListener(() {
      if (!isPinned.value &&
          scrollController.value.hasClients &&
          scrollController.value.offset > kToolbarHeight) {
        isPinned.value = true;
      } else if (isPinned.value &&
          scrollController.value.hasClients &&
          scrollController.value.offset < kToolbarHeight) {
        isPinned.value = false;
      }
    });
    _getCustomerRewards();
  }

  bool checkIsMaxTier() {
    return rewardsData.value.nextTier == rewardsData.value.currentTier;
  }

  _getCustomerRewards() async {
    try {
      isLoading(true);
      var response = await _apiClient.getCustomerRewards();
      if (response.status == 200) {
        rewardsData.value = response.data ?? rewardsData.value;
        nextTierPoint.value = rewardsData.value.nextTierPoints ?? 0;
        currentPoint.value = rewardsData.value.currentPoints ?? 0;
      } else {
        debugPrint(response.status.toString());
      }
    } on Exception catch (err) {
      debugPrint("err $err");
    } finally {
      isLoading(false);
    }
  }
}
