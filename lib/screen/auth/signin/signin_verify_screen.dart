import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/auth/signin/signin_screen.dart';
import 'package:client_tggt/screen/auth/signin/signin_verify_controller.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:auto_route/auto_route.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class SignInVerifyScreen extends StatelessWidget {
  const SignInVerifyScreen({Key? key, this.telePhone}) : super(key: key);
  final String? telePhone;
  @override
  Widget build(BuildContext context) {
    final SigninVerifyController controller =
        Get.put(SigninVerifyController(getIt.get<ApiClient>()));
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
      child: Column(
        children: [
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
              margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h * 2),
              child: Center(
                  child: Column(children: <Widget>[
                Expanded(
                    child: Container(
                        margin:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'verify'.tr,
                              style: AppTextStyle().specialRegular32,
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
                                style: AppTextStyle()
                                    .subtitleRegular14Grey
                                    .copyWith(height: 1.2),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 16, left: 16, right: 16),
                                alignment: Alignment.center,
                                child: Obx(
                                  () => Column(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: '${'phoneNumber'.tr}:',
                                          style: AppTextStyle()
                                              .subtitleRegular14Grey,
                                          children: <TextSpan>[
                                            TextSpan(text: telePhone),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: kDefaultPaddingWidget.h * 2,
                                      ),
                                      controller.errorMessage.value != ""
                                          ? showErrorText(context,
                                              controller.errorMessage.value)
                                          : Container(),
                                      PinCodeTextField(
                                        length: 4,
                                        autoFocus: true,
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                        appContext: context,
                                        animationType: AnimationType.fade,
                                        textStyle: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                        pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            fieldHeight: 58.w,
                                            fieldWidth: 58.w,
                                            activeFillColor: Colors.white,
                                            selectedColor:
                                                Theme.of(context).primaryColor,
                                            inactiveColor: Colors.grey,
                                            activeColor:
                                                Theme.of(context).primaryColor),
                                        animationDuration:
                                            Duration(milliseconds: 300),
                                        controller:
                                            controller.box1Controller.value,
                                        onCompleted: (v) {
                                          controller.isFullCode.value = true;
                                          controller.handleVerify(context);
                                        },
                                        onChanged: (value) {},
                                        beforeTextPaste: (text) {
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
                                        style: AppTextStyle()
                                            .subtitleRegular14Grey,
                                      ),
                                      SizedBox(
                                        height: kDefaultPaddingWidget.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          'resend'.tr,
                                          style: AppTextStyle().titleRegular16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: kDefaultPaddingWidget.h * 2,
                                      ),
                                      controller.isLoading.value == true
                                          ? const CupertinoActivityIndicator(
                                              animating: true,
                                            )
                                          : controller.isFullCode.isTrue
                                              ? Flexible(
                                                  child: InkWellButton(
                                                    label: 'verify'.tr,
                                                    onPressed: () {
                                                      controller.handleVerify(
                                                          context);
                                                    },
                                                  ),
                                                )
                                              : Container()
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )))
              ])),
            ),
          ),
        ],
      ),
    )));
  }
}
