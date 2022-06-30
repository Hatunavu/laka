import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:hexcolor/hexcolor.dart';

class DialogTextField extends StatelessWidget {
  final BuildContext context;
  final String title;
  final Function()? onDismiss;
  final Function()? onConfirm;
  final int? minLines;
  final int? maxLines;
  final String? hint;
  final String? confirmTitlel;
  final TextEditingController controller;
  final TextInputType? inputType;

  const DialogTextField(
      {Key? key,
      required this.context,
      required this.controller,
      required this.title,
      this.confirmTitlel,
      this.onConfirm,
      this.inputType = TextInputType.text,
      this.onDismiss,
      this.minLines = 10,
      this.maxLines = 30,
      this.hint})
      : super(key: key);

  @override
  Widget build(context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(kDefaultPaddingScreen.w),
      child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(
                      left: kDefaultPaddingScreen.w,
                      right: kDefaultPaddingScreen.w,
                      bottom: 16.h,
                      top: 5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: onDismiss,
                            child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Ionicons.close_circle_sharp,
                                  color: HexColor(secondaryColorLight),
                                  size: 30,
                                ))),
                      ),
                      const SizedBox(
                        height: defaultPaddingItem,
                      ),
                      Text(
                        title,
                        style: titleStyle,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, bottom: 20.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey, width: 1.0)),
                        child: TextFormField(
                            cursorColor: const Color(0xFF9b9b9b),
                            autofocus: true,
                            maxLines: maxLines,
                            controller: controller,
                            minLines: minLines,
                            keyboardType: inputType,
                            decoration: InputDecoration(
                                hintText: hint,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: context.theme.backgroundColor,
                                        width: 0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: context.theme.backgroundColor,
                                        width: 0)))),
                      ),
                      SizedBox(
                        height: kDefaultPaddingWidget.h,
                      ),
                      InkWellButton(
                          onPressed: onConfirm,
                          label: confirmTitlel != null
                              ? confirmTitlel!
                              : "Xác nhận",
                          // maxWidth: 200.w,
                          borderWidth: 1,
                          borderColor: HexColor(secondaryColorLight),
                          backgroundColor: Colors.transparent,
                          textColor: HexColor(secondaryColorLight))
                    ],
                  ))
            ],
          )),
    );
  }
}
