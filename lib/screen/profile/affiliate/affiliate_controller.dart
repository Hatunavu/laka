import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class AffiliateController extends GetxController {
  final String title = "affiliate";
  final isLoading = false.obs;
  ScreenshotController screenshotController = ScreenshotController();

  final ApiClient _apiClient;
  AffiliateController(this._apiClient);
  List<AccountModel> listAffiliate = <AccountModel>[].obs;
  List<AccountModel> firstLevel = <AccountModel>[].obs;
  List<AccountModel> secondLevel = <AccountModel>[].obs;

  @override
  void onInit() {
    getListAffiliate();
    super.onInit();
  }

  getListAffiliate() async {
    try {
      isLoading.value = true;
      final response = await _apiClient.getListAffiliate();
      if (response.status == 200) {
        final data = response.data;
        firstLevel = data.firstLevels;
        secondLevel = data.secondLevels;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }
}
