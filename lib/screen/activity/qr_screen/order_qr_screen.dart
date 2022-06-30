import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderQrScreen extends StatefulWidget {
  OrderQrScreen({Key? key, required this.orderId}) : super(key: key);
  final String orderId;
  @override
  State<OrderQrScreen> createState() => _OrderQrScreenState();
}

class _OrderQrScreenState extends State<OrderQrScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      title: "Mã xác nhận",
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Icon(
            Ionicons.chevron_back_outline,
            size: 21.sp,
            color:
                ThemeServices().isDarkMode ? kColorPrimaryDark : Colors.black,
          )),
      child: Container(
        alignment: Alignment.center,
        child: QrImage(
          size: Get.width * .8,
          data: widget.orderId,
          version: QrVersions.auto,
          backgroundColor: ThemeServices().isDarkMode
              ? Theme.of(context).primaryColor
              : Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
