import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hexcolor/hexcolor.dart';

class ServiceItemSettingScreen extends StatelessWidget {
  const ServiceItemSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "Cài đặt",
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
                horizontal: kDefaultPaddingWidget.w,
                vertical: kDefaultPaddingWidget.h),
            child: Column(children: [
              Container(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Trạng thái: ".toUpperCase(),
                          style: TextStyle(
                            fontSize: 13,
                            color: HexColor(greyTextColor),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(0),
                          child: DropdownButton<String>(
                            underline: const SizedBox(),
                            value: "Hoạt động",
                            style: const TextStyle(color: Colors.green),
                            items: <String>[
                              'Hoạt động',
                              'Lưu nháp',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: defaultPaddingItem,
                    ),
                  ],
                ),
              ),
              renderLineWidget(context),
              const SizedBox(
                height: defaultPaddingItem,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPaddingItem.w,
                    vertical: kDefaultPaddingWidget.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    border: Border.all(
                        width: 1, color: HexColor(secondaryColorLight))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ẩn dịch vụ",
                      style: titleStyle,
                    ),
                    const SizedBox(
                      height: defaultPaddingItem,
                    ),
                    Text(
                        "Khi ẩn dịch vụ, bạn sẽ không thể xem và quản lý dịch vụ này nữa.!",
                        style: subTitleStyle),
                    SizedBox(
                      height: kDefaultPaddingWidget.h * 2,
                    ),
                    InkWellButton(
                      label: "Ẩn dịch vụ",
                      backgroundColor: Colors.white,
                      borderColor: HexColor(secondaryColorLight),
                      textColor: HexColor(secondaryColorLight),
                    )
                  ],
                ),
              )
            ])));
  }
}

Widget renderLineWidget(BuildContext context) {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h),
      child: Container(
          padding: EdgeInsets.zero,
          height: 1,
          decoration:
              BoxDecoration(color: HexColor(greyTextColor).withOpacity(.5))));
}
