import 'dart:io';

import 'package:client_tggt/app.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:auto_route/auto_route.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({Key? key}) : super(key: key);
  @override
  _ScanQRPageState createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> {
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  Barcode? result;
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
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "Kiểm tra lịch hẹn",
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(
              Ionicons.chevron_back_outline,
              size: 23.sp,
              color: Colors.black,
            )),
        child: QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderWidth: 10,
            borderColor: Colors.teal,
            borderLength: 20,
            borderRadius: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.9,
          ),
        ));
  }

  void onQRViewCreated(QRViewController p1) {
//called when View gets created.
    controller = p1;
    controller.scannedDataStream.listen((scanevent) {
      if (scanevent.code != null) {
        controller.pauseCamera();
        // Get.to(() => const BookingDetailScreen(),
        //     arguments: {"bookingId": scanevent.code, "type": "qrcode"});
        Get.find<RouterController>().push(
            BookingDetailPage(bookingId: scanevent.code, parentPage: "qrcode"));
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
