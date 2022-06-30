import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/message/get_list_message_response.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/order/update_order/update_staff_order_request.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';

import 'package:get/get.dart';

class CustomerStaffController extends GetxController {
  final String title = "customer_staff";
  final isLoading = false.obs;
  final limit = 20.obs;
  final page = 0.obs;
  final listStaff = <StaffModel>[].obs;
  final listSelectedStaff = <StaffModel>[].obs;
  final isLoadingConfirm = false.obs;
  final orderId = "".obs;
  final orderData = BookingItemModel(status: BookingStatus.pending).obs;
  final ApiClient _apiClient;
  CustomerStaffController(this._apiClient);

  getListStaff(String vendorId) async {
    try {
      isLoading.value = true;
      final response = await _apiClient.customerGetListStaff(vendorId);
      if (response.status == 200) {
        final data = response.data.docs;
        listStaff.value = data ?? [];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> handleUpdateStaffForOrder() async {
    try {
      isLoadingConfirm.value = true;
      final List<String> listStaffId =
          listSelectedStaff.map((element) => element.id).toList();

      final request = UpdateStaffOrderRequest(staffIds: listStaffId);
      final response =
          await _apiClient.updateStaffForOrder(request, orderId.value);
      if (response.status == 200) {
        final data = response.data;
        orderData.value = data!;
        return true;
      }
      return false;
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isLoadingConfirm.value = false;
    }
  }
}
