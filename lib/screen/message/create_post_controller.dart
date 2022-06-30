import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/aws_image/local_image.dart';
import 'package:client_tggt/model/newfeed/post/create_new_post_request.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class CreatePostController extends GetxController {
  final String title = "create post";
  final isLoading = false.obs;
  final isLoadingPick = false.obs;
  final isLoadingPost = false.obs;
  List<VendorModel> listSelectedVendors = <VendorModel>[].obs;

  final ApiClient _apiClient;
  CreatePostController(this._apiClient);
  final listLocalImage = <GalleryModel>[].obs;
  var listLocalImagesUpload = <LocalImagePick>[].obs;
  final contentPost = TextEditingController(text: "").obs;
  final isCreatePost = false.obs;
  final listLocalImages = <LocalImage>[].obs;
  final listTags = <TagsRequest>[].obs;

  final _picker = ImagePicker();
  final curentImageLength = ValueNotifier(0).obs;

  handleUploadImageGallery(ImageSource source, bool multiple) async {
    isLoadingPick(true);
    final permission =
        source == ImageSource.camera ? Permission.camera : Permission.photos;
    if (multiple == false) {
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
    } else {
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
        isLoading(false);
      }
      File imageTest = File(image.path);
      var decodedImage = await decodeImageFromList(imageTest.readAsBytesSync());

      listLocalImagesUpload.add(LocalImagePick(
          name: image.name,
          resource: image.path,
          fileType: fileExtension,
          type: "image",
          dimensions: DimensionsModel(
              width: decodedImage.width, height: decodedImage.height)));
      final localImageShow = GalleryModel(
          path: image.path,
          type: "image",
          dimensions: DimensionsModel(
              width: decodedImage.width, height: decodedImage.height));

      listLocalImage.add(localImageShow);
      isLoadingPick(false);
      isCreatePost.value = true;
      curentImageLength.value = ValueNotifier(listLocalImage.length);
    }
  }

  handleUpdateSelectedVendor(List<VendorModel> vendors) {
    listSelectedVendors = vendors;
    listTags.value = vendors
        .map((e) =>
            TagsRequest(type: AccountType.vendor.getType(), vendor: e.id ?? ""))
        .toList();
  }

  handleUploadVideoGallery(ImageSource source) async {
    isLoadingPick(true);
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
    final video = await _picker.pickVideo(source: source);
    if (video == null) {
      isLoadingPick(false);
      return;
    }

    final fileExtension = p.extension(video.path).replaceAll('.', '');
    var findVideo =
        listLocalImagesUpload.where((item) => item.type != "video").toList();
    final file = await TGGTUtils().generateVideoThumbnail(video.path);
    var decodedImage = await decodeImageFromList(file.readAsBytesSync());
    var newVideoUpload = LocalImagePick(
        name: video.name,
        resource: video.path,
        fileType: fileExtension,
        dimensions: DimensionsModel(
            width: decodedImage.width, height: decodedImage.height),
        type: "video");

    listLocalImagesUpload.value = [newVideoUpload, ...findVideo];
    var newListLocalImage =
        listLocalImage.where((p0) => p0.type != "video").toList();
    var newLocalImage = GalleryModel(
        path: video.path,
        type: "video",
        dimensions: DimensionsModel(
            width: decodedImage.width, height: decodedImage.height));
    listLocalImage.value = [newLocalImage, ...newListLocalImage];
    isLoadingPick(false);
    isCreatePost.value = true;
    curentImageLength.value = ValueNotifier(listLocalImage.length);
  }

  handleRemoveLocalImage(String path) {
    final newlist = listLocalImage.where((item) => item.path != path).toList();
    listLocalImage.value = newlist;
    if (newlist.isEmpty) {
      isCreatePost.value = false;
    }
  }

  handleCreatePost() async {
    isLoadingPost.value = true;

    final content = contentPost.value.text;
    await Future.forEach(listLocalImagesUpload, (LocalImagePick media) async {
      try {
        final generateImageUrlResponse = await _apiClient.generatePostImageUrl(
          GenerateAwsImageRequest(fileType: media.fileType),
        );
        final localImage = LocalImage(
            name: media.name,
            resource: media.resource,
            awsImage: generateImageUrlResponse.awsImage,
            dimensions: media.dimensions,
            type: media.type);
        listLocalImages.add(localImage);
      } on DioError catch (e) {
        final errorMessage = _apiClient.mapDioErrorToMessage(e);
        log(errorMessage);
      }
    });

    listLocalImages.removeWhere((element) =>
        element.awsImage.uploadUrl == null ||
        element.awsImage.uploadUrl!.isEmpty);
    final uploadResult = await Future.wait(
      listLocalImages
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
        final listImageUpload = listLocalImages
            .map((e) => UploadMediaModel(
                url: e.awsImage.downloadUrl,
                width: e.dimensions == null ? null : e.dimensions!.width,
                height: e.dimensions == null ? null : e.dimensions!.height))
            .toList();

        final request = CreateNewPostRequest(
            content: content, uploadMedia: listImageUpload, tags: listTags);
        final response = await _apiClient.createNewPost(request);
        if (response.status == 200) {
          getIt.get<IToast>().show(
              title: "createShareSuccess".tr,
              message: "createShareSuccess".tr,
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1500));
          Get.find<RouterController>().back();
        } else {
          getIt.get<IToast>().show(
              title: "error".tr,
              message: "error".tr,
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1500));
          Get.find<RouterController>().back();
        }
      } on DioError catch (e) {
        final errorMessage = _apiClient.mapDioErrorToMessage(e);
        log(errorMessage);
      } finally {
        isLoadingPost(false);
      }
    }
  }

  hanleUpdateStatusCreatePost(bool status) {
    isCreatePost.value = status;
  }
}
