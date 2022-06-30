import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/admin_page/admin_main/admin_main_screen.dart';
import 'package:client_tggt/screen/splash/splash_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.isFristLoad = true}) : super(key: key);
  final bool? isFristLoad;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController controller =
      Get.put(SplashController(getIt.get<ApiClient>()));
  @override
  void initState() {
    if (widget.isFristLoad == true) {
      Future.delayed(const Duration(seconds: 3), () {
        handleCheck();
      });
    } else {
      handleCheck();
    }

    super.initState();
  }

  handleCheck() {
    final userId = AccountServices().getUserId();
    final userToken = AccountServices().getUserToken();
    final accountType = AccountServices().getAccountType();
    if (userId != "") {
      if (accountType == "") {
        if (userToken != "") {
          AccountServices().saveAccountType(AccountType.customer.getType());
        }
        context.router.replace(MainPage());
      } else {
        if (accountType == AccountType.vendor.getType()) {
          // context.router.replace(MainPage());

          context.router.replace(const VendorMainPage());
        } else if (accountType == "admin") {
          context.router.replace(const AdminMainPage());
        } else {
          handleGetProfileData();
        }
      }
    } else {
      context.router.replace(MainPage());
    }
  }

  handleGetProfileData() async {
    final profileData = await controller.getMe();
    if (profileData != null) {
      final data = profileData.data!;
      final account = data.account;
      final countPendingOrder = data.countPendingOrders;
      final countUnreadNotifications = data.countUnreadNotifications;
      final currentOrder = data.currentOrder;
      context.router.replace(MainPage(
          account: account,
          countPendingOrders: countPendingOrder,
          countUnreadNotifications: countUnreadNotifications,
          currentOrders: currentOrder));
    } else {
      AccountServices().saveUserToken("");
      AccountServices().saveUserId("");
      AccountServices().saveAccountType("");
      context.router.replace(MainPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: widget.isFristLoad == true
                ? Lottie.asset(
                    AppPath.splashLoading,
                    frameRate: FrameRate.composition,
                    repeat: true,
                    animate: true,
                  )
                : Center(
                    child: SvgPicture.asset(
                      AppPath.logo,
                      color: Theme.of(context).primaryColor,
                      width: 100.w,
                      // height: 60,
                    ),
                  )));
  }
}
