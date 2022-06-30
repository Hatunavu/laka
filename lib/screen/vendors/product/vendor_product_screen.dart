import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/product/add_product/vendor_add_product_controller.dart';
import 'package:client_tggt/screen/vendors/product/vendor_product_controller.dart';
import 'package:client_tggt/screen/vendors/product/widget/product_item.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

class VendorProductScreen extends StatelessWidget {
  const VendorProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final VendorProductController productController =
        Get.put(VendorProductController(getIt.get<ApiClient>()));

    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "Quản lý dịch vụ",
        trailing: [
          InkWell(
              onTap: () {
                // Get.to(() => const VendorAddProductScreen());
                context.router.navigate(const VendorAddProductPage());
              },
              child: Icon(
                Ionicons.add,
                size: 30,
                color: HexColor(secondaryColorLight),
              )),
          SizedBox(
            width: kDefaultPaddingScreen.w,
          )
        ],
        child: Obx(() => productController.isLoading.isTrue
            ? const LoadingScreen()
            : Container(
                padding:
                    EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
                margin: EdgeInsets.only(
                    top: kDefaultPaddingWidget.h - 5,
                    bottom: kDefaultPaddingWidget.h),
                child: renderListServices(context, productController))));
  }
}

Widget renderListServices(
    BuildContext context, VendorProductController controller) {
  final VendorProductController productController =
      Get.put(VendorProductController(getIt.get<ApiClient>()));
  return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          renderStatusListService(context, productController),
          Padding(
              padding: EdgeInsets.only(
                  top: kDefaultPaddingWidget.h,
                  bottom: kDefaultPaddingWidget.h * 2),
              child: Container(
                height: 1,
                decoration: BoxDecoration(color: HexColor(greyTextColor)),
              )),
          Visibility(
              visible: controller.listServices.isEmpty,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: kDefaultPaddingWidget.h * 2),
                child: Text(
                  "Chưa có dịch vụ trong danh sách này!",
                  style: titleStyle,
                ),
              )),
          Visibility(
              visible: controller.listServices.isNotEmpty,
              child: Expanded(
                  child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        controller.handleGetListProduct(10, 1, "", "");
                      },
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: controller.listServiceController,
                          padding: EdgeInsets.zero,
                          itemCount: controller.listServices.length,
                          itemBuilder: (context, int index) {
                            final ServicesModel item =
                                controller.listServices[index];
                            return ProductItem(serviceItem: item);
                          })))),
        ],
      ));
}

Widget renderStatusListService(
    BuildContext context, VendorProductController controller) {
  return Container(
    padding: EdgeInsets.zero,
    child: Row(
      children: [
        Container(
            padding: EdgeInsets.zero,
            height: 40,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: controller.listStatusServices.length,
                itemBuilder: (item, int index) {
                  return Obx(
                    () => InkWell(
                        onTap: () {
                          controller.handleChangeStatus(index);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                              border: Border.all(
                                  color:
                                      controller.statusServicesSelected.value ==
                                              index
                                          ? kColorPrimaryLight
                                          : Colors.transparent)),
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(controller.listStatusServices[index]),
                        )),
                  );
                })),
      ],
    ),
  );
}

Widget renderEmptyProduct(BuildContext context) {
  return Expanded(
      child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Bạn chưa có gói dịch vụ nào. Hãy tạo ngay.",
            textAlign: TextAlign.center, style: titleStyle),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        InkWellButton(
          label: "addMoreServices",
          onPressed: () {
            // Get.bottomSheet(
            //   renderBottomSheet(context),
            //   isScrollControlled: true,
            //   enableDrag: true,
            // );
            // Get.to(() => const VendorAddProductScreen());
            context.router.navigate(const VendorAddProductPage()).then((value) {
              Get.delete<VendorAddProductController>();
            });
          },
        )
      ],
    ),
  ));
}
