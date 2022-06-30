import 'package:client_tggt/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.marginTop = 16.0,
      this.keyboardType = TextInputType.text,
      this.isReadOnly = true,
      this.widget,
      this.onChanged,
      this.validator})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final double? marginTop;
  final bool? isReadOnly;
  final TextInputType? keyboardType;
  final dynamic onChanged;
  final dynamic validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop!),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            padding: EdgeInsets.only(left: 14.w),
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: 1.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TextFormField(
                  autofocus: false,
                  keyboardType: keyboardType,
                  readOnly: isReadOnly!,
                  onChanged: onChanged,
                  validator: validator,
                  cursorColor:
                      Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: titleStyle,
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: context.theme.backgroundColor, width: 0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: context.theme.backgroundColor, width: 0))),
                )),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
