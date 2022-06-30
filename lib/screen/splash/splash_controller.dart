import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/user/get_profile_response.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final String title = "splash";
  final userToken = AccountServices().getUserToken().obs;
  final isLoading = false.obs;
  final userId = AccountServices().getUserId().obs;
  final accountType = AccountServices().getAccountType().obs;
  final Rx<AccountModel> account = AccountModel().obs;
  SplashController(this._apiClient);
  final ApiClient _apiClient;

  @override
  void onInit() {
    super.onInit();
  }

  Future<GetProfileResponse?> getMe() async {
    try {
      isLoading.value = true;
      final userToken = AccountServices().getUserToken();
      var data = await _apiClient.getMyAccount('Bearer $userToken');
      return data;
    } on Exception catch (err) {
      log("err $err");
      return null;
    }
  }
}
