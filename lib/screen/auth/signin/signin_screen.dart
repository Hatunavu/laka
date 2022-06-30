import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signin/signin_controller.dart';
import 'package:client_tggt/screen/auth/signup/signup_controller.dart';
import 'package:client_tggt/shared/base_screen_auth.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/textfield/custome_textinput_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SigninController controller =
        SigninController(getIt.get<ApiClient>());
    final _formKey = GlobalKey<FormState>();

    return BaseScreenAuth(
        title: 'signin'.tr,
        subTitle: 'typeInfomation'.tr,
        body: Container(
          margin:
              EdgeInsets.only(top: 16.h, left: 16.h, right: 16.h, bottom: 32.h),
          child: Form(
              key: _formKey,
              child: Obx(
                () => Column(
                  children: [
                    controller.errorMessage.value != ""
                        ? showErrorText(context, controller.errorMessage.value)
                        : Container(),
                    TextInput(
                        textString: 'phoneNumber'.tr,
                        textController: controller.phoneController.value,
                        inputType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'notEnterPhoneNumber'.tr;
                          }
                          return null;
                        },
                        obscureText: false),
                    SizedBox(
                      height: kDefaultPaddingWidget.h * 2,
                    ),
                    TextInput(
                        textString: 'password'.tr,
                        textController: controller.passwordController.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'notEnterPassword'.tr;
                          }
                          return null;
                        },
                        obscureText: true),
                    SizedBox(
                      height: kDefaultPaddingWidget.h * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          context.router.navigate(const SigninTelephonePage());
                        },
                        child: Text(
                          'loginWithTelephone'.tr,
                          textAlign: TextAlign.right,
                          style: AppTextStyle().titleRegular16,
                        ),
                      ),
                    ),
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
                              context.router.push(const SignupPage()).then(
                                  (value) => Get.delete<SignupController>());
                            },
                            child: Text(
                              'signup'.tr,
                              textAlign: TextAlign.right,
                              style: actionTitleAuth,
                            ),
                          ),
                          InkwellButtonLoading(
                              label: 'signin'.tr,
                              isLoading: controller.isLoading.value,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.handleSignIn();
                                }
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}

Widget showErrorText(BuildContext context, String content) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    alignment: Alignment.center,
    child: Text(
      content,
      style: titleStyle.copyWith(color: Theme.of(context).primaryColor),
    ),
  );
}
