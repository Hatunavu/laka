import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/review/list_review_response/data.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReviewController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final isLoading = false.obs;
  final isEmpty = false.obs;
  final listReview = Data().obs;
  var vendorId = '';
  var limit = 30;
  var page = 1;

  final ApiClient _apiClient;

  ReviewController(this._apiClient);

  @override
  void onClose() {
    super.onClose();
  }

  void onRefresh() async {
    // monitor network fetch
    page = 1;
    _getListReview(limit, page, false);
    // if failed,use refreshFailed()
  }

  void onLoading() async {
    // monitor network fetch
    page += 1;
    _getListReview(limit, page, true);
  }

  _getListReview(int limit, int page, bool isLoadMore) async {
    try {
      isLoading(true);
      var response = await _apiClient.getListReview(vendorId, limit, page);
      if (response.status == 200) {
        if (response.data != null) {
          if (response.data!.docs!.isNotEmpty) {
            if (isLoadMore) {
              listReview.value.docs!.addAll(response.data!.docs!);
              listReview.refresh();
              refreshController.loadComplete();
            } else {
              listReview.value = response.data!;
              refreshController.refreshCompleted();
            }
          } else {
            if (isLoadMore) {
              refreshController.loadNoData();
            } else {
              listReview.value = response.data!;
            }
          }
        } else {
          refreshController.loadFailed();
          refreshController.refreshFailed();
        }
      } else {}
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }
}
