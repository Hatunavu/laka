import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TodoPopupAttribute extends StatefulWidget {
  TodoPopupAttribute(
      {Key? key,
      required this.onBack,
      required this.attributes,
      required this.listAttribute})
      : super(key: key);
  final Function(
    List<AttributeModel> selectedAttribute,
  )? onBack;
  final List<AttributeModel> attributes;
  final List<AttributeModel> listAttribute;

  @override
  State<TodoPopupAttribute> createState() => _TodoPopupAttributeState();
}

class _TodoPopupAttributeState extends State<TodoPopupAttribute> {
  final _apiClient = getIt.get<ApiClient>();
  List<AttributeModel> listAttribute = [];
  List<AttributeModel> selectedAttribute = [];
  bool isLoading = false;
  @override
  void initState() {
    setState(() {
      selectedAttribute = widget.attributes;
      listAttribute = widget.listAttribute;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "popup-attribubte",
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
                            "amenities".tr,
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
                  (isLoading == true)
                      ? Container(
                          height: 350.h,
                        )
                      : Container(
                          padding: EdgeInsets.zero,
                          height: 350.h,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: listAttribute.length,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                // highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  if (selectedAttribute
                                      .contains(listAttribute[index])) {
                                    setState(() {
                                      selectedAttribute = selectedAttribute
                                          .where((element) =>
                                              element != listAttribute[index])
                                          .toList();
                                    });
                                  } else {
                                    setState(() {
                                      selectedAttribute = [
                                        ...selectedAttribute,
                                        listAttribute[index]
                                      ];
                                    });
                                  }
                                },
                                child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: defaultPaddingItem.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.zero,
                                          child: Text(
                                            listAttribute[index].name,
                                            style: titleStyle.copyWith(
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Container(
                                          width: 18.w,
                                          height: 18.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3.r),
                                              border: Border.all(
                                                  width: 0.6,
                                                  color: selectedAttribute
                                                          .contains(
                                                              listAttribute[
                                                                  index])
                                                      ? ThemeServices()
                                                              .isDarkMode
                                                          ? kColorPrimaryDark
                                                          : kColorPrimaryLight
                                                      : ThemeServices()
                                                              .isDarkMode
                                                          ? kColorTextGrey
                                                          : Colors.black)),
                                          child: selectedAttribute.contains(
                                                  listAttribute[index])
                                              ? Icon(
                                                  Ionicons.checkmark_outline,
                                                  size: 16,
                                                  color:
                                                      ThemeServices().isDarkMode
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
                        await widget.onBack?.call(selectedAttribute);
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
                        child: Text("viewResult".tr,
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
