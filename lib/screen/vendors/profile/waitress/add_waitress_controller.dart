import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/aws_image/local_image.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/user/update_account_request.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/account/staff/create_staff_request.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class AddWaitressController extends GetxController {
  final String title = "vendor_profile";
  final isLoading = false.obs;
  final ApiClient _apiClient;
  AddWaitressController(this._apiClient);
  final account = VendorInfoModel().obs;
  final isLoadingUpdateThubnail = false.obs;
  final _picker = ImagePicker();
  // final images = LocalImage(awsImage: AwsImage(downloadUrl: "")).obs;
  final avatar = GalleryModel().obs;
  final isPickImage = false.obs;
  final fullName = TextEditingController(text: "").obs;
  final info = TextEditingController(text: "").obs;
  final descriptionController = TextEditingController(text: "").obs;
  final fullNameController = TextEditingController(text: "").obs;
  final isLoadingPickImage = false.obs;
  final avatarUpload = LocalImage(awsImage: AwsImage(downloadUrl: "")).obs;
  final staffItem = StaffModel(id: "", image: "", name: "", status: "").obs;

  handlePickImage(ImageSource source) async {
    isLoadingPickImage(true);
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
      isLoadingPickImage(false);
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
      final generateImageUrlResponse = await _apiClient.generateImageUrl(
        GenerateAwsImageRequest(fileType: fileExtension),
      );
      final uploadResult = await _apiClient.uploadImage(
          generateImageUrlResponse.awsImage.uploadUrl!, File(image.path));
      if (uploadResult) {
        avatar.value = GalleryModel(path: image.path, type: "image");

        avatarUpload.value = LocalImage(
            name: image.name,
            resource: image.path,
            awsImage: generateImageUrlResponse.awsImage,
            type: "image");

        isLoadingPickImage.value = false;
        isPickImage.value = true;
      }
    } on DioError catch (e) {
      final errorMessage = _apiClient.mapDioErrorToMessage(e);
      log(errorMessage);
    }
  }

  Future<bool> handleAddStaff() async {
    try {
      isLoading(true);
      final request = CreateStaffRequest(
          name: fullNameController.value.text,
          description: descriptionController.value.text,
          image: avatarUpload.value.awsImage.downloadUrl);
      var data = await _apiClient.createStaff(request);
      if (data.status == 200) {
        getIt.get<IToast>().show(
            title: 'Thông báo',
            message: 'Thêm kỹ thuật viên thành công',
            hasDismissButton: false,
            duration: const Duration(milliseconds: 1000));
        staffItem.value = data.data!;
        return true;
      } else {
        getIt.get<IToast>().show(
            title: 'Thông báo',
            message: 'Thêm kỹ thuật viên thất bại',
            hasDismissButton: false,
            duration: const Duration(milliseconds: 1000));
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isLoading(false);
    }
  }
}
