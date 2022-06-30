import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TodoPopupVendorType extends StatefulWidget {
  TodoPopupVendorType(
      {Key? key,
      this.onBack,
      required this.categories,
      required this.listCategory})
      : super(key: key);

  final Function(
    List<CategoryType> selectedCategory,
  )? onBack;
  final List<CategoryType> categories;
  final List<CategoryType> listCategory;
  @override
  _TodoPopupVendorTypeState createState() => _TodoPopupVendorTypeState();
}

class _TodoPopupVendorTypeState extends State<TodoPopupVendorType> {
  List<CategoryType> listCategory = [];

  List<CategoryType> selectedIndex = [];
  @override
  void initState() {
    setState(() {
      selectedIndex = widget.categories;
      listCategory = widget.listCategory;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "popup-type",
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
                            "category2".tr,
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
                  SizedBox(
                    height: kDefaultPaddingWidget.h,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        // highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          if (selectedIndex.contains(listCategory[index])) {
                            setState(() {
                              selectedIndex = selectedIndex
                                  .where((element) =>
                                      element != listCategory[index])
                                  .toList();
                            });
                          } else {
                            setState(() {
                              selectedIndex = [
                                ...selectedIndex,
                                listCategory[index]
                              ];
                            });
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: defaultPaddingItem.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.zero,
                                  child: Text(
                                    listCategory[index].display(),
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  width: 18.w,
                                  height: 18.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.r),
                                      border: Border.all(
                                          width: 0.6,
                                          color: selectedIndex
                                                  .contains(listCategory[index])
                                              ? ThemeServices().isDarkMode
                                                  ? kColorPrimaryDark
                                                  : kColorPrimaryLight
                                              : ThemeServices().isDarkMode
                                                  ? kColorTextGrey
                                                  : Colors.black)),
                                  child: selectedIndex
                                          .contains(listCategory[index])
                                      ? Icon(
                                          Ionicons.checkmark_outline,
                                          size: 16,
                                          color: ThemeServices().isDarkMode
                                              ? kColorPrimaryDark
                                              : kColorPrimaryLight,
                                        )
                                      : Container(),
                                )
                              ],
                            )),
                      );
                    },
                  ),
                  SizedBox(
                    height: kDefaultPaddingWidget.h,
                  ),
                  Container(
                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding:
                        const EdgeInsets.only(right: 8, top: 16, bottom: 8),
                    child: GestureDetector(
                      onTap: () async {
                        await widget.onBack?.call(selectedIndex);
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
