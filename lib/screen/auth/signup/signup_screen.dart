import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signin/signin_screen.dart';
import 'package:client_tggt/screen/auth/signup/signup_controller.dart';
import 'package:client_tggt/shared/base_screen_auth.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../verify/verify_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final SignupController controller =
        Get.put(SignupController(getIt.get<ApiClient>()));

    return BaseScreenAuth(
      title: 'createAccount'.tr,
      subTitle: 'typeInfomation'.tr,
      isLogin: false,
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon:
              Icon(Icons.arrow_back_ios, size: 30, color: HexColor(textColor))),
      body: Container(
          margin:
              EdgeInsets.only(top: 16.h, left: 16.h, right: 16.h, bottom: 32.h),
          child: Form(
            key: _formKey,
            child: Obx(() => Column(
                  children: [
                    controller.errorMessage.value != ""
                        ? showErrorText(context, controller.errorMessage.value)
                        : Container(),
                    TextFormField(
                      cursorColor: const Color(0xFF9b9b9b),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'notEnterPhoneNumber'.tr;
                        }
                        if (value.length < 10 || value.length > 11) {
                          return "incorrectPhone".tr;
                        }
                        return null;
                      },
                      controller: controller.phoneController.value,
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor(greyTextColor)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: HexColor(greyTextColor))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: HexColor(greyTextColor))),
                        labelText: 'phoneNumber'.tr,
                        labelStyle: TextStyle(color: HexColor(greyTextColor)),
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPaddingWidget.h,
                    ),
                    TextFormField(
                      cursorColor: const Color(0xFF9b9b9b),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'notEnterFullname'.tr;
                        }

                        return null;
                      },
                      controller: controller.fullnameController.value,
                      autofocus: true,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor(greyTextColor)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: HexColor(greyTextColor))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: HexColor(greyTextColor))),
                        labelText: 'fullname'.tr,
                        labelStyle: TextStyle(color: HexColor(greyTextColor)),
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPaddingWidget.h * 3,
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(bottom: kDefaultPaddingWidget.h * 3),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            (controller.step.value == 0)
                                ? GestureDetector(
                                    onTap: () {
                                      context.router.pop();
                                    },
                                    child: Text(
                                      'signin'.tr,
                                      textAlign: TextAlign.right,
                                      style: actionTitleAuth,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (controller.step.value > 0 &&
                                            controller.step.value <= 2) {
                                          controller.nextStep(
                                              controller.step.value - 1);
                                        }
                                      }
                                    },
                                    child: Text(
                                      'back'.tr,
                                      textAlign: TextAlign.right,
                                      style: actionTitleAuth,
                                    ),
                                  ),
                            controller.isLoading.value == true
                                ? const CupertinoActivityIndicator(
                                    animating: true,
                                  )
                                : InkwellButtonLoading(
                                    label: 'next'.tr,
                                    isLoading: controller.isLoading.value,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final bool checkTelephone =
                                            await controller
                                                .handleCheckTelephone();
                                        if (checkTelephone == false) return;
                                        context.router
                                            .push(VerifyPage(
                                          telePhone: controller
                                              .phoneController.value.text,
                                        ))
                                            .then((value) {
                                          controller
                                              .phoneController.value.text = "";
                                          controller.errorMessage.value = "";
                                          Get.delete<VerifyController>();
                                        });
                                      }
                                    }),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}
