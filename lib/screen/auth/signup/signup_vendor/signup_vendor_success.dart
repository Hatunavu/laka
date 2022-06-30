import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signup/apply_vendor/apply_vendor_information_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class SignupVendorSuccess extends StatelessWidget {
  const SignupVendorSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BaseScreen(
        child: Container(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 68.h),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.checkmark_circle_outline,
                      color: ThemeServices().isDarkMode
                          ? kColorGreyDark
                          : kColorPrimaryLight,
                      size: 100.sp,
                    ),
                    SizedBox(
                      height: kDefaultPaddingWidget.h * 1.5,
                    ),
                    Text(
                      "signupSuccess".tr,
                      textAlign: TextAlign.center,
                      style: titleStyle.copyWith(fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: kDefaultPaddingWidget.h,
                    ),
                    Text(
                      "informationApproval".tr,
                      textAlign: TextAlign.center,
                      style: subTitleStyle.copyWith(height: 1.3),
                    ),
                  ],
                ),
              )),
              // Container(
              //   padding:
              //       EdgeInsets.symmetric(horizontal: kDefaultPaddingWidget.w),
              //   child: InkwellButtonLoading(
              //     onPressed: () {
              //       Get.delete<MainController>();
              //       Get.delete<HomeController>();
              //       Get.delete<ProfileController>();
              //       Get.delete<NotificationController>();
              //       Get.delete<NewfeedController>();
              //       Get.delete<VerifyController>();
              //       Get.delete<SigninVerifyController>();
              //       Get.delete<SigninController>();
              //       Get.delete<SignupController>();
              //       Get.delete<SigninTelephoneController>();
              //       Get.delete<CreateVendorController>();
              //       AccountServices().saveLanguageCode("vi");
              //       if (ThemeServices().isDarkMode) {
              //         ThemeServices().switchTheme();
              //       }
              //       context.router.replace(const VendorMainPage());
              //     },
              //     label: "Xác nhận",
              //   ),
              // )
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: kDefaultPaddingWidget.w),
                child: InkwellButtonLoading(
                  onPressed: () {
                    context.router.pop();
                  },
                  label: "confirm".tr,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
