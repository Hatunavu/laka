import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/auth/create_vendor/location/district_response/district_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/ward_response/ward_data.dart';
import 'package:get/get.dart';

class VendorAddAddressController extends GetxController {
  final String title = "signup_vendor_controller";
  VendorAddAddressController(this._apiClient);
  final ApiClient _apiClient;
  final currentStep = 0.obs;
  final listProvinces = <ProvinceData>[].obs;
  final isLoading = false.obs;
  final selectedListProvices = ProvinceData().obs;
  final listDistricts = <DistrictData>[].obs;
  final selectedDistrics = DistrictData().obs;
  final listWards = <WardData>[].obs;
  final selectedWards = WardData().obs;
  final isSelectDistric = false.obs;
  final isSelectProvices = false.obs;
  final isSelectWards = false.obs;

  @override
  void onInit() {
    getListProvinces();
    super.onInit();
  }

  getListProvinces() async {
    try {
      isLoading.value = true;
      var response = await _apiClient.getProvinces();
      if (response.status == 200) {
        if (response.data != null) {
          listProvinces.value = response.data ?? listProvinces;
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }

  handleUpdateSelectedProvices(ProvinceData provinceData) {
    selectedListProvices.value = provinceData;
    isSelectProvices.value = true;
    getListDistrictByProvinceID(provinceData.code ?? "");
    currentStep.value = 1;
  }

  handleUpdateSelectedDistrict(DistrictData data) {
    selectedDistrics.value = data;
    isSelectDistric.value = true;
    getListWardsByDistrictID(data.code ?? "");
    currentStep.value = 2;
  }

  getListDistrictByProvinceID(String provinceID) async {
    try {
      isLoading.value = true;
      var response = await _apiClient.getDistrictsByProvince(provinceID);
      if (response.status == 200) {
        if (response.data != null) {
          listDistricts.value = response.data ?? [];
        }
      } else {
        //errorMessage.value = "Số điện thoại đã tồn tại.";
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }

  getListWardsByDistrictID(String districtID) async {
    try {
      isLoading.value = true;
      var response = await _apiClient.getWardsByDistrict(districtID);
      if (response.status == 200) {
        if (response.data != null) {
          listWards.value = response.data ?? listWards;
        }
      } else {
        //errorMessage.value = "Số điện thoại đã tồn tại.";
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }

  // nextStep(int value) {
  //   step.value = value;
  // }

  tapped(int step) {
    // setState(() => _currentStep = step);
    currentStep.value = step;
  }

  continued() {
    // _currentStep < 2 ?
    //     setState(() => _currentStep += 1): null;
    if (currentStep.value < 2) {
      currentStep.value = currentStep.value + 1;
    }
  }

  cancel() {
    // _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
    if (currentStep.value > 0) {
      currentStep.value = currentStep.value - 1;
    }
  }
}
