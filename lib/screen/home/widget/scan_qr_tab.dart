import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/activity/detail/activity_detail_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:auto_route/auto_route.dart';

class ScanQrTab extends StatefulWidget {
  const ScanQrTab({Key? key}) : super(key: key);
  @override
  _ScanQrTabState createState() => _ScanQrTabState();
}

class _ScanQrTabState extends State<ScanQrTab> {
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  Barcode? result;
  bool isLoading = false;
  final _apiClient = getIt.get<ApiClient>();
//in order to get hot reload to work.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    // controller.resumeCamera();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          color: Colors.white,
          child: isLoading == true
              ? const LoadingScreen()
              : QRView(
                  key: qrKey,
                  onQRViewCreated: onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderWidth: 10,
                    // borderColor: Colors.teal,
                    borderLength: 20,
                    borderRadius: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.9,
                  ),
                )),
    );
  }

  void onQRViewCreated(QRViewController p1) {
//called when View gets created.
    controller = p1;
    controller.scannedDataStream.listen((scanevent) async {
      if (scanevent.code != null) {
        controller.stopCamera();

        final checkQrCode = scanevent.code!.split("-");
        if (checkQrCode[0] == "order") {
          final userToken = AccountServices().getUserToken();
          if (userToken == "") {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text("Thông báo"),
                      content: const Text(
                          "Vui lòng đăng nhập để sử dụng tính năng quét mã QR"),
                      actions: [
                        CupertinoDialogAction(
                            child: const Text("Xác nhận"),
                            onPressed: () {
                              context.router
                                  .push(SplashPage(isFristLoad: false));
                            })
                      ],
                    ));
          } else {
            context.router
                .push(ActivityDetailPage(
                    id: "", orderId: scanevent.code ?? '', isFromQr: true))
                .then((value) => {
                      Get.delete<ActivityDetailController>(),
                      context.router.pop()
                    });
          }
        } else if (checkQrCode[0] == "vendor") {
          final vendorInfo = await handleGetVendorInfo(checkQrCode[1]);
          if (vendorInfo != null) {
            context.router.push(
              VendorsDetailPage(
                  first: vendorInfo.id ?? '',
                  last: vendorInfo.category.getType(),
                  tagId: "qrCode-${vendorInfo.id}",
                  imageUrl: vendorInfo.thumbnail?.path ?? "",
                  vendorTitle: vendorInfo.brandName,
                  vendorsInfo: vendorInfo,
                  voucher: null),
            );
          } else {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text("Thông báo"),
                      content:
                          const Text("Đã có lỗi xảy ra, vui lòng thử lại sau."),
                      actions: [
                        CupertinoDialogAction(
                            child: const Text("Xác nhận"),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    ));
          }
        } else {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                    title: const Text("Thông báo"),
                    content:
                        const Text("Không tìm thấy mã QR, Vui lòng thử lại"),
                    actions: [
                      CupertinoDialogAction(
                          child: const Text("Xác nhận"),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  ));
        }
      }
    });
  }

  Future<VendorModel?> handleGetVendorInfo(String vendorId) async {
    try {
      setState(() {
        isLoading = true;
      });
      var response = await _apiClient.getVendorDetail(vendorId);
      if (response.status == 200) {
        //log("getListVendors: ${data.data.hotVendors.toString()}");
        if (response.vendorItem != null) {
          return response.vendorItem;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on Exception catch (err) {
      log("err $err");
      return null;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
