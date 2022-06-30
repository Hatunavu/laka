import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/account/update_vendor_profile_request.dart';
import 'package:client_tggt/model/vendor_page/account/update_vendors_thumbnail_request.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class VendorProfileInformationController extends GetxController {
  final String title = "vendor_profile_controller";
  final isLoading = false.obs;
  final ApiClient _apiClient;
  VendorProfileInformationController(this._apiClient);
  final account = VendorInfoModel().obs;
  final _picker = ImagePicker();
  final isLoadingUpdateThubnail = false.obs;

  final brandNameController = TextEditingController(text: "").obs;
  final detailController = TextEditingController(text: "").obs;

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void onInit() {
    getMe();
    super.onInit();
  }

  getMe() async {
    final userToken = AccountServices().getUserToken();
    if (userToken != "") {
      try {
        isLoading(true);
        var data = await _apiClient.getVendorInfor();
        if (data.status == 200) {
          final accountData = data.data!.account!;
          account.value = accountData;
          brandNameController.value.text = accountData.vendor!.brandName;
          detailController.value.text = accountData.vendor!.details ?? "";
        } else if (data.status == 401) {
          log("Lấy thông tin thất bại");
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        isLoading(false);
      }
    }
  }

  handleUpdateVendorProfile() async {
    // updateVendorProfile
    try {
      isLoading(true);
      final request = UpdateVendorProfileRequest(
          brandName: brandNameController.value.text,
          details: detailController.value.text);
      var response = await _apiClient.updateVendorProfile(request);
      if (response.status == 200) {
        final data = response.data;
        account.value.vendor = data!;
        inspect(data);
        getIt.get<IToast>().show(
            title: 'Thông báo',
            message: "Cập nhật thành công",
            hasDismissButton: false,
            duration: const Duration(milliseconds: 1000));
      } else {
        getIt.get<IToast>().show(
            title: "Thông báo",
            message: "Cập nhật thất bại",
            hasDismissButton: false,
            duration: const Duration(milliseconds: 1000));
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handlePickImage(ImageSource source) async {
    isLoadingUpdateThubnail(true);
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
      isLoadingUpdateThubnail(false);
      return;
    }

    final fileExtension = p.extension(image.path).replaceAll('.', '');
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
      final generateImageUrlResponse = await _apiClient.generateUpdateThumbnail(
        GenerateAwsImageRequest(fileType: fileExtension),
      );
      final uploadResult = await _apiClient.uploadImage(
          generateImageUrlResponse.awsImage.uploadUrl!, File(image.path));
      if (uploadResult) {
        final updateAccountRequest = UpdateVendorsThumnailRequest(
            image: generateImageUrlResponse.awsImage.downloadUrl);
        final respose =
            await _apiClient.updateVendorsThumbnail(updateAccountRequest);
        if (respose.status == 200) {
          final data = respose.data;
          account.value.vendor!.thumbnail = data;
          isLoadingUpdateThubnail(false);
          getIt.get<IToast>().show(
              title: 'Thông báo',
              message: "Cập nhật thành công",
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1000));
        } else {
          log("update avatar false");
          getIt.get<IToast>().show(
              title: "Thông báo",
              message: "Cập nhật thất bại",
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1000));
          isLoadingUpdateThubnail(false);
        }
      }
    } on DioError catch (e) {
      final errorMessage = _apiClient.mapDioErrorToMessage(e);
      log(errorMessage);
    }
  }
}
