import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/search/filter/price_range_model.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TodoPopupPrice extends StatefulWidget {
  TodoPopupPrice(
      {Key? key,
      required this.onBack,
      required this.prices,
      required this.heroTag,
      required this.listPrices})
      : super(key: key);
  final Function(
    PriceRangeModel selectedPriceRange,
  )? onBack;
  final PriceRangeModel prices;
  final String heroTag;
  final List<PriceRangeModel> listPrices;
  @override
  State<TodoPopupPrice> createState() => _TodoPopupPriceState();
}

class _TodoPopupPriceState extends State<TodoPopupPrice> {
  List<PriceRangeModel> listPrice = [];

  PriceRangeModel selectedPriceRange =
      PriceRangeModel(min: "0", max: "0", title: "");
  @override
  void initState() {
    setState(() {
      selectedPriceRange = widget.prices;
      listPrice = widget.listPrices;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
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
                              child: Icon(
                                Icons.close_rounded,
                                size: 20.sp,
                              )),
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'priceRange'.tr,
                            style: TextStyle(
                                fontSize: 16,
                                color: ThemeServices().isDarkMode
                                    ? kColorTextDark
                                    : Colors.black54),
                          ),
                        )),
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
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                        top: kDefaultPaddingWidget.h * 1.5,
                        bottom: kDefaultPaddingWidget.h * 1.5),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: kDefaultPaddingWidget.w * 1.5,
                        crossAxisSpacing: kDefaultPaddingWidget.w * 1.5,
                        childAspectRatio: 3 / 1.2),
                    itemCount: listPrice.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (selectedPriceRange == listPrice[index]) {
                            setState(() {
                              selectedPriceRange = listPrice[index];
                            });
                          } else {
                            setState(() {
                              selectedPriceRange = listPrice[index];
                            });
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                  color: selectedPriceRange == listPrice[index]
                                      ? ThemeServices().isDarkMode
                                          ? kColorPrimaryDark
                                          : kColorPrimaryLight
                                      : Colors.grey,
                                  width: 0.5.w)),
                          child: Text(
                            listPrice[index].title,
                            style: subTitleStyle.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 12.sp,
                                color: selectedPriceRange == listPrice[index]
                                    ? ThemeServices().isDarkMode
                                        ? kColorPrimaryDark
                                        : kColorPrimaryLight
                                    : Colors.grey),
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(right: 8, top: 16, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // await widget.onBack?.call(selectedDistrictData);
                            setState(() {
                              selectedPriceRange = PriceRangeModel(
                                  min: "0", max: "0", title: "");
                            });
                          },
                          child: Visibility(
                            visible: selectedPriceRange.max != "0",
                            child: Container(
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  Text("refresh".tr,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      )),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.zero,
                                    width: 60.w,
                                    height: 1.h,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await widget.onBack?.call(selectedPriceRange);
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
                            child: Text('showResult'.tr,
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
