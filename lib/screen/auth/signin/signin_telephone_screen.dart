import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/forgot_password/forgot_password_controller.dart';
import 'package:client_tggt/screen/auth/signin/sigin_telephone_controller.dart';
import 'package:client_tggt/shared/base_screen_auth.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/textfield/custome_textinput_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SigninTelephoneScreen extends StatelessWidget {
  const SigninTelephoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SigninTelephoneController controller =
        SigninTelephoneController(getIt.get<ApiClient>());
    final _formKey = GlobalKey<FormState>();

    return BaseScreenAuth(
        title: 'signin'.tr,
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
                            return "Số điện thoại không đúng";
                          }
                          return null;
                        },
                        obscureText: false),
                    SizedBox(
                      height: kDefaultPaddingWidget.h * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          context.router.push(const SigninPage());
                        },
                        child: Text(
                          'loginWithPassword'.tr,
                          textAlign: TextAlign.right,
                          style: AppTextStyle().titleRegular16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPaddingWidget.h * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.router.navigate(const SignupPage());
                            },
                            child: Text(
                              'signup'.tr,
                              textAlign: TextAlign.right,
                              style: AppTextStyle().titleRegular16,
                            ),
                          ),
                          InkwellButtonLoading(
                              label: 'next'.tr,
                              isLoading: controller.isLoading.value,
                              backgroundColor: Theme.of(context).primaryColor,
                              textColor: Theme.of(context).backgroundColor,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  controller.handleCheckTelephone();
                                }
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPaddingWidget.h,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            context.router
                                .push(const ForgotPasswordPage())
                                .then((value) =>
                                    {Get.delete<ForgotPasswordController>()});
                          },
                          child: Text(
                            'forgotPassword'.tr,
                            textAlign: TextAlign.right,
                            style: subTitleStyle,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}

Widget showErrorText(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    alignment: Alignment.center,
    child: Text(
      "phoneNotRegister".tr,
      style: titleStyle,
    ),
  );
}
