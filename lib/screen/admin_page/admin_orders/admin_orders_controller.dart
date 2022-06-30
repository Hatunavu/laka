import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/search/debounce.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class AdminOrdersController extends GetxController {
  final String title = "admin_order_controller";
  final isLoading = false.obs;
  final selectedIndex = 0.obs;
  final listBooking = <BookingItemModel>[].obs;
  final totalDocs = 0.obs;
  final page = 1.obs;
  final tabIndex = 0.obs;
  final ApiClient _apiClient;
  AdminOrdersController(this._apiClient);
  ScrollController listViewBookingController = ScrollController();
  final status = "".obs;
  final startDate = "".obs;
  final endDate = "".obs;
  final searchText = TextEditingController(text: "").obs;
  final vendorStatus = "".obs;
  final province = "".obs;
  final district = "".obs;
  final cats = "".obs;
  final selectedCategory = <CategoryType>[].obs;
  final List<CategoryType> listCategory = [
    CategoryType.bar,
    CategoryType.karaoke,
    CategoryType.massage,
    CategoryType.restaurant,
  ];

  final isVisible = true.obs;
  final isShowFilter = false.obs;
  final _debounce = Debounce(milliseconds: 1000);

  // final listStatus = [
  //   "Tất cả",
  //   BookingStatus.pending.display(),
  //   BookingStatus.confirmed.display(),
  //   BookingStatus.checkedIn.display(),
  //   BookingStatus.completed.display(),
  //   BookingStatus.canceled.display()
  // ].obs;

  final List<String> listStatus = [
    "all",
    BookingStatus.pending.getType(),
    BookingStatus.confirmed.getType(),
    BookingStatus.checkedIn.getType(),
    BookingStatus.completed.getType(),
    BookingStatus.canceled.getType(),
  ];
  final selectedOrderStatus = "".obs;

  @override
  void onInit() {
    listViewBookingController.addListener(() {
      final direction = listViewBookingController.position.userScrollDirection;
      if (direction == ScrollDirection.forward) {
        show();
      } else if (direction == ScrollDirection.reverse) {
        hide();
      }

      if (listViewBookingController.offset ==
          listViewBookingController.position.maxScrollExtent) {
        if (listBooking.length < totalDocs.value) {
          getMoreOrders();
        }
      }
    });
    getListOrders(1, "", "", "", "", "", "", "", "");

    super.onInit();
  }

  handleChangeTab(int index) {
    searchText.value.text = "";
    tabIndex.value = index;
    isShowFilter.value = false;
    selectedCategory.value = [];
    selectedOrderStatus.value = "";

    if (index == 0) {
      getListOrders(1, "", "", "", "", "", "", "", "");
      vendorStatus.value = "";
    } else if (index == 1) {
      getListOrders(1, "", "", "1", "", "", "", "", "");
      vendorStatus.value = "1";
    } else if (index == 2) {
      getListOrders(1, "", "", "0", "", "", "", "", "");
      vendorStatus.value = "0";
    }
  }

  show() {
    if (isVisible.isFalse) {
      isVisible.value = true;
    }
  }

  hide() {
    if (isVisible.isTrue) {
      isVisible.value = false;
    }
  }

  getListOrders(
    int page,
    String? status,
    String text,
    String vendorStatus,
    String province,
    String district,
    String category,
    String? startDate,
    String? endDate,
  ) async {
    try {
      isLoading(true);
      final response = await _apiClient.adminGetListOrders(page, status, text,
          vendorStatus, province, district, category, startDate, endDate);
      if (response.status == 200) {
        totalDocs.value = response.data.totalDocs!;
        listBooking.value = response.data.docs!;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  getMoreOrders() async {
    try {
      final newPage = page.value + 1;
      final response = await _apiClient.adminGetListOrders(
          newPage,
          status.value,
          searchText.value.text,
          vendorStatus.value,
          province.value,
          district.value,
          cats.value,
          startDate.value,
          endDate.value);
      if (response.status == 200) {
        final data = response.data.docs!;
        listBooking.value = [...listBooking, ...data];
      }
    } on Exception catch (err) {
      log("err $err");
    }
  }

  handleSearchText(String text) {
    _debounce.run(() async {
      getListOrders(
          1, "", searchText.value.text, vendorStatus.value, "", "", "", "", "");
    });
  }

  handleUpdateListSelectedCategory(List<CategoryType> categories) {
    selectedCategory.value = categories;
    var categoriesListString = "";
    for (var element in categories) {
      if (categoriesListString == "") {
        categoriesListString = element.getType();
      } else {
        categoriesListString = cats + "," + element.getType();
      }
    }
    cats.value = categoriesListString;
    page.value = 1;
    getListOrders(
        1,
        status.value,
        searchText.value.text,
        vendorStatus.value,
        province.value,
        district.value,
        categoriesListString,
        startDate.value,
        endDate.value);
  }

  handleUpdateSelectedStatus(String statusOrder) {
    selectedOrderStatus.value = statusOrder == "all" ? "" : statusOrder;
    page.value = 1;

    getListOrders(
        1,
        statusOrder == "all" ? "" : statusOrder,
        searchText.value.text,
        vendorStatus.value,
        province.value,
        district.value,
        cats.value,
        startDate.value,
        endDate.value);
  }
}
