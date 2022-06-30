import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermOfServiceScreen extends StatefulWidget {
  const TermOfServiceScreen({Key? key}) : super(key: key);

  @override
  _TermOfServiceScreenState createState() => _TermOfServiceScreenState();
}

class _TermOfServiceScreenState extends State<TermOfServiceScreen> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: defaultPaddingItem.h,
                    horizontal: kDefaultPaddingScreen.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        context.router.pop();
                      },
                      child: Text(
                        "close".tr,
                        style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                      ),
                    ),
                    Text(
                      "termsOfService".tr,
                      style: titleStyle,
                    ),
                    InkWell(
                      onTap: () {
                        controller.loadUrl(
                            "https://www.apple.com/legal/internet-services/itunes/");
                      },
                      child: Container(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          Icons.refresh_outlined,
                          size: 23,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
                  child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl:
                        "https://www.apple.com/legal/internet-services/itunes/",
                    onWebViewCreated: (controller) {
                      this.controller = controller;
                    },
                    onProgress: (int progres) {
                      print('WebView is loading $progres');
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
