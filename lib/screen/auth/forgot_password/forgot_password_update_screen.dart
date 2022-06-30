import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/forgot_password/forgot_password_update_controller.dart';
import 'package:client_tggt/screen/auth/signin/signin_screen.dart';
import 'package:client_tggt/shared/base_screen_auth.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPasswordUpdateScreen extends StatelessWidget {
  const ForgotPasswordUpdateScreen({Key? key, required this.token})
      : super(key: key);
  final String token;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final ForgotPasswordUpdateController controller =
        Get.put(ForgotPasswordUpdateController(getIt.get<ApiClient>()));
    controller.handleUpadateToken(token);
    return BaseScreenAuth(
      title: "updatePassword".tr,
      subTitle: 'typeInfomation'.tr,
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
                          return "notEnterPassword".tr;
                        }
                        return null;
                      },
                      controller: controller.passwordController.value,
                      autofocus: true,
                      obscureText: true,
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
                        labelText: "password".tr,
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
                        child: InkwellButtonLoading(
                            label: 'confirm'.tr,
                            isLoading: controller.isLoading.value,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // handleChangePassword
                                final checkChangePassword =
                                    await controller.handleChangePassword();
                                if (checkChangePassword == true) {
                                  getIt.get<IToast>().show(
                                      title: "success".tr,
                                      message: "changePasswordSuccess".tr,
                                      hasDismissButton: false,
                                      duration:
                                          const Duration(milliseconds: 1000));
                                  context.router.replace(const SigninPage());
                                } else {
                                  return;
                                }
                              }
                            }),
                      ),
                    ),
                  ],
                )),
          )),
    );
  }
}
