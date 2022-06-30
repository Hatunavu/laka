import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/voucher/enum_voucher.dart';
import 'package:client_tggt/model/voucher/enum_voucher_status.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:get/get.dart';

class VoucherController extends GetxController {
  final String title = "voucher_controller";
  final ApiClient _apiClient;
  VoucherController(this._apiClient);
  final type = VoucherType.all.toJsonString().obs;
  final isLoading = false.obs;
  List<VoucherModel> listVoucher = <VoucherModel>[].obs;
  final limit = 30.obs;
  final page = 1.obs;
  final vendorId = "".obs;
  final totalDocs = 0.obs;

  final listVoucherType = [
    VoucherType.all,
    VoucherType.system,
    VoucherType.vendor
  ];
  @override
  onInit() {
    super.onInit();
  }

  handleSetVendorId(String id) {
    vendorId.value = id;
    getListVoucher(limit.value, page.value, "all", id);
  }

  handleChangeVoucherType(VoucherType voucherType) {
    type.value = voucherType.toJsonString();
    if (voucherType == VoucherType.all) {
      getListVoucher(
          limit.value, page.value, voucherType.getType(), vendorId.value);
    } else if (voucherType == VoucherType.system) {
      getListVoucher(limit.value, page.value, voucherType.getType(), "");
    } else if (voucherType == VoucherType.vendor) {
      getListVoucher(
          limit.value, page.value, voucherType.getType(), vendorId.value);
    }
  }

  getListVoucher(int limit, int page, String type, String vendorId) async {
    try {
      isLoading(true);
      var response =
          await _apiClient.getListVoucher(limit, page, type, vendorId);
      if (response.status == 200) {
        final data = response.data;
        if (data != null) {
          listVoucher = data.docs == null
              ? []
              : data.docs!
                  .where((element) =>
                      element.status != VoucherStatusType.expireDate)
                  .toList();
          totalDocs.value = data.totalDocs ?? 0;
        }
      }
    } on Exception catch (err) {
    } finally {
      isLoading(false);
    }
  }
}
