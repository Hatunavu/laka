import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/category_model.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/textfield/secondary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class SignupVendorSecond extends StatelessWidget {
  const SignupVendorSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateVendorController controller =
        Get.put(CreateVendorController(getIt.get<ApiClient>()));
    return Obx(() => BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "basicInfor".tr,
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
                  renderAddress(context, controller),
                  renderChooseCategory(context, controller)
                ],
              ),
            )),
            renderBottomAction(context, controller),
          ],
        )));
  }
}

Widget renderInformation(
    BuildContext context, CreateVendorController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    margin: EdgeInsets.only(top: 8.h),
    child: Column(
      children: [
        SecondaryTextfield(
            label: "vendorName".tr,
            onChanged: (text) {
              controller.handleCheckInformation();
            },
            controller: controller.vendorNameController.value),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        SecondaryTextfield(
            label: "information".tr,
            maxLines: 10,
            minLines: 3,
            onChanged: (text) {
              controller.handleCheckInformation();
            },
            controller: controller.vendorDetailsController.value),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        SecondaryTextfield(
            label: "phoneNumber".tr,
            isEdit: false,
            controller: controller.vendorPhoneController.value),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        SecondaryTextfield(
            label: "Email",
            onChanged: (text) {
              controller.handleCheckInformation();
            },
            controller: controller.vendorEmailController.value),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
      ],
    ),
  );
}

Widget renderAddress(BuildContext context, CreateVendorController controller) {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(
            left: kDefaultPaddingScreen.w,
            right: kDefaultPaddingScreen.w,
            top: 10.h),
        child: Text(
          "address".tr,
          style: subTitleStyle,
        ),
      ),
      GestureDetector(
        onTap: () {
          context.router.push(VendorAddAdressPage());
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 10.w),
          margin: EdgeInsets.only(
            left: kDefaultPaddingScreen.w,
            right: kDefaultPaddingScreen.w,
          ),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.8.w, color: Colors.grey))),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                  "province".tr + ', ' + "district".tr + ', ' + "ward".tr,
                  style: TextStyle(fontSize: 12.sp)),
            )),
            Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(bottom: 3.h),
              alignment: Alignment.centerRight,
              width: 30.w,
              child: Icon(
                Ionicons.chevron_forward_outline,
                color: Theme.of(context).primaryColor,
                size: 18.sp,
              ),
            )
          ]),
        ),
      )
      // Container(
      //   alignment: Alignment.centerLeft,
      //   margin: EdgeInsets.only(
      //       bottom: kDefaultPaddingScreen.h,
      //       left: kDefaultPaddingScreen.w,
      //       right: kDefaultPaddingScreen.w),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Text(
      //         "Địa chỉ",
      //         style: subTitleStyle,
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           context.router.push(SignupVendorThirdPage(onBack: (double lat,
      //               double lng, String fullAddress, bool isError) async {
      //             if (isError == true) {
      //               return;
      //             } else {
      //               controller.vendorAddressController.value.text = fullAddress;
      //               controller.longitude.value = '$lng';
      //               controller.latitude.value = '$lat';
      //               controller.handleCheckInformation();
      //             }
      //           }));
      //         },
      //         child: Text(
      //           controller.vendorAddressController.value.text == ""
      //               ? "Chọn địa chỉ"
      //               : "Thay Đổi",
      //           style: const TextStyle(color: kColorPrimaryLight),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // Container(
      //   padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      //   child: SecondaryTextfield(
      //       label: "",
      //       isEdit: false,
      //       maxLines: 3,
      //       onChanged: (text) {
      //         controller.handleCheckInformation();
      //       },
      //       controller: controller.vendorAddressController.value),
      // ),
    ],
  );
}

Widget renderChooseCategory(
    BuildContext context, CreateVendorController controller) {
  final selectedCategory = controller.selectedCategory.value;
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(
            top: 20.h,
            left: kDefaultPaddingScreen.w,
            right: kDefaultPaddingScreen.w),
        child: Text(
          "servicePick".tr,
          style: subTitleStyle,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingScreen.w,
            vertical: kDefaultPaddingWidget.h),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listCategory.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, index) {
            final CategoryModel item = listCategory[index];
            return GestureDetector(
              onTap: () {
                controller.handleUpdateSelectedCategory(item);
                controller.handleCheckInformation();
              },
              child: Container(
                  margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
                  padding: EdgeInsets.symmetric(
                      vertical: kDefaultPaddingWidget.h,
                      horizontal: kDefaultPaddingScreen.w),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                          color: selectedCategory.title == item.title
                              ? ThemeServices().isDarkMode
                                  ? kColorPrimaryDark
                                  : kColorPrimaryLight
                              : Colors.grey,
                          width: selectedCategory.title == item.title
                              ? 1.w
                              : 0.5.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(item.iconName,
                              width: 23.w,
                              color: selectedCategory.title == item.title
                                  ? ThemeServices().isDarkMode
                                      ? kColorPrimaryDark
                                      : kColorPrimaryLight
                                  : Colors.grey[600]),
                          SizedBox(
                            width: kDefaultPaddingWidget.w,
                          ),
                          Text(
                            item.title,
                            style: titleStyle.copyWith(
                              color: selectedCategory.title == item.title
                                  ? ThemeServices().isDarkMode
                                      ? kColorPrimaryDark
                                      : kColorPrimaryLight
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                          visible: selectedCategory.title == item.title,
                          child: Icon(
                            Ionicons.checkmark_circle_outline,
                            size: 18.sp,
                            color: ThemeServices().isDarkMode
                                ? kColorPrimaryDark
                                : kColorPrimaryLight,
                          ))
                    ],
                  )),
            );
          },
        ),
      ),
    ],
  );
}

Widget renderBottomAction(
    BuildContext context, CreateVendorController controller) {
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
        Visibility(
            visible: controller.isCompleteInformation.value == true,
            child: InkwellButtonLoading(
                label: "next".tr,
                onPressed: () {
                  context.router.push(const SignupVendorFourthPage());
                  // context.router.push(const SignupVendorThirdPage());
                }))
      ],
    ),
  );
}

Widget renderTitleStep(BuildContext context, String title) {
  return Container(
    padding: EdgeInsets.zero,
    child: Text(
      title,
      style: titleStyle,
    ),
  );
}
