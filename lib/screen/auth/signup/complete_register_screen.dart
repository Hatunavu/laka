import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/screen/auth/signin/signin_screen.dart';
import 'package:client_tggt/screen/auth/signup/complete_register_controller.dart';
import 'package:client_tggt/shared/base_screen_auth.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class CompleteRegisterScreen extends StatelessWidget {
  const CompleteRegisterScreen({Key? key, required this.account})
      : super(key: key);
  final AccountModel account;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final CompleteRegisterController controller =
        Get.put(CompleteRegisterController(getIt.get<ApiClient>()));
    controller.handleUpdateUserInfo(account);
    return BaseScreenAuth(
      title: "updateAccount".tr,
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
                          return "notEnterFullname".tr;
                        }
                        return null;
                      },
                      controller: controller.fullnameController.value,
                      autofocus: true,
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
                        labelText: "fullname".tr,
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.handleUpdateFullName();
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
