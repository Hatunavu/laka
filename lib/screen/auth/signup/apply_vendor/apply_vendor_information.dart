import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signup/apply_vendor/apply_vendor_information_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/textfield/secondary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ApplyVendorInformation extends StatelessWidget {
  const ApplyVendorInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApplyVendorInformationController controller =
        Get.put(ApplyVendorInformationController(getIt.get<ApiClient>()));
    final _formKey = GlobalKey<FormState>();

    return Obx(() => BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "basicInfor".tr,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: kDefaultPaddingWidget.h,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    renderInformation(context, controller),
                  ],
                ),
              )),
              renderBottomAction(context, controller, _formKey),
            ],
          ),
        )));
  }
}

Widget renderInformation(
    BuildContext context, ApplyVendorInformationController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    margin: EdgeInsets.only(top: 8.h),
    child: Column(
      children: [
        SecondaryTextfield(
            label: "vendorName".tr,
            maxLines: 10,
            minLines: 3,
            onChanged: (text) {
              // controller.handleCheckInformation();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "vendorNameIsObligatory".tr;
              }
              return null;
            },
            controller: controller.nameController.value),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        SecondaryTextfield(
            label: "contactName".tr,
            onChanged: (text) {
              // controller.handleCheckInformation();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "nameIsObligatory".tr;
              }
              return null;
            },
            controller: controller.fullNameController.value),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        SecondaryTextfield(
            label: "phoneNumber".tr,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'phoneIsObligatory'.tr;
              } else if (value.split("").length != 10 ||
                  value.split("")[0] != "0") {
                return "incorrectPhone".tr;
              }
              return null;
            },
            controller: controller.phoneController.value),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        SecondaryTextfield(
            label: "Email",
            onChanged: (text) {
              // controller.handleCheckInformation();
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'emailIsObligatory'.tr;
              }
              if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(value)) {
                return 'incorrectEmail'.tr;
              }
              return null;
            },
            controller: controller.emailController.value),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        SecondaryTextfield(
            label: "address".tr,
            minLines: 5,
            maxLines: 10,
            onChanged: (text) {
              // controller.handleCheckInformation();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "addressIsObligatory".tr;
              }
              return null;
            },
            controller: controller.addressController.value),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
      ],
    ),
  );
}

Widget renderBottomAction(
    BuildContext context,
    ApplyVendorInformationController controller,
    GlobalKey<FormState> _formKey) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingScreen.w, vertical: kDefaultPaddingWidget.h),
    decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5.h))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(children: [
          GestureDetector(
            onTap: () {
              context.router.pop();
            },
            child: Text(
              "back".tr,
              style: titleStyle,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            color: Colors.black,
          )
        ]),
        InkwellButtonLoading(
            label: "next".tr,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final bool status =
                    await controller.handleSendApplyVendorsInformation();

                if (status == true) {
                  context.router.push(const SignupVendorSuccessPage());
                }
              }
              // context.router.push(const SignupVendorThirdPage());
            })
      ],
    ),
  );
}
