import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupVendorFourth extends StatelessWidget {
  const SignupVendorFourth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateVendorController controller =
        Get.put(CreateVendorController(getIt.get<ApiClient>()));
    controller.handleGetListAttribute();
    return Obx(() => BaseScreen(
          backgroundColor: Theme.of(context).backgroundColor,
          title: "featuredUtility".tr,
          child: Container(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPaddingScreen.w),
                      child: SingleChildScrollView(
                        child: GridView.builder(
                          padding:
                              EdgeInsets.only(top: kDefaultPaddingScreen.h),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 1.4,
                            mainAxisSpacing: kDefaultPaddingScreen.w,
                            crossAxisSpacing: kDefaultPaddingScreen.w,
                          ),
                          itemCount: controller.listAttribute.length,
                          itemBuilder: (context, index) {
                            final AttributeModel item =
                                controller.listAttribute[index];
                            return GestureDetector(
                              onTap: () {
                                controller.handleSelectAttribut(item);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPaddingScreen,
                                    vertical: kDefaultPaddingScreen.h),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        color: controller.listSelectedAttribute
                                                .contains(item)
                                            ? ThemeServices().isDarkMode
                                                ? kColorPrimaryDark
                                                : kColorPrimaryLight
                                            : Colors.grey,
                                        width: controller.listSelectedAttribute
                                                .contains(item)
                                            ? 1.h
                                            : 0.5.h)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: item.image ?? "",
                                      memCacheHeight: 200,
                                      width: 23.w,
                                      color: controller.listSelectedAttribute
                                              .contains(item)
                                          ? ThemeServices().isDarkMode
                                              ? kColorPrimaryDark
                                              : kColorPrimaryLight
                                          : ThemeServices().isDarkMode
                                              ? kColorTextGrey
                                              : Colors.black,
                                    ),
                                    SizedBox(
                                      height: kDefaultPaddingScreen.h,
                                    ),
                                    Text(
                                      item.name,
                                      textAlign: TextAlign.center,
                                      style: subTitleStyle.copyWith(
                                        color: controller.listSelectedAttribute
                                                .contains(item)
                                            ? ThemeServices().isDarkMode
                                                ? kColorPrimaryDark
                                                : kColorPrimaryLight
                                            : ThemeServices().isDarkMode
                                                ? kColorTextGrey
                                                : Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                        visible: false,
                        child: controller.listSelectedAttribute.isNotEmpty
                            ? Text(controller.listSelectedAttribute[0].name)
                            : Container())
                  ],
                )),
                renderBottomAction(context, controller),
              ],
            ),
          ),
        ));
  }
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
                  context.router.push(const SignupVendorFifthPage());
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
