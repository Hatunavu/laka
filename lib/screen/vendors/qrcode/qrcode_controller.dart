import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeController extends GetxController {
  // final String _scanBarcode = "qrcode";
  final isLoading = false.obs;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  Barcode? result;

  onQRViewCreated() {
    controller.scannedDataStream.listen((scanevent) {
      log(scanevent.code ?? '');
      controller.dispose();
    });
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
