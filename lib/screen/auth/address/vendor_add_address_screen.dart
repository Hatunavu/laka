import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/auth/address/vendor_add_address_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class VendorAddAdressScreen extends StatelessWidget {
  const VendorAddAdressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorAddAddressController controller =
        Get.put(VendorAddAddressController(getIt.get<ApiClient>()));
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "addAddress".tr,
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(Icons.arrow_back_ios, size: 23.sp)),
        child: Column(
          children: [
            Obx(() => Visibility(
                  visible: controller.isSelectProvices.isTrue,
                  child: renderStep(context, controller),
                )),
            Expanded(
              child: Obx(
                () => controller.isLoading.isTrue
                    ? const LoadingScreen()
                    : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              Visibility(
                                  visible: controller.currentStep.value == 0,
                                  child: renderChooseProvince(
                                      context, controller)),
                              Visibility(
                                  visible: controller.currentStep.value == 1,
                                  child: renderChooseDistrict(
                                      context, controller)),
                              Visibility(
                                  visible: controller.currentStep.value == 2,
                                  child: renderChooseWards(context, controller))
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ));
  }
}

Widget renderChooseProvince(
    BuildContext context, VendorAddAddressController controller) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h),
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'provincePick'.tr,
        style: TextStyle(fontSize: 11.sp),
      ),
      SizedBox(
        height: kDefaultPaddingWidget.h,
      ),
      ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listProvinces.length,
        itemBuilder: (ctx, index) {
          final item = controller.listProvinces[index];
          return InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              controller.handleUpdateSelectedProvices(item);
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.only(bottom: 6.h),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5.w, color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      child: Text(
                        item.name ?? "",
                        style: subTitleStyle.copyWith(
                            fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    ]),
  );
}

Widget renderChooseDistrict(
    BuildContext context, VendorAddAddressController controller) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h),
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'districtPick'.tr,
        style: TextStyle(fontSize: 11.sp),
      ),
      SizedBox(
        height: kDefaultPaddingWidget.h,
      ),
      ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listDistricts.length,
        itemBuilder: (ctx, index) {
          final item = controller.listDistricts[index];
          return InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              // controller.handleUpdateSelectedProvices(item);
              controller.handleUpdateSelectedDistrict(item);
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.only(bottom: 6.h),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5.w, color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      child: Text(
                        item.name ?? "",
                        style: subTitleStyle.copyWith(
                            fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    ]),
  );
}

Widget renderChooseWards(
    BuildContext context, VendorAddAddressController controller) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h),
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'wardPick'.tr,
        style: TextStyle(fontSize: 11.sp),
      ),
      SizedBox(
        height: kDefaultPaddingWidget.h,
      ),
      ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listWards.length,
        itemBuilder: (ctx, index) {
          final item = controller.listWards[index];
          return InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              // controller.handleUpdateSelectedProvices(item);
              // controller.handleUpdateSelectedDistrict(item);
            },
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.only(bottom: 6.h),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.5.w, color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      child: Text(
                        item.name ?? "",
                        style: subTitleStyle.copyWith(
                            fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    ]),
  );
}

Widget renderStep(BuildContext context, VendorAddAddressController controller) {
  return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'placePicked'.tr,
          style: TextStyle(fontSize: 11.sp),
        ),
        Container(
          margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: controller.selectedListProvices.value.code != "",
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        child: Icon(
                          Ionicons.ellipse,
                          size: 13.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        controller.selectedListProvices.value.name ?? "",
                        style: TextStyle(fontSize: 14.sp),
                      )
                    ],
                  )),
              Container(
                alignment: Alignment.center,
                width: 30.w,
                height: 16.h,
                child: Container(
                  width: 1.w,
                  height: 16.h,
                  color: Colors.grey,
                ),
              ),
              Visibility(
                  visible: controller.isSelectDistric.isFalse &&
                      controller.currentStep.value == 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        child: Icon(
                          Ionicons.radio_button_on_outline,
                          size: 13.sp,
                          color: kColorPrimaryLight,
                        ),
                      ),
                      Text(
                        "districtPick".tr,
                        style: TextStyle(
                            color: kColorPrimaryLight, fontSize: 14.sp),
                      )
                    ],
                  )),
              Visibility(
                  visible: controller.isSelectDistric.isTrue &&
                      controller.selectedDistrics.value.code != "",
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        child: Icon(
                          Ionicons.ellipse,
                          size: 13.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        controller.selectedDistrics.value.name ?? "",
                        style: TextStyle(fontSize: 14.sp),
                      )
                    ],
                  )),
              Container(
                alignment: Alignment.center,
                width: 30.w,
                height: 16.h,
                child: Container(
                  width: 1.w,
                  height: 16.h,
                  color: Colors.grey,
                ),
              ),
              Visibility(
                  visible: controller.isSelectWards.isFalse &&
                      controller.currentStep.value == 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        child: Icon(
                          Ionicons.radio_button_on_outline,
                          size: 13.sp,
                          color: kColorPrimaryLight,
                        ),
                      ),
                      Text(
                        "wardPick".tr,
                        style: TextStyle(
                            color: kColorPrimaryLight, fontSize: 14.sp),
                      )
                    ],
                  )),
              Visibility(
                  visible: controller.isSelectWards.isTrue &&
                      controller.selectedWards.value.code != "",
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        child: Icon(
                          Ionicons.ellipse,
                          size: 13.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: kDefaultPaddingWidget.w,
                      ),
                      Text(
                        controller.selectedWards.value.name ?? "",
                        style: TextStyle(fontSize: 14.sp),
                      )
                    ],
                  )),
            ],
          ),
        )
      ]));
}
