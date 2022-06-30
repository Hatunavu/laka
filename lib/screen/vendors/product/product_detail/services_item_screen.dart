import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/services_item_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceItemScreen extends StatelessWidget {
  const ServiceItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceItemController serviceItemController =
        Get.put(ServiceItemController(getIt.get<ApiClient>()));
    return BaseScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      title: "Thông tin dịch vụ",
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Ionicons.chevron_back_outline,
            size: 23,
            color: Colors.black,
          )),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingScreen.w,
            vertical: kDefaultPaddingWidget.h),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.h,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/bar/bar3.jpg"),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              height: kDefaultPaddingWidget.h * 1.5,
            ),
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        // Get.to(() => const ServiceItemDetailScreen());
                        // context.router.navigate(const ServiceItemDetailPage());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: kDefaultPaddingWidget.h * 1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Thông tin dịch vụ: ",
                              style: titleStyle,
                            ),
                            Icon(
                              Ionicons.arrow_forward_outline,
                              color: HexColor(secondaryColorLight),
                              size: 23,
                            )
                          ],
                        ),
                      )),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                        color: HexColor(greyTextColor).withOpacity(.5)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(() => const ServiceItemGalleryScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: kDefaultPaddingWidget.h * 1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Thư viện ảnh: ",
                              style: titleStyle,
                            ),
                            Icon(
                              Ionicons.arrow_forward_outline,
                              color: HexColor(secondaryColorLight),
                              size: 23,
                            )
                          ],
                        ),
                      )),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                        color: HexColor(greyTextColor).withOpacity(.5)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(() => const ServiceItemAttributeScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: kDefaultPaddingWidget.h * 1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Tiện ích: ",
                              style: titleStyle,
                            ),
                            Icon(
                              Ionicons.arrow_forward_outline,
                              color: HexColor(secondaryColorLight),
                              size: 23,
                            )
                          ],
                        ),
                      )),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                        color: HexColor(greyTextColor).withOpacity(.5)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(() => const ServiceItemBookingScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: kDefaultPaddingWidget.h * 1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Quản lý đặt lịch: ",
                              style: titleStyle,
                            ),
                            Icon(
                              Ionicons.arrow_forward_outline,
                              color: HexColor(secondaryColorLight),
                              size: 23,
                            )
                          ],
                        ),
                      )),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                        color: HexColor(greyTextColor).withOpacity(.5)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(() => const ServiceItemRevenueScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: kDefaultPaddingWidget.h * 1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Doanh thu: ",
                              style: titleStyle,
                            ),
                            Icon(
                              Ionicons.arrow_forward_outline,
                              color: HexColor(secondaryColorLight),
                              size: 23,
                            )
                          ],
                        ),
                      )),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                        color: HexColor(greyTextColor).withOpacity(.5)),
                  ),
                  InkWell(
                      onTap: () {
                        // Get.to(() => const ServiceItemSettingScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: kDefaultPaddingWidget.h * 1.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Cài đặt khác: ",
                              style: titleStyle,
                            ),
                            Icon(
                              Ionicons.arrow_forward_outline,
                              color: HexColor(secondaryColorLight),
                              size: 23,
                            )
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
