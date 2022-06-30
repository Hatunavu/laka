import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/forgot_password/forgot_password_controller.dart';
import 'package:client_tggt/screen/auth/forgot_password/forgot_password_verify_controller.dart';
import 'package:client_tggt/screen/auth/signin/signin_telephone_screen.dart';
import 'package:client_tggt/shared/base_screen_auth.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/textfield/custome_textinput_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:auto_route/auto_route.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final ForgotPasswordController controller =
        Get.put(ForgotPasswordController(getIt.get<ApiClient>()));
    return BaseScreenAuth(
        title: "forgotPassword".tr,
        subTitle: 'typeInfomation'.tr,
        body: Container(
          margin: EdgeInsets.only(top: 32.h, left: 16.h, right: 16.h),
          child: Form(
              key: _formKey,
              child: Obx(
                () => Column(
                  children: [
                    controller.isError.isTrue
                        ? showErrorText(context)
                        : Container(),
                    TextInput(
                        textString: 'phoneNumber'.tr,
                        textController: controller.phoneController.value,
                        inputType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'notEnterPhoneNumber'.tr;
                          } else if (value.split("").length != 10 ||
                              value.split("")[0] != "0") {
                            return "incorrectPhone".tr;
                          }
                          return null;
                        },
                        obscureText: false),
                    SizedBox(
                      height: kDefaultPaddingWidget.h * 3,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.router
                                  .navigate(const SigninTelephonePage());
                            },
                            child: Text(
                              'signin'.tr,
                              textAlign: TextAlign.right,
                              style: AppTextStyle().titleRegular16,
                            ),
                          ),
                          InkwellButtonLoading(
                              label: 'next'.tr,
                              isLoading: controller.isLoading.value,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final telephone =
                                      controller.phoneController.value.text;
                                  bool checkStatus =
                                      await controller.handleForgotPassword();
                                  if (checkStatus == true) {
                                    context.router
                                        .push(ForgotPasswordVerifyPage(
                                            telePhone: telephone))
                                        .then((value) => {
                                              Get.delete<
                                                  ForgotPasswordVerifyController>()
                                            });
                                  } else {
                                    return;
                                  }
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
