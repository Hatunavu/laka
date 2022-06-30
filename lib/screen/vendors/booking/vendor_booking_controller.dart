import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/model/search/debounce.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorBookingController extends GetxController {
  final String title = "vendor_booking";
  final isLoading = false.obs;
  final selectedIndex = 0.obs;
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;
  final RxList<BookingItemModel> listBooking = RxList<BookingItemModel>();
  final totalDocs = 0.obs;
  final limit = 20.obs;
  final page = 1.obs;
  final ApiClient _apiClient;
  VendorBookingController(this._apiClient);
  ScrollController listViewBookingController = ScrollController();
  final status = "".obs;
  final searchText = TextEditingController(text: "").obs;
  final _debounce = Debounce(milliseconds: 1000);

  final listStatus = [
    "Tất cả",
    BookingStatus.pending.display(),
    BookingStatus.confirmed.display(),
    BookingStatus.checkedIn.display(),
    BookingStatus.completed.display(),
    BookingStatus.canceled.display()
  ].obs;
  @override
  void onInit() {
    getDateTime();
    listViewBookingController.addListener(listenLoadMoreList);
    super.onInit();
  }

  getDateTime() {
    final getMiniseconds =
        DateTime.now().millisecondsSinceEpoch - (86400000 * 30);
    final DateTime date2 = DateTime.fromMillisecondsSinceEpoch(getMiniseconds);
    startDate.value = date2;
    endDate.value = DateTime.now();
  }

  listenLoadMoreList() {
    if (listViewBookingController.offset ==
        listViewBookingController.position.maxScrollExtent) {
      if (listBooking.length < totalDocs.value) {
        getMoreListBooking();
      }
    }
  }

  @override
  void dispose() {
    _debounce.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    _debounce.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.onClose();
  }

  handleSearchText(String text) {
    _debounce.run(() async {
      try {
        // isEmptyResult(false);
        isLoading(true);
        // var response = await _apiClient.getVendorByText(text);
        var response = await _apiClient.getListBooking(
            status.value, text, "", "", limit.value, page.value);
        inspect(response);
        if (response.status == 200) {
          totalDocs.value = response.data!.totalDocs!;
          listBooking.value = response.data!.docs!;
        } else {
          log("da co loi xay ra");
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        isLoading(false);
      }
    });
  }

  getMoreListBooking() async {
    try {
      final response = await _apiClient.getListBooking(status.value,
          searchText.value.text, "", "", limit.value, page.value + 1);
      if (response.status == 200) {
        page.value = page.value + 1;
        totalDocs.value = response.data!.totalDocs!;
        listBooking.value = [...listBooking, ...response.data!.docs!];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {}
  }

  getListBooking(String? status, String? startDate, String? endDate, int limit,
      int page) async {
    try {
      isLoading(true);
      final response = await _apiClient.getListBooking(
          status, searchText.value.text, startDate, endDate, limit, page);
      if (response.status == 200) {
        totalDocs.value = response.data!.totalDocs!;
        listBooking.value = response.data!.docs!;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleUpdateListBooking(BookingItemModel item) {
    // log(limit.value.toString());

    final newList = listBooking.map((element) {
      if (element.id == item.id) return item;
      return element;
    }).toList();
    inspect(newList);
    listBooking.value = newList;
  }

  handleChangeSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  handleChangeStatusListBooking() {
    page.value = 1;
    switch (selectedIndex.value) {
      case 0:
        status.value = "";
        searchText.value.text = "";

        getListBooking("", '$startDate', '$endDate', limit.value, 1);
        Get.find<RouterController>().back();
        return;
      case 1:
        status.value = BookingStatus.pending.display();
        searchText.value.text = "";

        getListBooking(BookingStatus.pending.getType(), '$startDate',
            '$endDate', limit.value, 1);
        Get.find<RouterController>().back();
        return;
      case 2:
        status.value = BookingStatus.confirmed.display();
        searchText.value.text = "";

        getListBooking(BookingStatus.confirmed.getType(), '$startDate',
            '$endDate', limit.value, 1);
        Get.find<RouterController>().back();
        return;
      case 3:
        status.value = BookingStatus.checkedIn.display();
        searchText.value.text = "";
        getListBooking(BookingStatus.checkedIn.getType(), '$startDate',
            '$endDate', limit.value, 1);
        Get.find<RouterController>().back();
        return;
      case 4:
        status.value = BookingStatus.completed.display();
        searchText.value.text = "";
        getListBooking(BookingStatus.completed.getType(), '$startDate',
            '$endDate', limit.value, 1);
        Get.find<RouterController>().back();
        return;
      case 5:
        status.value = BookingStatus.canceled.display();
        searchText.value.text = "";
        getListBooking(BookingStatus.canceled.getType(), '$startDate',
            '$endDate', limit.value, 1);
        Get.find<RouterController>().back();
        return;
    }
  }

  handleChangeStartDate(DateTime date) {
    searchText.value.text = "";
    startDate.value = date;
  }

  handleChangeEndDate(DateTime date) {
    searchText.value.text = "";
    endDate.value = date;
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
