import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signin/sigin_telephone_controller.dart';
import 'package:client_tggt/screen/auth/signin/signin_controller.dart';
import 'package:client_tggt/screen/auth/signin/signin_verify_controller.dart';
import 'package:client_tggt/screen/auth/signup/signup_controller.dart';
import 'package:client_tggt/screen/auth/verify/verify_controller.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/newfeed_controller.dart';
import 'package:client_tggt/screen/notification/notification_controller.dart';
import 'package:client_tggt/screen/profile/profile_controller.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NotLoginScreen extends StatelessWidget {
  const NotLoginScreen({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(kDefaultPaddingWidget.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppPath.logo,
            color: Theme.of(context).primaryColor,
            width: 150.w,
            // height: 60,
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Text(
            title,
            style: titleStyle,
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Text(
            subTitle,
            style: subTitleStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          InkWellButton(
            label: "signin".tr,
            onPressed: () {
              Get.delete<MainController>();
              Get.delete<HomeController>();
              Get.delete<ProfileController>();
              Get.delete<NotificationController>();
              Get.delete<NewfeedController>();
              Get.delete<VerifyController>();
              Get.delete<SigninVerifyController>();
              Get.delete<SigninController>();
              Get.delete<SignupController>();
              Get.delete<SigninTelephoneController>();
              context.router.replace(const SigninTelephonePage());
            },
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          InkWellButton.outline(
            label: "signup".tr,
            onPressed: () {
              Get.delete<MainController>();
              Get.delete<HomeController>();
              Get.delete<ProfileController>();
              Get.delete<NotificationController>();
              Get.delete<NewfeedController>();
              Get.delete<VerifyController>();
              Get.delete<SigninVerifyController>();
              Get.delete<SigninController>();
              Get.delete<SignupController>();
              Get.delete<SigninTelephoneController>();
              context.router.push(const SignupPage());
            },
          )
        ],
      ),
    );
  }
}

Widget underConstruction(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: Text("Under Construction", style: AppTextStyle().heading1Regular24),
  );
}
