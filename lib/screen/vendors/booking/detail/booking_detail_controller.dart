import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/update_menu_order_request.dart';
import 'package:client_tggt/model/vendor_page/booking/sub_fee/add_subfee_order_request.dart';
import 'package:client_tggt/model/vendor_page/booking/sub_fee/sub_fee_model.dart';
import 'package:client_tggt/model/vendor_page/booking/update_booking_request.dart';
import 'package:client_tggt/router/app_router.dart';
import 'package:client_tggt/screen/vendors/booking/vendor_booking_controller.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailController extends GetxController {
  final String title = "service item";
  final isLoading = false.obs;
  BookingDetailController(this._apiClient);
  final ApiClient _apiClient;
  final bookingId = "".obs;
  final parentPage = "".obs;
  final statusResponse = 0.obs;
  final orderAt = DateTime.now().obs;
  final cancelController = TextEditingController(text: "").obs;
  final listMenu = <SelectedMenuItemModel>[].obs;
  final listSubFee = <SubFeeModel>[].obs;

  final Rx<BookingItemModel> bookingDetail =
      BookingItemModel(status: BookingStatus.pending).obs;
  // final VendorBookingController bookingController =
  //     VendorBookingController(getIt.get<ApiClient>());
  final VendorMainController mainController =
      VendorMainController(getIt.get<ApiClient>());
  final isUpdateLoading = false.obs;
  final isUpdateBooking = false.obs;
  final totalPrice = TextEditingController(text: "").obs;

  @override
  void onReady() {
    final userToken = AccountServices().getUserToken();
    getBookingDetail(bookingId.value);
    super.onReady();
  }

  handleChangeOrderTime(DateTime date, String type) {
    if (type == "date") {
      final dateTime = date.toString().split(" ")[0];
      final time = orderAt.toString().split(" ")[1];
      String dateTimeString = dateTime + " " + time;
      DateTime newOrderTime = DateTime.parse(dateTimeString);
      orderAt.value = newOrderTime;
    }
    if (type == "time") {
      final time = date.toString().split(" ")[1];
      final dateTime = orderAt.toString().split(" ")[0];
      String dateTimeString = dateTime + " " + time;
      DateTime newOrderTime = DateTime.parse(dateTimeString);
      orderAt.value = newOrderTime;
    }
  }

  handlegetBookingDetail(String id, String page) {
    bookingId.value = id;
    parentPage.value = page;
  }

  handleCloseUpdateTime() {
    orderAt.value = DateTime.parse('${bookingDetail.value.orderAt!}');
  }

  getBookingDetail(String bookingId) async {
    try {
      isLoading(true);
      final response = await _apiClient.getBookingDetail(bookingId);
      if (response.status == 200) {
        bookingDetail.value = response.data!;
        orderAt.value = DateTime.parse('${response.data!.orderAt!}');
        statusResponse.value = 1;
        if (response.data!.menuItems != null) {
          listMenu.value = response.data!.menuItems ?? [];
        }
        if (response.data!.subFees != null) {
          listSubFee.value = response.data!.subFees ?? [];
        }
      } else if (response.status == 400) {
        statusResponse.value = 2;
      } else if (response.status == 404) {
        statusResponse.value = 2;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleUpdateOrderTime() async {
    try {
      isUpdateLoading(true);
      final UpdateBookingRequest request =
          UpdateBookingRequest(orderAt: orderAt.value.toString());
      final response = await _apiClient.putVendorUpdateBooking(
          bookingDetail.value.id!, request);
      if (response.status == 200) {
        bookingDetail.value = response.data!;
        // if (parentPage.value == "booking_list") {
        //   bookingController.handleUpdateListBooking(response.data!);
        // } else if (parentPage.value == "qrcode") {
        //   // Get.toNamed(AppRoutes.vendorListScreen);
        //   Get.find<RouterController>().toNamed(AppRoutes.vendorListScreen);
        // }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isUpdateLoading(false);
      Get.find<RouterController>().back();
    }
  }

  handleUpdateBooking(BookingStatus status, bool isCancel) async {
    try {
      isUpdateLoading(true);
      final UpdateBookingRequest request = UpdateBookingRequest(
          status: status.toJsonString(),
          cancelNote: isCancel == true ? cancelController.value.text : "");
      final response = await _apiClient.putVendorUpdateBooking(
          bookingDetail.value.id!, request);
      if (response.status == 200) {
        bookingDetail.value = response.data!;
        if (parentPage.value == "booking_list") {
          isUpdateBooking.value = true;
          // bookingController.handleUpdateListBooking(response.data!);
        } else if (parentPage.value == "qrcode") {
          //Get.toNamed(AppRoutes.vendorListScreen);
          Get.find<RouterController>().toNamed(AppRoutes.vendorListScreen);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isUpdateLoading(false);
    }
  }

  handleUpdateComplete(
      String totalPrice, String discountPercent, List<String> images) async {
    try {
      isUpdateLoading(true);
      final CompleteBookingRequest request = CompleteBookingRequest(
          totalPrice: double.parse(totalPrice),
          images: images.isEmpty ? null : images,
          discountPercent:
              (discountPercent == "") ? 0 : double.parse(discountPercent),
          voucherCode: "");
      final response = await _apiClient.putVendorCompleteBooking(
          bookingDetail.value.id!, request);
      if (response.status == 200) {
        bookingDetail.value = response.data!;
        if (parentPage.value == "booking_list") {
          isUpdateBooking.value = true;
          // bookingController.handleUpdateListBooking(response.data!);
        } else if (parentPage.value == "qrcode") {
          //Get.toNamed(AppRoutes.vendorListScreen);
          Get.find<RouterController>().toNamed(AppRoutes.vendorListScreen);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isUpdateLoading(false);
    }
  }

  handleUpdateBillImage(List<String> images) async {
    try {
      isUpdateLoading(true);
      final UpdateBillOrderRequest request = UpdateBillOrderRequest(
        images: images,
      );
      final response =
          await _apiClient.updateBillOrder(bookingDetail.value.id!, request);
      if (response.status == 200) {
        bookingDetail.value = response.data!;
        if (parentPage.value == "booking_list") {
          isUpdateBooking.value = true;
          // bookingController.handleUpdateListBooking(response.data!);
        } else if (parentPage.value == "qrcode") {
          //Get.toNamed(AppRoutes.vendorListScreen);
          Get.find<RouterController>().toNamed(AppRoutes.vendorListScreen);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isUpdateLoading(false);
    }
  }

  handleUpdateListSelectedMenu(List<SelectedMenuItemModel> list) async {
    try {
      isUpdateLoading(true);
      listMenu.value = list;
      final listItem = listMenu
          .map((e) => UpdateMenuInOrderData(id: e.item.id, amount: e.amount))
          .toList();
      final UpdateMenuInOrderRequest request =
          UpdateMenuInOrderRequest(items: listItem);
      final response =
          await _apiClient.updateMenuOrders(bookingDetail.value.id!, request);
      if (response.status == 200) {
        bookingDetail.value = response.data!;
        if (parentPage.value == "booking_list") {
          isUpdateBooking.value = true;
          // bookingController.handleUpdateListBooking(response.data!);
        } else if (parentPage.value == "qrcode") {
          //Get.toNamed(AppRoutes.vendorListScreen);
          Get.find<RouterController>().toNamed(AppRoutes.vendorListScreen);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isUpdateLoading(false);
    }
  }

  handleUpdateSubFee(String name, double price, String note) async {
    try {
      isUpdateLoading(true);
      final UpdateSubFeeOrderRequest request = UpdateSubFeeOrderRequest(items: [
        UpdateSubFeeInOrderData(name: name, price: price, note: note)
      ]);
      final response =
          await _apiClient.updateSubfeeOrders(bookingDetail.value.id!, request);
      if (response.status == 200) {
        bookingDetail.value = response.data!;
        listSubFee.value = response.data!.subFees ?? [];
        if (parentPage.value == "booking_list") {
          isUpdateBooking.value = true;
          // bookingController.handleUpdateListBooking(response.data!);
        } else if (parentPage.value == "qrcode") {
          //Get.toNamed(AppRoutes.vendorListScreen);
          Get.find<RouterController>().toNamed(AppRoutes.vendorListScreen);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isUpdateLoading(false);
    }
  }
}
