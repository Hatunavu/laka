import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_request.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_thumbnail_request.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

class ServiceItemController extends GetxController {
  final String title = "service item";
  final isLoading = false.obs;
  final currencyFormatter = NumberFormat('#,##0  đ', 'ID');
  ServiceItemController(this._apiClient);
  final ApiClient _apiClient;
  final isLoadingUpdateImage = false.obs;
  final _picker = ImagePicker();

  final Rx<ServicesModel> serviceItem = ServicesModel(
    active: true,
    attributes: [],
    details: '',
    name: '',
    price: 0,
  ).obs;

  final RxList<AttributeModel> listGeneralAtrribute = RxList<AttributeModel>();
  final RxList<AttributeModel> listCustomAtrribute = RxList<AttributeModel>();
  final RxList<AttributeModel> listTimeAtrribute = RxList<AttributeModel>();

  final nameController = TextEditingController(text: "").obs;
  final detailController = TextEditingController(text: "").obs;
  final noteController = TextEditingController(text: "").obs;
  final priceController = TextEditingController(text: "").obs;
  final serviceThumbnail = ImageModel().obs;
  final listServiceGallery = <ImageModel>[].obs;

  handleEditName() {
    if (nameController.value.text != serviceItem.value.name) {
      final EditServiceItemRequest request =
          EditServiceItemRequest(name: nameController.value.text);
      handleEditServiceItem(request, "name");
    } else {
      // navigator!.pop();
      Get.find<RouterController>().back();
    }
  }

  handleEditDetail() {
    if (detailController.value.text != serviceItem.value.details) {
      final EditServiceItemRequest request =
          EditServiceItemRequest(details: detailController.value.text);
      handleEditServiceItem(request, "detail");
    } else {
      Get.find<RouterController>().back();
    }
  }

  handleEditNote() {
    if (noteController.value.text != serviceItem.value.note) {
      final EditServiceItemRequest request =
          EditServiceItemRequest(note: noteController.value.text);
      handleEditServiceItem(request, "note");
    } else {
      Get.find<RouterController>().back();
    }
  }

  handleEditPrice() {
    if (priceController.value.text != '${serviceItem.value.price}') {
      final EditServiceItemRequest request =
          EditServiceItemRequest(price: int.parse(priceController.value.text));
      handleEditServiceItem(request, "price");
    } else {
      Get.find<RouterController>().back();
    }
  }

  handleEditAttribute(List<AttributeModel> attribute) {
    final EditServiceItemRequest request =
        EditServiceItemRequest(attributes: attribute);
    handleEditServiceItem(request, "attribute");
  }

  handleEditStatus(String status) {
    final EditServiceItemRequest request =
        EditServiceItemRequest(status: status);
    handleEditServiceItem(request, "status");
  }

  handleEditThumbnail(ImageSource source) async {
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

    final fileExtension = p.extension(image.path).replaceAll('.', '');

    if (fileExtension != 'png' &&
        fileExtension != 'jpg' &&
        fileExtension != 'jpeg') {
      log("định dạng ảnh không được hỗ trợ");
      isLoadingUpdateImage(false);
    }
    try {
      final generateImageUrlResponse = await _apiClient.generateImageUrl(
        GenerateAwsImageRequest(fileType: fileExtension),
      );

      final uploadResult = await _apiClient.uploadImage(
          generateImageUrlResponse.awsImage.uploadUrl!, File(image.path));

      if (uploadResult) {
        final request = UpdateServiceItemThumbnailRequest(
            image: generateImageUrlResponse.awsImage.downloadUrl);
        final response = await _apiClient.updateServiceThumbnail(
            serviceItem.value.id!, request);
        if (response.status == 200) {
          serviceThumbnail.value = response.data!;
          getIt.get<IToast>().show(
              title: 'updateSuccess'.tr,
              message: 'updateSuccess'.tr,
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1000));
        } else {
          getIt.get<IToast>().show(
              title: 'updateFailed'.tr,
              message: 'updateFailed'.tr,
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1000));
        }
      }
    } on DioError catch (e) {
      final errorMessage = _apiClient.mapDioErrorToMessage(e);
      log(errorMessage);
    } finally {
      isLoadingUpdateImage(false);
    }
  }

  handleEditServiceItem(EditServiceItemRequest request, String type) async {
    try {
      isLoading(true);
      final response =
          await _apiClient.putUpdateServiceItem(serviceItem.value.id!, request);
      if (response.status == 200) {
        final data = response.data!;

        serviceItem.value = data;
        switch (type) {
          case "name":
            nameController.value.text = data.name ?? '';
            return;
          case "detail":
            detailController.value.text = data.details ?? '';
            return;
          case "note":
            noteController.value.text = data.note!;
            return;
          case "price":
            priceController.value.text = '${data.price}';
            return;
          case "attribute":
            final attributes = data.attributes;
            if (attributes != null && attributes.isNotEmpty) {
              final listGeneral = attributes
                  .where((element) => element.type == "general")
                  .toList();
              final listCustom = attributes
                  .where((element) => element.type == "custom")
                  .toList();
              final listTime = attributes
                  .where((element) => element.type == "time")
                  .toList();
              listCustomAtrribute.value = listCustom;
              listGeneralAtrribute.value = listGeneral;
              listTimeAtrribute.value = listTime;
            }
            return;
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
      Get.find<RouterController>().back();
    }
  }

  getServiceItem(String serviceItemId) async {
    // final getServiceItemId = Get.arguments["serviceItemId"];
    try {
      isLoading(true);
      final response = await _apiClient.getServiceDetail(serviceItemId);
      if (response.status == 200) {
        final data = response.data!;
        serviceItem.value = data;
        final attributes = data.attributes;
        final gallery = data.gallery;
        nameController.value.text = data.name ?? '';
        detailController.value.text = data.details ?? '';
        priceController.value.text = '${data.price}';
        if (data.note != null) data.note;

        if (attributes != null && attributes.isNotEmpty) {
          final listGeneral =
              attributes.where((element) => element.type == "general").toList();
          final listCustom =
              attributes.where((element) => element.type == "custom").toList();
          final listTime =
              attributes.where((element) => element.type == "time").toList();
          listCustomAtrribute.value = listCustom;
          listGeneralAtrribute.value = listGeneral;
          listTimeAtrribute.value = listTime;
          listServiceGallery.value = gallery!;
          if (data.thumbnail != null) {
            serviceThumbnail.value = data.thumbnail!;
          }
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
