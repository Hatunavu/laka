import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/admin_page/orders/order_detail/admin_update_order_request.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/model/vendor_page/booking/update_booking_request.dart';
import 'package:client_tggt/router/app_router.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminOrderDetailController extends GetxController {
  final String title = "admin order item";
  final isLoading = false.obs;
  AdminOrderDetailController(this._apiClient);
  final ApiClient _apiClient;
  final bookingId = "".obs;
  final parentPage = "".obs;
  final statusResponse = 0.obs;
  final orderAt = DateTime.now().obs;
  final cancelController = TextEditingController(text: "").obs;

  final bookingDetail = BookingItemModel(status: BookingStatus.pending).obs;
  // final VendorBookingController bookingController =
  //     VendorBookingController(getIt.get<ApiClient>());
  final VendorMainController mainController =
      VendorMainController(getIt.get<ApiClient>());
  final isUpdateLoading = false.obs;
  final isUpdateBooking = false.obs;
  final totalPrice = TextEditingController(text: "").obs;

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

  handlegetBookingDetail(String id) {
    bookingId.value = id;
  }

  handleCloseUpdateTime() {
    orderAt.value = DateTime.parse('${bookingDetail.value.orderAt!}');
  }

  getOrderDetail(String orderId) async {
    try {
      isLoading(true);
      final response = await _apiClient.adminGetOrderDetail(orderId);
      if (response.status == 200) {
        bookingDetail.value = response.data!;
        orderAt.value = DateTime.parse('${response.data!.orderAt!}');
        statusResponse.value = 1;
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

  Future<bool> handleUpdateBooking(BookingStatus status, bool isCancel) async {
    try {
      isUpdateLoading(true);
      final request = AdminUpdateOrdersRequest(status: status.toJsonString());
      final response =
          await _apiClient.adminUpdateOrder(request, bookingDetail.value.id!);
      if (response.status == 200) {
        isUpdateBooking.value = true;
        bookingDetail.value = response.data!;
        return true;
      } else {
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isUpdateLoading(false);
    }
  }

  Future<bool> handleUpdateComplete(
      String totalPrice, String discountPercent, List<String> images) async {
    try {
      isUpdateLoading(true);
      final CompleteBookingRequest request = CompleteBookingRequest(
          totalPrice: double.parse(totalPrice),
          images: images,
          discountPercent:
              (discountPercent == "") ? 0 : double.parse(discountPercent),
          voucherCode: "");
      final response =
          await _apiClient.adminCompleteOrder(bookingDetail.value.id!, request);
      if (response.status == 200) {
        bookingDetail.value = response.data!;
        isUpdateBooking.value = true;
        return true;
      } else {
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isUpdateLoading(false);
    }
  }
}
