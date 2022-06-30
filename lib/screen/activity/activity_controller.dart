import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:get/get.dart';

class ActivityController extends GetxController {
  // var listActivity = Data().obs;
  var listOrdering = <BookingItemModel>[].obs;
  var categoryValue = "Dịch vụ".obs;
  var statusParam =
      "${BookingStatus.pending.getType()},${BookingStatus.confirmed.getType()},${BookingStatus.checkedIn.getType()}}"
          .obs;

  var pendingCount = 0.obs;
  RxList<CategoryType> selectedCategory = RxList<CategoryType>();

  var isOrderTab = true;
  var isLoading = false.obs;
  final ApiClient _apiClient;
  var limit = 15;
  var page = 1.obs;
  var cats = "".obs;
  final totalDocs = 0.obs;
  final waitingReviews = 0.obs;
  final totalOrderActive = 0.obs;

  final tabIndex = 0.obs;
  final listAttribute = <AttributeModel>[].obs;
  final listSelectedAttribute = <AttributeModel>[].obs;
  final selectedOrderStatus = "".obs;
  ActivityController(this._apiClient);

  @override
  void onInit() {
    super.onInit();
  }

  final List<CategoryType> listCategory = [
    CategoryType.bar,
    CategoryType.karaoke,
    CategoryType.massage,
    CategoryType.restaurant,
  ];

  final List<String> listOrderStatusType = [
    "all",
    BookingStatus.canceled.getType(),
    BookingStatus.completed.getType(),
    BookingStatus.reviewed.getType()
  ];

  handleChangeTapIndex(int index) {
    tabIndex.value = index;
    cats.value = "";
    selectedCategory.value = [];
    selectedOrderStatus.value = "";

    if (index == 0) {
      var status =
          "${BookingStatus.pending.getType()},${BookingStatus.confirmed.getType()},${BookingStatus.checkedIn.getType()}";
      statusParam.value = status;
      page.value = 1;
      getListOrder(1, status, "");
    } else if (index == 1) {
      var status =
          "${BookingStatus.canceled.getType()},${BookingStatus.completed.getType()},${BookingStatus.reviewed.getType()}";
      ;
      statusParam.value = status;
      page.value = 1;
      getListOrder(1, status, "");
    } else if (index == 2) {
      var status = BookingStatus.completed.getType();
      statusParam.value = status;
      page.value = 1;
      getListOrder(1, status, "");
    }
  }

  handleUpdateListSelectedCategory(List<CategoryType> categories) {
    selectedCategory.value = categories;
    var categoriesListString = "";
    for (var element in categories) {
      if (categoriesListString == "") {
        categoriesListString = element.getType();
      } else {
        categoriesListString = categoriesListString + "," + element.getType();
      }
    }
    cats.value = categoriesListString;
    getListOrder(1, selectedOrderStatus.value, categoriesListString);
  }

  handleUpdateSelectedStatus(String status) {
    selectedOrderStatus.value = status;
    getListOrder(1, status == "all" ? "" : status, "");
  }

  getListOrder(int page, String status, String categories) async {
    try {
      isLoading(true);
      var response =
          await _apiClient.getListOrders(limit, page, categories, status);
      if (response.status == 200) {
        final data = response.data;
        if (data == null) {
          listOrdering.value = [];
        } else {
          listOrdering.value = data.docs ?? [];
          totalDocs.value = data.totalDocs ?? 0;
          waitingReviews.value = data.waitingReviews ?? 0;
          totalOrderActive.value = data.totalOrderActive ?? 0;
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }
}
