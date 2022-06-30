import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ServiceItemBookingScreen extends StatelessWidget {
  const ServiceItemBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "Quản lý đặt lịch",
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: const Icon(
              Ionicons.chevron_back_outline,
              size: 23,
              color: Colors.black,
            )),
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPaddingScreen.w,
                vertical: kDefaultPaddingWidget.h),
            child: const Text("under construction")));
  }
}
