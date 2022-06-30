import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TodoPopupCity extends StatefulWidget {
  TodoPopupCity(
      {Key? key,
      required this.onBack,
      required this.listProvince,
      required this.selectedProvince})
      : super(key: key);

  final Function(
    ProvinceData selectedAttribute,
  )? onBack;
  final List<ProvinceData> listProvince;
  final ProvinceData selectedProvince;

  @override
  State<TodoPopupCity> createState() => _TodoPopupCityState();
}

class _TodoPopupCityState extends State<TodoPopupCity> {
  ProvinceData selectedProvinceData = ProvinceData();
  List<ProvinceData> listProvince = [];
  @override
  void initState() {
    setState(() {
      selectedProvinceData = widget.selectedProvince;
      listProvince = widget.listProvince;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "popup-city",
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).backgroundColor,
          child: Container(
            padding: EdgeInsets.all(defaultPaddingItem.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              padding: EdgeInsets.zero,
                              width: 30.w,
                              height: 30.w,
                              child: const Icon(
                                Icons.close_rounded,
                                size: 20,
                              )),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "province".tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: ThemeServices().isDarkMode
                                      ? kColorTextDark
                                      : Colors.black54),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.zero,
                          width: 30.w,
                          height: 30.w,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    height: 350.h,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: listProvince.length,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          // highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              selectedProvinceData = listProvince[index];
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: defaultPaddingItem.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      listProvince[index].name ?? "",
                                      style: titleStyle.copyWith(
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    width: 18.w,
                                    height: 18.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(9.r),
                                        border: Border.all(
                                            width: 0.6.w,
                                            color: listProvince[index] !=
                                                    selectedProvinceData
                                                ? Colors.grey
                                                : ThemeServices().isDarkMode
                                                    ? kColorPrimaryDark
                                                    : kColorPrimaryLight)),
                                    child: selectedProvinceData ==
                                            listProvince[index]
                                        ? Container(
                                            width: 8.w,
                                            height: 8.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.r),
                                                color:
                                                    ThemeServices().isDarkMode
                                                        ? kColorPrimaryDark
                                                        : kColorPrimaryLight),
                                          )
                                        : Container(),
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(right: 8, top: 16, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // GestureDetector(
                        //   onTap: () async {
                        //     // await widget.onBack?.call(selectedDistrictData);
                        //     setState(() {
                        //       selectedProvinceData = ProvinceData();
                        //     });
                        //   },
                        //   child: Visibility(
                        //     visible: selectedProvinceData.code != null,
                        //     child: Container(
                        //       padding: EdgeInsets.zero,
                        //       child: Column(
                        //         children: [
                        //           Text("refresh".tr,
                        //               style: TextStyle(
                        //                 fontSize: 14.sp,
                        //               )),
                        //           SizedBox(
                        //             height: 2.h,
                        //           ),
                        //           Container(
                        //             padding: EdgeInsets.zero,
                        //             width: 60.w,
                        //             height: 1.h,
                        //             color: Colors.grey,
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () async {
                            await widget.onBack?.call(selectedProvinceData);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                                color: ThemeServices().isDarkMode
                                    ? kColorPrimaryDark
                                    : kColorPrimaryLight,
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadius)),
                            child: Text("showResult".tr,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeServices().isDarkMode
                                        ? kColorTextLight
                                        : Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
