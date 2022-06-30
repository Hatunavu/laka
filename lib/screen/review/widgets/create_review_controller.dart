import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/review/create/create_review_request/create_review_request.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:path/path.dart' as path;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:client_tggt/model/review/review_model.dart';

class CreateReviewController extends GetxController {
  final textfieldController = TextEditingController();
  var orderID = ''.obs;
  var rating = 3.0.obs;
  final isNotPermission = false.obs;
  final isLoading = false.obs;
  final isLoadingUpdateImage = false.obs;
  final _picker = ImagePicker();
  final ApiClient _apiClient;
  final listImage = <String>[].obs;
  var isReviewed = false.obs;
  final review = ReviewModel(
          order: ReviewOrderModel(
              chatRoomId: "",
              orderId: "",
              status: BookingStatus.pending,
              product: OrderProductModel(name: "", price: 0)),
          reviewer: AccountModel(),
          rating: 0,
          createdAt: DateTime.now())
      .obs;
  final initialRating = 3.obs;
  CreateReviewController(this._apiClient);

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

    if (source == ImageSource.gallery) {
      final images = await _picker.pickMultiImage();

      if (images == null) {
        isLoading(false);
        return;
      }

      for (var image in images) {
        final fileExtension = path.extension(image.path).replaceAll('.', '');
        _uploadImage(fileExtension, image);
      }
    } else {
      final image = await _picker.pickImage(source: source);

      if (image == null) {
        isLoading(false);
        return;
      }
      final fileExtension = path.extension(image.path).replaceAll('.', '');
      _uploadImage(fileExtension, image);
    }
  }

  checkIsReview(ReviewModel? review) {
    if (review == null) {
      isReviewed.value = false;
    } else {
      isReviewed.value = true;
      this.review.value = review;
      textfieldController.text = this.review.value.content ?? '';
      initialRating.value = (this.review.value.rating).toInt();
    }
  }

  Future<void> _uploadImage(String fileExtension, XFile image) async {
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
        listImage.add(generateImageUrlResponse.awsImage.downloadUrl);
      }
    } on DioError catch (e) {
      final errorMessage = _apiClient.mapDioErrorToMessage(e);
      log(errorMessage);
    }
  }

  Future<bool> sendReview() {
    final requestData = CreateReviewRequest(
        content: textfieldController.text,
        rating: rating.value,
        gallery: listImage);
    return _postCreateReview(orderID.value, requestData);
  }

  Future<bool> _postCreateReview(
      String orderID, CreateReviewRequest data) async {
    try {
      isLoading(true);
      var response = await _apiClient.postCreateReviewForOrder(orderID, data);
      if (response.status == 200) {
        if (response.data != null) {
          return true;
        }
        return false;
      }
      return false;
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isLoading(false);
    }
  }
}
