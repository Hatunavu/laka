import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/api/constant.dart';
import 'package:client_tggt/model/activity_detail/get_bill_by_qr_request.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:client_tggt/model/vendor_page/booking/sub_fee/sub_fee_model.dart';
import 'package:client_tggt/screen/activity/activity_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/review/widgets/create_review.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_save/image_save.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ActivityDetailController extends GetxController {
  final id = ''.obs;
  var docData = BookingItemModel(status: BookingStatus.pending).obs;
  var ticketQRKey = GlobalKey();
  var isLoading = false.obs;
  var isConnectSocket = false.obs;
  final ApiClient _apiClient;
  late io.Socket _socket;
  final listStaff = <StaffModel>[].obs;
  final totalStaffPrice = 0.0.obs;
  final isLoadingConfirm = false.obs;
  final isErrorScanByQr = false.obs;
  final isData = 1.obs;
  final listMenu = <SelectedMenuItemModel>[].obs;
  final listSubFee = <SubFeeModel>[].obs;

  ActivityDetailController(this._apiClient);

  @override
  void onClose() {
    if (isConnectSocket.isTrue) {
      _socket.disconnect();
      _socket.dispose();
    }

    super.onClose();
  }

  _connectSocket() {
    isConnectSocket.value = true;
    final userToken = AccountServices().getUserToken().obs;

    final options = io.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .setAuth({"token": 'Bearer $userToken'})
        // .setQuery({"token": 'Bearer $userToken'})
        .build();
    _socket = io.io(ApiConstants.host, options);
    _socket.connect();
    _socket.onConnect((data) {
      //log(data);
      _socket.emit('identity', '');
      _socket.emit('subcribe', docData.value.orderId);
    });

    _socket.on("orderChanges", (data) {
      var jsonData = Map<String, dynamic>.from(data);
      docData.value = BookingItemModel.fromJson(jsonData["order"]);
      inspect(BookingItemModel.fromJson(jsonData["order"]));
      isData.value = 2;
      isConnectSocket.value = false;

      _socket.disconnect();
      _socket.dispose();
    });
  }

  Future<String> saveTicket() async {
    RenderRepaintBoundary boundary =
        ticketQRKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 2.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData?.buffer.asUint8List() ?? Uint8List(0);
    var now = DateTime.now().millisecondsSinceEpoch;
    await ImageSave.saveImage(pngBytes, "ticket$now.png", albumName: "TGGT");
    return 'ticket$now.png';
  }

  Future<bool> requestCancel() async {
    return await _getCancelOrder(docData.value.id ?? '');
  }

  getDetailOrder(BuildContext context, String id) async {
    try {
      isLoading(true);
      var response = await _apiClient.getDetailOrder(id);
      if (response.status == 200) {
        if (response.data != null) {
          final data = response.data!;
          docData.value = data;
          listStaff.value = data.staffs ?? [];
          listMenu.value = data.menuItems ?? [];
          listSubFee.value = data.subFees ?? [];
          totalStaffPrice.value = data.totalStaffPrice;
          if (docData.value.status == BookingStatus.pending) {
            _connectSocket();
          }
          if (docData.value.status == BookingStatus.completed &&
              docData.value.review == null) {
            showReviewModal(context);
          }
        }
      } else {}
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  getBillByQrCode(String id) async {
    try {
      isLoading(true);
      final request = GetBillByQrRequest(orderId: id);
      var response = await _apiClient.getBillByQr(request);
      if (response.status == 200) {
        if (response.data != null) {
          final data = response.data!;
          docData.value = data;
          id = data.id ?? "";
        } else {
          isErrorScanByQr.value = true;
        }
      } else {
        isErrorScanByQr.value = true;
      }
    } on Exception catch (err) {
      log("err $err");
      isErrorScanByQr.value = true;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> handleConfirmBillQr(String orderId) async {
    try {
      isLoading(true);
      final request = GetBillByQrRequest(orderId: orderId);
      var response = await _apiClient.confirmBillQr(request);
      if (response.status == 200) {
        isLoading(false);
        final data = response.data!;
        docData.value = data;
        return true;
      } else {
        isLoading(false);

        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      isLoading(false);
      return false;
    }
  }

  showReviewModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: CreateReview(
            orderID: id.value,
            review: docData.value.review,
            callback: (bool isReview) async {
              if (isReview) {
                print("review thanh cong");
                await getDetailOrder(context, id.value);
                Navigator.pop(context);
                EasyLoading.showSuccess('success'.tr);
                Future.delayed(const Duration(seconds: 1), () {
                  EasyLoading.dismiss();
                });
              } else {
                print("review that bai");
              }
            },
          ),
        );
      },
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
    );
  }

  Future<bool> _getCancelOrder(String id) async {
    try {
      isLoading(true);
      var response = await _apiClient.getCancelOrder(id);
      if (response.status == 200) {
        final MainController mainController = Get.find();
        mainController.handleCancelCurrentOrder();
        return true;
      } else {
        return false;
      }
    } on Exception catch (err) {
      log("err $err");
      return false;
    } finally {
      isLoading(false);
    }
  }
}
