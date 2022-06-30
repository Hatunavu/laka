import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/banner/banner_model.dart';
import 'package:client_tggt/model/category/home_splash_model.dart';
import 'package:client_tggt/model/rewards/reward_data.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardsController extends GetxController {
  final listRewards = [1, 2, 3, 4, 5].obs;

  var scrollController = ScrollController().obs;
  final rewardsData =
      RewardData(currentTier: TierType.none, nextTier: TierType.none).obs;
  final currentPoint = 0.obs;
  final nextTierPoint = 1.obs;
  var isPinned = false.obs;
  final isLoading = false.obs;
  final ApiClient _apiClient;
  final listSplashImage = <HomeSplashMode>[].obs;
  final carouselIndex = 0.obs;

  List<VoucherModel> listVoucher = <VoucherModel>[].obs;
  final listVoucherSystem = <VoucherModel>[].obs;
  final listVoucherVendors = <VoucherModel>[].obs;
  final listBanner = <BannerModel>[].obs;
  final limit = 30.obs;
  final page = 1.obs;
  final totalDocs = 0.obs;

  RewardsController(this._apiClient);

  @override
  onInit() {
    super.onInit();
    addListSplashImage();
  }

  bool checkIsMaxTier() {
    return rewardsData.value.nextTier == rewardsData.value.currentTier;
  }

  addListSplashImage() {
    listSplashImage.add(HomeSplashMode(
        index: 0, image: "assets/images/banner/Banner-LAKA-01.jpg"));
    listSplashImage.add(HomeSplashMode(
        index: 1, image: "assets/images/banner/Banner-LAKA-02.jpg"));
  }

  getListVoucher(int limit, int page, String type, String vendorId) async {
    try {
      isLoading(true);
      var response =
          await _apiClient.getListVoucher(limit, page, type, vendorId);
      if (response.status == 200) {
        final data = response.data;
        if (data != null) {
          listVoucher = data.docs ?? [];
          totalDocs.value = data.totalDocs ?? 0;
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  getDataRewardScreen() async {
    try {
      isLoading(true);
      var response = await _apiClient.getRewardScreen();
      if (response.status == 200) {
        final data = response.data;
        if (data != null) {
          listBanner.value = data.banners ?? [];
          listVoucherSystem.value = data.systemVouchers ?? [];
          listVoucherVendors.value = data.vendorVouchers ?? [];
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  getCustomerRewards() async {
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

  handleUpdateCarouselIndex(int index) {
    carouselIndex.value = index;
  }
}
