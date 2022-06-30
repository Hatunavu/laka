import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/model/auth/create_vendor/create_vendor_request.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/aws_image/local_image.dart';
import 'package:client_tggt/model/category/category_model.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

class CreateVendorController extends GetxController {
  final String title = "signup_vendor_controller";
  CreateVendorController(this._apiClient);
  final vendorNameController = TextEditingController(text: "").obs;
  final vendorEmailController = TextEditingController(text: "").obs;
  final vendorPhoneController = TextEditingController(text: "").obs;
  final vendorAddressController = TextEditingController(text: "").obs;
  final vendorDetailsController = TextEditingController(text: "").obs;
  final isLoadingApply = false.obs;
  final longitude = "".obs;
  final latitude = "".obs;
  final isLoadingFourth = false.obs;
  final isLoadingPickImage = false.obs;
  final isCompleteInformation = false.obs;
  final selectedCategory = CategoryModel(
    id: "0",
    title: "",
    iconName: "",
    isEnalble: false,
    type: "",
  ).obs;
  final account = AccountModel().obs;
  RxList<AttributeModel> listAttribute = RxList<AttributeModel>();
  RxList<AttributeModel> listSelectedAttribute = RxList<AttributeModel>();

  final listLocalImage = <GalleryModel>[].obs;
  final listLocalImagesUpload = <LocalImagePick>[].obs;
  final ApiClient _apiClient;
  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }

  handleGetListAttribute() async {
    try {
      isLoadingFourth(true);
      final response = await _apiClient.customerGetListAttribute();
      if (response.status == 200) {
        inspect(response.data);
        listAttribute.value = response.data ?? [];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadingFourth(false);
    }
  }

  handleUpdateProfile(AccountModel data) {
    account.value = data;
    vendorPhoneController.value.text = data.phoneNumber ?? "";
    vendorEmailController.value.text = data.emailAddress ?? "";
  }

  handleCheckInformation() {
    if (vendorNameController.value.text != "" &&
        vendorEmailController.value.text != "" &&
        vendorAddressController.value.text != "" &&
        selectedCategory.value.isEnalble == true) {
      isCompleteInformation.value = true;
    }
  }

  handleSelectAttribut(AttributeModel item) {
    if (listSelectedAttribute.contains(item)) {
      listSelectedAttribute.value = listSelectedAttribute
          .where((attribute) => attribute != item)
          .toList();
    } else {
      listSelectedAttribute.value = [...listSelectedAttribute, item];
    }
  }

  handleUpdateSelectedCategory(CategoryModel category) {
    selectedCategory.value = category;
  }

  handleUploadImage(ImageSource source) async {
    inspect(source);
    isLoadingPickImage(true);
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
      isLoadingPickImage(false);
      return;
    }

    final fileExtension = p.extension(image.path).replaceAll('.', '');
    if (fileExtension != 'png' &&
        fileExtension != 'jpg' &&
        fileExtension != 'jpeg') {
      log("định dạng ảnh không được hỗ trợ");
      isLoadingPickImage(false);
    }
    listLocalImagesUpload.add(LocalImagePick(
        name: image.name,
        resource: image.path,
        fileType: fileExtension,
        type: "image"));
    final localImageShow = GalleryModel(path: image.path, type: "image");

    listLocalImage.add(localImageShow);
    isLoadingPickImage(false);
  }

  handleRemoveImage(int index) {
    listLocalImage.removeAt(index);
    listLocalImagesUpload.removeAt(index);
  }

  Future<bool> handleApplyVendor() async {
    isLoadingApply.value = true;
    final detail = vendorDetailsController.value.text;
    final brandname = vendorNameController.value.text;
    final fullAddress = vendorAddressController.value.text;
    final lat = latitude.value;
    final lng = longitude.value;
    final category = selectedCategory.value.type;
    final List<String> attributes;
    if (listSelectedAttribute.isNotEmpty) {
      attributes =
          listSelectedAttribute.map((element) => element.id ?? "").toList();
    } else {
      attributes = [];
    }

    final listImageUpload = <LocalImage>[];

    await Future.forEach(listLocalImagesUpload, (LocalImagePick media) async {
      try {
        final generateImageUrlResponse = await _apiClient.generatePostImageUrl(
          GenerateAwsImageRequest(fileType: media.fileType),
        );
        final localImage = LocalImage(
            name: media.name,
            resource: media.resource,
            awsImage: generateImageUrlResponse.awsImage,
            type: media.type);
        listImageUpload.add(localImage);
      } on DioError catch (e) {
        final errorMessage = _apiClient.mapDioErrorToMessage(e);
        log(errorMessage);
      }
    });

    listImageUpload.removeWhere((element) =>
        element.awsImage.uploadUrl == null ||
        element.awsImage.uploadUrl!.isEmpty);
    final uploadResult = await Future.wait(
      listImageUpload
          .map(
            (e) => e.type == "image"
                ? _apiClient.uploadImage(
                    e.awsImage.uploadUrl!,
                    File(e.resource!),
                  )
                : _apiClient.uploadVideo(
                    e.awsImage.uploadUrl!, File(e.resource!)),
          )
          .toList(),
    );

    if (uploadResult.every((element) => element)) {
      try {
        final listGallery =
            listImageUpload.map((e) => e.awsImage.downloadUrl).toList();

        final request = CreateVendorRequest(
            brandName: brandname,
            details: detail,
            category: category,
            fullAddress: fullAddress,
            attributes: attributes,
            gallery: listGallery,
            lat: lat,
            lng: lng);
        final response = await _apiClient.applyVendor(request);

        if (response.status == 200) {
          await AccountServices().saveAccountType(AccountType.vendor.getType());
          return true;
        } else {
          return false;
        }
      } on DioError catch (e) {
        final errorMessage = _apiClient.mapDioErrorToMessage(e);
        log(errorMessage);
        return false;
      } finally {
        isLoadingApply.value = false;
      }
    } else {
      return false;
    }
  }
}
