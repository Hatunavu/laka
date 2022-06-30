import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/aws_image/local_image.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/model/vendor_page/manager_services/edit_service_item_gallery_request.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

class ServiceItemGalleryController extends GetxController {
  final String title = "service item gallery";
  final isLoading = false.obs;
  final _picker = ImagePicker();
  final ApiClient _apiClient;
  ServiceItemGalleryController(this._apiClient);
  final serviceItemId = "".obs;
  final listLocalImagesUpload = <LocalImage>[].obs;
  final listGalleryImage = <ImageModel>[].obs;

  updateServiceItemId(String id) {
    serviceItemId.value = id;
  }

  updateListGallery(List<ImageModel> list) {
    listGalleryImage.value = list;
  }

  handleUploadImageCamera(ImageSource source) async {
    isLoading(true);
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
      isLoading(false);
      return;
    }

    final fileExtension = p.extension(image.path).replaceAll('.', '');

    if (fileExtension != 'png' &&
        fileExtension != 'jpg' &&
        fileExtension != 'jpeg') {
      log("định dạng ảnh không được hỗ trợ");
      isLoading(false);
    }
    try {
      final generateImageUrlResponse = await _apiClient.generateImageUrl(
        GenerateAwsImageRequest(fileType: fileExtension),
      );

      final uploadResult = await _apiClient.uploadImage(
          generateImageUrlResponse.awsImage.uploadUrl!, File(image.path));

      if (uploadResult) {
        try {
          final listImageUpload = [
            generateImageUrlResponse.awsImage.downloadUrl
          ];

          final request =
              UpdateServiceItemGalleryRequest(images: listImageUpload);
          final response = await _apiClient.updateServiceGallery(
              serviceItemId.value, request);
          if (response.status == 200) {
            listGalleryImage.value = response.data!;
            getIt.get<IToast>().show(
                title: 'updateSuccess'.tr,
                message: 'updateSuccess'.tr,
                hasDismissButton: false,
                duration: const Duration(milliseconds: 1500));
          } else {
            getIt.get<IToast>().show(
                title: 'updateFailed'.tr,
                message: 'updateFailed'.tr,
                hasDismissButton: false,
                duration: const Duration(milliseconds: 1500));
          }
        } on DioError catch (e) {
          final errorMessage = _apiClient.mapDioErrorToMessage(e);
          log(errorMessage);
        } finally {
          isLoading(false);
        }
      }
    } on DioError catch (e) {
      final errorMessage = _apiClient.mapDioErrorToMessage(e);
      log(errorMessage);
    } finally {
      isLoading(false);
    }
  }

  handleUploadImageGallery(ImageSource source) async {
    isLoading(true);
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

    final images = await _picker.pickMultiImage();
    if (images == null) {
      isLoading(false);
      return;
    }
    await Future.forEach(images, (XFile image) async {
      final fileExtension = p.extension(image.path).replaceAll('.', '');
      if (fileExtension != 'png' &&
          fileExtension != 'jpg' &&
          fileExtension != 'jpeg') {
        log("định dạng ảnh không được hỗ trợ");
        isLoading(false);
      }
      try {
        final generateImageUrlResponse = await _apiClient.generateImageUrl(
          GenerateAwsImageRequest(fileType: fileExtension),
        );
        final localImage = LocalImage(
          name: image.name,
          resource: image.path,
          awsImage: generateImageUrlResponse.awsImage,
        );
        listLocalImagesUpload.add(localImage);
      } on DioError catch (e) {
        final errorMessage = _apiClient.mapDioErrorToMessage(e);
        log(errorMessage);
      }
    });

    listLocalImagesUpload.removeWhere((element) =>
        element.awsImage.uploadUrl == null ||
        element.awsImage.uploadUrl!.isEmpty);

    final uploadResult = await Future.wait(
      listLocalImagesUpload
          .map(
            (e) => _apiClient.uploadImage(
              e.awsImage.uploadUrl!,
              File(e.resource!),
            ),
          )
          .toList(),
    );
    if (uploadResult.every((element) => element)) {
      try {
        final listImageUpload =
            listLocalImagesUpload.map((e) => e.awsImage.downloadUrl).toList();

        final request =
            UpdateServiceItemGalleryRequest(images: listImageUpload);
        final response =
            await _apiClient.updateServiceGallery(serviceItemId.value, request);
        if (response.status == 200) {
          listGalleryImage.value = response.data!;
          getIt.get<IToast>().show(
              title: 'updateSuccess'.tr,
              message: 'updateSuccess'.tr,
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1500));
        } else {
          getIt.get<IToast>().show(
              title: 'updateFailed'.tr,
              message: 'updateFailed'.tr,
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1500));
        }
      } on DioError catch (e) {
        final errorMessage = _apiClient.mapDioErrorToMessage(e);
        log(errorMessage);
      } finally {
        isLoading(false);
      }
    }
  }
}
