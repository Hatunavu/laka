import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpVendorFirst extends StatelessWidget {
  const SignUpVendorFirst({Key? key, required this.account}) : super(key: key);
  final AccountModel account;

  @override
  Widget build(BuildContext context) {
    final CreateVendorController controller =
        Get.put(CreateVendorController(getIt.get<ApiClient>()));
    controller.handleUpdateProfile(account);
    return BaseScreen(
        child: Container(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Expanded(child: Image.asset(AppPath.createVendorWelcome)),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(kDefaultPaddingScreen.w),
              child: Text(
                "leaveInfor".tr,
                textAlign: TextAlign.center,
                style: titleStyle.copyWith(height: 1.3),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
            child: InkwellButtonLoading(
              onPressed: () {
                // context.router.push(const SignupVendorSecondPage());
                context.router.push(const ApplyVendorInformationPage());
              },
              label: "next".tr,
            ),
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Container(
              padding:
                  EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
              child: InkWellButton.outline(
                label: "back".tr,
                onPressed: () {
                  context.router.pop();
                },
              )),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
        ],
      ),
    ));
  }
}
