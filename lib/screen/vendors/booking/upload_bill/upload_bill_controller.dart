import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

class UploadBillController extends GetxController {
  UploadBillController(this._apiClient);
  final String title = "upload bill";
  final isLoadingPick = false.obs;
  final List listError = [].obs;
  final ApiClient _apiClient;
  final listLocalImages = <GalleryModel>[].obs;
  final listUrlImageUpload = <String>[].obs;

  final _picker = ImagePicker();

  handleRemoveImageBill(int index) {
    listLocalImages.removeAt(index);
    listUrlImageUpload.removeAt(index);
  }

  bool handleConfirm() {
    if (listLocalImages.isEmpty) {
      listError.add("image");
    }
    if (listError.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  handleUploadImageGallery(ImageSource source) async {
    isLoadingPick(true);
    final permission =
        source == ImageSource.camera ? Permission.camera : Permission.photos;
    final permissionStatus = await permission.request();
    switch (permissionStatus) {
      case PermissionStatus.denied:

      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:

      case PermissionStatus.granted:
        // Do nothing
        break;
      case PermissionStatus.limited:
        break;
    }
    final image = await _picker.pickImage(source: source);
    if (image == null) {
      isLoadingPick(false);
      return;
    }

    final fileExtension = p.extension(image.path).replaceAll('.', '');
    if (fileExtension != 'png' &&
        fileExtension != 'jpg' &&
        fileExtension != 'jpeg') {
      log("định dạng ảnh không được hỗ trợ");
      isLoadingPick(false);
    }

    try {
      final generateImageUrlResponse =
          await _apiClient.generateImageOrderComplete(
        GenerateAwsImageRequest(fileType: fileExtension),
      );
      final uploadResult = await _apiClient.uploadImage(
          generateImageUrlResponse.awsImage.uploadUrl!, File(image.path));

      if (uploadResult) {
        listUrlImageUpload.add(generateImageUrlResponse.awsImage.downloadUrl);
        final localImageShow = GalleryModel(path: image.path, type: "image");
        listLocalImages.add(localImageShow);
        if (listError.contains("image")) {
          listError.remove("image");
        }
        isLoadingPick(false);
      }
    } on DioError catch (e) {
      final errorMessage = _apiClient.mapDioErrorToMessage(e);
      log(errorMessage);
    }
  }
}
