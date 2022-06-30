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

class ConfirmCompleteController extends GetxController {
  ConfirmCompleteController(this._apiClient);
  final String title = "service item";
  final isLoadingPick = false.obs;
  final totalPrice = TextEditingController(text: "").obs;
  final discountPercent = TextEditingController(text: "").obs;
  final finalPrice = "0".obs;
  final List listError = [].obs;
  final ApiClient _apiClient;
  final listLocalImages = <GalleryModel>[].obs;
  final listUrlImageUpload = <String>[].obs;

  final _picker = ImagePicker();

  handleUpdateTotalPrice(String price) {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    totalPrice.value.text = price;
    finalPrice.value = currencyFormatter.format(double.parse(price));
  }

  handleRemoveImageBill(int index) {
    listLocalImages.removeAt(index);
    listUrlImageUpload.removeAt(index);
  }

  handleUpdateFinalPrice() {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    final totalPriceDouble =
        totalPrice.value.text == "" ? 0 : double.parse(totalPrice.value.text);
    final discountPercentDouble = discountPercent.value.text == ""
        ? 0
        : double.parse(discountPercent.value.text);
    finalPrice.value = currencyFormatter.format(
        totalPriceDouble - (totalPriceDouble * discountPercentDouble / 100));
  }

  bool handleConfirm() {
    if (totalPrice.value.text == "") {
      listError.add("totalPrice");
    }
    // if (listLocalImages.isEmpty) {
    //   listError.add("image");
    // }
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
