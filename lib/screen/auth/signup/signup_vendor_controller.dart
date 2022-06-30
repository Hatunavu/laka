import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/auth/create_vendor/location/district_response/district_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/ward_response/ward_data.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class SignupVendorController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final String title = "signup_vendor";
  final detailTextController = TextEditingController(text: "").obs;
  final phoneTextController = TextEditingController(text: "").obs;
  final passwordTextController = TextEditingController(text: "").obs;
  final confirmpasswordTextController = TextEditingController(text: "").obs;
  final brandNameTextController = TextEditingController(text: "").obs;
  final fullAddressTextController = TextEditingController(text: "").obs;
  final vendorThumbnail = "".obs;
  final categoryType = CategoryType.bar.obs;
  final isLoading = false.obs;
  final errorMessage = "".obs;
  final isLoadingUpdateImage = false.obs;
  final _picker = ImagePicker();

  final listProvinces = <ProvinceData>[].obs;
  final selectedProvince = ProvinceData().obs;

  final listDistricts = <DistrictData>[].obs;
  final selectedDistrict = DistrictData().obs;
  final isShowDistrict = false.obs;

  final listWards = <WardData>[].obs;
  final selectedWard = WardData().obs;
  final isShowWard = false.obs;

  SignupVendorController(this._apiClient);

  @override
  void onInit() {
    super.onInit();
    getListProvinces();
  }

  final ApiClient _apiClient;

  handlePickImage(ImageSource source) async {
    isLoadingUpdateImage(true);
    final permission =
        source == ImageSource.camera ? Permission.camera : Permission.photos;
    final permissionStatus = await permission.request();
    switch (permissionStatus) {
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
      // isNotPermission.value = true;
      // print("123");
      // return;
      case PermissionStatus.granted:
        // Do nothing
        break;
      case PermissionStatus.limited:
        break;
    }
    final image = await _picker.pickImage(source: source);
    if (image == null) {
      isLoadingUpdateImage(false);
      return;
    }

    final fileExtension = path.extension(image.path).replaceAll('.', '');
    _uploadImage(fileExtension, image);
  }

  Future<void> _uploadImage(String fileExtension, XFile image) async {
    if (fileExtension != 'png' &&
        fileExtension != 'jpg' &&
        fileExtension != 'jpeg') {
      getIt.get<IToast>().show(
          title: "định dạng ảnh không được hỗ trợ",
          message: "định dạng ảnh không được hỗ trợ",
          hasDismissButton: false,
          duration: const Duration(milliseconds: 1000));
      isLoading(false);
    }
    try {
      final generateImageUrlResponse = await _apiClient.generateImageUrl(
        GenerateAwsImageRequest(fileType: fileExtension),
      );
      final uploadResult = await _apiClient.uploadImage(
          generateImageUrlResponse.awsImage.uploadUrl!, File(image.path));
      if (uploadResult) {
        vendorThumbnail.value = generateImageUrlResponse.awsImage.downloadUrl;
      }
    } on DioError catch (e) {
      final errorMessage = _apiClient.mapDioErrorToMessage(e);
      log(errorMessage);
    }
  }

  handleSignUpVendor() async {
    // var phoneNumber = phoneTextController.value.text;
    // var password = passwordTextController.value.text;
    // var brandName = brandNameTextController.value.text;
    // var detail = detailTextController.value.text;
    // var category = categoryType.value.display().toUpperCase();
    // var fullAddress = fullAddressTextController.value.text +
    //     ", ${selectedWard.value.name}, ${selectedDistrict.value.name}, ${selectedDistrict.value.name}";

    // final request = CreateVendorRequest(
    //     type: "vendor",
    //     details: detail,
    //     phone: phoneNumber,
    //     password: password,
    //     category: category,
    //     brandName: brandName,
    //     fullAddress: fullAddress);

    // try {
    //   isLoading.value = true;
    //   var data = await _apiClient.postCreateVendor(request);
    //   if (data.status == 200) {
    //     inspect(data);
    //     //TODO: Dang ky Vendor
    //   } else {
    //     errorMessage.value = "Số điện thoại đã tồn tại.";
    //   }
    // } on Exception catch (err) {
    //   log("err $err");
    // } finally {
    //   isLoading.value = false;
    // }
  }

  getListDistricts(String id) {
    listDistricts.value = [];
    listDistricts.refresh();
    listWards.value = [];
    listWards.refresh();
    isShowDistrict.value = false;
    isShowWard.value = false;
    _getListDistrictByProvinceID(id);
  }

  getListWards(String id) {
    listWards.value = [];
    listWards.refresh();
    isShowWard.value = false;
    _getListWardsByDistrictID(id);
  }

  getListProvinces() async {
    try {
      isLoading.value = true;
      var response = await _apiClient.getProvinces();
      if (response.status == 200) {
        if (response.data != null) {
          listProvinces.value = response.data ?? listProvinces;
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

  _getListDistrictByProvinceID(String provinceID) async {
    try {
      isLoading.value = true;
      var response = await _apiClient.getDistrictsByProvince(provinceID);
      if (response.status == 200) {
        if (response.data != null) {
          listDistricts.value = response.data ?? listDistricts;
          isShowDistrict.value = true;
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

  _getListWardsByDistrictID(String districtID) async {
    try {
      isLoading.value = true;
      var response = await _apiClient.getWardsByDistrict(districtID);
      if (response.status == 200) {
        if (response.data != null) {
          listWards.value = response.data ?? listWards;
          isShowWard.value = true;
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
}
