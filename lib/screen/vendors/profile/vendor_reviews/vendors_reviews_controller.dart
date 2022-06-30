import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/review/enum_review_type.dart';
import 'package:client_tggt/model/review/review_model.dart';
import 'package:client_tggt/model/review/vendors/vendors_reply_review_request.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorsReviewController extends GetxController {
  final String title = "vendors_reviews";
  final ApiClient _apiClient;
  final limit = 30.obs;
  final page = 1.obs;
  final totalPage = 0.obs;
  final isLoading = false.obs;
  final isFilterLoading = false.obs;
  final reviewType = ReviewType.all.obs;
  final replyTextController = TextEditingController(text: "").obs;
  final isLoadingReply = false.obs;

  VendorsReviewController(this._apiClient);

  final listReviews = <ReviewModel>[].obs;
  final listReviewType = [
    ReviewType.all.display(),
    ReviewType.media.display(),
    ReviewType.content.display()
  ];

  final listReivewRating = [
    ReviewType.star_5.display(),
    ReviewType.star_4.display(),
    ReviewType.star_3.display(),
    ReviewType.star_2.display(),
    ReviewType.star_1.display(),
  ];

  // final ratingInfo = <RatingModel>[].obs;
  final ratingInfo =
      RatingModel(star_1: 0, star_2: 0, star_3: 0, star_4: 0, star_5: 0).obs;

  @override
  void onInit() {
    getListReivews(limit.value, page.value, ReviewType.all.getType());
    super.onInit();
  }

  handleChangeReviewType(ReviewType type) {
    reviewType.value = type;
    page.value = 1;
    handleFilterReview(limit.value, 1, type.getType());
  }

  handleCreateReply(String reviewId) async {
    final request =
        VendorsReplyReviewRequest(content: replyTextController.value.text);
    try {
      isFilterLoading.value = true;
      final response = await _apiClient.vendorsReplyComment(reviewId, request);
      if (response.status == 200) {
        final data = response.data;
        final index =
            listReviews.indexWhere((element) => element.id == reviewId);
        if (data != null) {
          listReviews[index] = data;
          getIt.get<IToast>().show(
              title: 'Thông báo',
              message: 'Trả lời thành công',
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1000));
        } else {
          getIt.get<IToast>().show(
              title: 'Thông báo',
              message: 'Đã có lỗi xảy ra',
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1000));
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isFilterLoading.value = false;
    }
  }

  handleFilterReview(limit, page, type) async {
    try {
      isFilterLoading.value = true;
      final response =
          await _apiClient.vendorsGetListReviews(limit, page, type);
      if (response.status == 200) {
        final data = response.data;
        listReviews.value = data!.reviews.docs ?? [];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isFilterLoading.value = false;
    }
  }

  getListReivews(limit, page, type) async {
    try {
      isLoadingReply.value = true;
      final response =
          await _apiClient.vendorsGetListReviews(limit, page, type);
      if (response.status == 200) {
        final data = response.data;
        listReviews.value = data!.reviews.docs ?? [];
        ratingInfo.value = data.ratings;
        totalPage.value = data.reviews.totalDocs ?? 0;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadingReply.value = false;
    }
  }
}
