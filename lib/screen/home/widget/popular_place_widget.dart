import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/filter_vendors/filter_vendors_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PopularPlaceWidget extends StatelessWidget {
  const PopularPlaceWidget(
      {Key? key,
      required this.placeCount,
      required this.placeImage,
      required this.placeTitle,
      required this.imageSize,
      required this.cityCode})
      : super(key: key);
  final int placeCount;
  final String placeTitle;
  final String placeImage;
  final double imageSize;
  final String cityCode;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router
            .push(FilterVendorsPage(
                type: placeTitle, isFilterByCity: true, cityCode: cityCode))
            .then((value) {
          Get.delete<FilterVendorsController>();
        });
      },
      child: Container(
          padding: const EdgeInsets.all(0),
          // width: imageSize - 10.w,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SvgPicture.asset(
              placeImage,
              color: ThemeServices().isDarkMode
                  ? kColorPrimaryDark
                  : kColorPrimaryLight,
              fit: BoxFit.cover,
              height: imageSize,
            ),
            Text(
              placeTitle,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: ThemeServices().isDarkMode
                      ? kColorTextDark
                      : kColorTextLight,
                  fontWeight: FontWeight.w500),
            )
          ])),
    );
  }
}
