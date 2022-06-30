import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/vendor/tagline_model.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TaglinePopup extends StatefulWidget {
  TaglinePopup(
      {Key? key,
      required this.onBack,
      required this.listTagline,
      required this.heroTag,
      required this.selectedTagline})
      : super(key: key);
  final Function(
    TaglineModel selectedTagline,
  )? onBack;
  final String heroTag;
  final List<TaglineModel> listTagline;
  final TaglineModel selectedTagline;
  @override
  State<TaglinePopup> createState() => _TaglinePopupState();
}

class _TaglinePopupState extends State<TaglinePopup> {
  TaglineModel selectedTagsline = TaglineModel(id: "", name: "", type: "");
  List<TaglineModel> listTaglines = [];
  @override
  void initState() {
    setState(() {
      selectedTagsline = widget.selectedTagline;
      listTaglines = widget.listTagline;
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
                              child: const Icon(
                                Icons.close_rounded,
                                size: 20,
                              )),
                        ),
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "tagline".tr,
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
                  Container(
                    padding: EdgeInsets.zero,
                    height: 186.h,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: listTaglines.length,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          // highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              selectedTagsline = listTaglines[index];
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
                                      listTaglines[index].name,
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
                                            color: listTaglines[index] !=
                                                    selectedTagsline
                                                ? Colors.grey
                                                : ThemeServices().isDarkMode
                                                    ? kColorPrimaryDark
                                                    : kColorPrimaryLight)),
                                    child: selectedTagsline ==
                                            listTaglines[index]
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // await widget.onBack?.call(selectedDistrictData);
                            setState(() {
                              selectedTagsline =
                                  TaglineModel(id: "", name: "", type: "");
                            });
                          },
                          child: Visibility(
                            visible: selectedTagsline.name != "",
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
                            await widget.onBack?.call(selectedTagsline);
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
