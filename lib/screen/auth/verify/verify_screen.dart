import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signin/signin_screen.dart';
import 'package:client_tggt/screen/auth/verify/verify_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({Key? key, this.telePhone}) : super(key: key);
  final String? telePhone;

  @override
  Widget build(BuildContext context) {
    final VerifyController controller =
        Get.put(VerifyController(getIt.get<ApiClient>()));
    controller.handleUpdatePhone(telePhone ?? "");
    // final telephone = Get.parameters['phone'];
    return Scaffold(
        body: SafeArea(
            child: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Center(
          child: Column(children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
          padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingWidget.w),
          child: GestureDetector(
              onTap: () {
                context.router.pop();
              },
              child: Icon(Icons.arrow_back_ios,
                  size: 30, color: Theme.of(context).primaryColor)),
        ),
        Expanded(
            child: Container(
                margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'verify'.tr,
                      style: titleAuthScreen,
                    ),
                    SizedBox(
                      height: kDefaultPaddingWidget.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        'enter4DigitsNumber'.tr,
                        textAlign: TextAlign.center,
                        style: subTitleAuthScreen.copyWith(height: 1.2),
                      ),
                    ),
                    Container(
                        margin:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        alignment: Alignment.center,
                        child: Obx(() => Column(children: [
                              RichText(
                                text: TextSpan(
                                  text: '${'phoneNumber'.tr}:',
                                  style: subTitleAuthScreen,
                                  children: <TextSpan>[
                                    TextSpan(text: telePhone),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPaddingWidget.h * 3,
                              ),
                              controller.errorMessage.value != ""
                                  ? showErrorText(
                                      context, controller.errorMessage.value)
                                  : Container(),
                              PinCodeTextField(
                                length: 4,
                                autoFocus: true,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                appContext: context,
                                animationType: AnimationType.fade,
                                textStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 58.w,
                                    fieldWidth: 58.w,
                                    activeFillColor: Colors.white,
                                    selectedColor:
                                        Theme.of(context).primaryColor,
                                    inactiveColor: Colors.grey,
                                    activeColor:
                                        Theme.of(context).primaryColor),
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                controller: controller.box1Controller.value,
                                onCompleted: (v) async {
                                  // final bool checkVerify =
                                  //     await controller.handleVerify();
                                  controller.handleVerify();
                                  // if (checkVerify == false) return;

                                  // context.router
                                  //     .push(SplashPage(isFristLoad: false));

                                  // if (checkVerify == false) return;
                                  // context.router
                                  //     .push(CompleteRegisterPage(
                                  //         account: controller.userInfo.value))
                                  //     .then((value) {
                                  //   AccountServices().saveUserToken("");
                                  //   AccountServices().saveUserId("");
                                  //   AccountServices().saveAccountType("");
                                  // });
                                },
                                onChanged: (value) {
                                  controller.handleUpdateOtp();
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                              ),
                              Visibility(
                                  visible: controller.isLoad.value,
                                  child: Container()),
                              SizedBox(
                                height: kDefaultPaddingWidget.h * 2,
                              ),
                              Text(
                                'notReceiveCode'.tr,
                                style: subTitleAuthScreen,
                              ),
                              SizedBox(
                                height: kDefaultPaddingWidget.h,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'resend'.tr,
                                  style: actionTitleAuth,
                                ),
                              ),
                              SizedBox(
                                height: kDefaultPaddingWidget.h * 2,
                              ),
                              controller.isLoading.value == true
                                  ? const CupertinoActivityIndicator(
                                      animating: true,
                                    )
                                  : InkwellButtonLoading(
                                      isLoading: controller.isLoading.value,
                                      label: 'verify'.tr,
                                      onPressed: () async {
                                        final bool checkVerify =
                                            await controller.handleVerify();
                                        if (checkVerify == false) return;
                                        context.router
                                            .push(CompleteRegisterPage(
                                                account:
                                                    controller.userInfo.value))
                                            .then((value) {
                                          AccountServices().saveUserToken("");
                                          AccountServices().saveUserId("");
                                          AccountServices().saveAccountType("");
                                        });
                                      },
                                    )
                            ])))
                  ],
                )))
      ])),
    )));
  }
}

Widget otpTextField(BuildContext context, bool autoFocus, int index,
    TextEditingController controller, VerifyController verifyController) {
  return Container(
    height: MediaQuery.of(context).size.shortestSide * 0.14,
    decoration: BoxDecoration(
      border: Border.all(
          color: verifyController.listEmptyBox.contains(index)
              ? kColorPrimaryLight
              : HexColor(textColor)),
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      shape: BoxShape.rectangle,
    ),
    child: AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.only(left: 2.w),
        child: TextField(
          autofocus: autoFocus,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
          ),
          style: TextStyle(
              fontSize: 20.0,
              height: 1.6,
              fontWeight: FontWeight.w500,
              color: ThemeServices().isDarkMode
                  ? kColorGreyDark
                  : kColorGreyLight),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          cursorColor: HexColor(greyTextColor),
          maxLines: 1,
          maxLength: 1,
          controller: controller,
          onChanged: (value) {
            if (verifyController.listEmptyBox.contains(index)) {
              verifyController.listEmptyBox.remove(index);
            }
            if (value.length == 1 && index < 3) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).previousFocus();
            } else if (index == 3) {
              // verifyController.handleVerify();
              FocusScope.of(context).unfocus();
            }
          },
        ),
      ),
    ),
  );
}
