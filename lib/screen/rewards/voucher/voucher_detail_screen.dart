import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:client_tggt/screen/rewards/voucher/voucher_detail_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class VoucherDetailScreen extends StatelessWidget {
  const VoucherDetailScreen({Key? key, required this.voucherDetail})
      : super(key: key);
  final VoucherModel voucherDetail;
  @override
  Widget build(BuildContext context) {
    final VoucherDetailController controller =
        Get.put(VoucherDetailController());
    return Scaffold(
      body: Container(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              renderHeader(context, controller),
              renderBody(context, controller, voucherDetail)
            ],
          )),
    );
  }
}

Widget renderHeader(BuildContext context, VoucherDetailController controller) {
  return Container(
    padding: EdgeInsets.zero,
    height: MediaQuery.of(context).size.height * 0.3,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppPath.bannerLaka1), fit: BoxFit.cover)),
    child: Stack(
      children: [
        Positioned(
            top: kDefaultPaddingWidget.h * 2,
            left: kDefaultPaddingWidget.w * 1.5,
            child: InkWell(
              onTap: () {
                context.router.pop();
              },
              child: Container(
                width: 68.w,
                height: 50.h,
                alignment: Alignment.topLeft,
                child: Icon(
                  Ionicons.close_circle_outline,
                  color: Theme.of(context).backgroundColor,
                  size: 26.sp,
                ),
              ),
            ))
      ],
    ),
  );
}

Widget renderBody(BuildContext context, VoucherDetailController controller,
    VoucherModel item) {
  return Container(
    margin: EdgeInsets.only(top: kDefaultPaddingWidget.h * 1.5),
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    child: Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          child: Text(
            item.title,
            style: titleStyle.copyWith(
                fontSize: 18.sp, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        Container(
          padding: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
          decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(width: 0.3.w, color: kColorSecondaryLight))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 0.3.w, color: kColorSecondaryLight))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "rewards".tr,
                        style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: kDefaultPaddingItem.h,
                      ),
                      // Text(
                      //   item.point,
                      //   style: subTitleStyle.copyWith(
                      //       fontWeight: FontWeight.w500,
                      //       color: ThemeServices().isDarkMode
                      //           ? kColorPrimaryDark
                      //           : kColorPrimaryLight),
                      // )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "expiredDay".tr,
                      style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: kDefaultPaddingItem.h,
                    ),
                    Text(
                      "dec2022".tr,
                      style: subTitleStyle,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        // Container(
        //   padding: EdgeInsets.zero,
        //   child: Text(
        //     item.description,
        //     style:
        //         titleStyle.copyWith(fontWeight: FontWeight.w400, height: 1.3),
        //   ),
        // ),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "highlights".tr,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: ThemeServices().isDarkMode
                        ? Colors.white
                        : Colors.black),
              ),
              SizedBox(
                height: kDefaultPaddingItem.h,
              ),
              Text("voucher500".tr,
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.w400, height: 1.3))
            ],
          ),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "rules".tr,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: ThemeServices().isDarkMode
                        ? Colors.white
                        : Colors.black),
              ),
              SizedBox(
                height: kDefaultPaddingItem.h,
              ),
              RichText(
                text: TextSpan(
                  text: '- ',
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.w400, height: 1.3),
                  children: <TextSpan>[
                    TextSpan(text: 'applyHCM'.tr),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '- ',
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.w400, height: 1.3),
                  children: <TextSpan>[
                    TextSpan(text: 'limit2'.tr),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '- ',
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.w400, height: 1.3),
                  children: <TextSpan>[
                    TextSpan(text: 'notCombine'.tr),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
