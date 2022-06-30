import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class SecondaryTextfield extends StatelessWidget {
  final String label;
  final bool? isPassword;
  final bool? isEmail;
  final TextEditingController controller;
  final bool? isEdit;
  final dynamic onChanged;
  final int? maxLines;
  final int? minLines;
  final dynamic validator;
  final bool? isNumber;

  SecondaryTextfield(
      {Key? key,
      required this.label,
      this.isPassword,
      this.isEmail,
      required this.controller,
      this.onChanged,
      this.maxLines = 1,
      this.minLines = 1,
      this.isEdit = true,
      this.isNumber = false,
      this.validator})
      : super(key: key);

  final ValueNotifier _isShow = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isShow,
        builder: (context, value, _) {
          return TextFormField(
            controller: controller,
            enabled: isEdit,
            onChanged: onChanged,
            maxLines: maxLines,
            minLines: minLines,
            validator: validator,
            obscureText: isPassword == true ? !_isShow.value : false,
            keyboardType: isNumber == true
                ? TextInputType.number
                : isEmail == true
                    ? TextInputType.emailAddress
                    : TextInputType.text,
            decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontSize: 10.sp,
                ),
                // focusColor: primaryColor,
                labelText: label,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                // labelStyle: AppTextStyle().textBody,
                // floatingLabelStyle:
                //     AppTextStyle().textBody.copyWith(color: primaryColor),
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.r)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(8.r)),
                contentPadding: EdgeInsets.only(
                    top: 6.h, bottom: 6.h, left: 10.w, right: 10.w),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.r)),
                disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.r)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kColorPrimaryLight),
                    borderRadius: BorderRadius.circular(8.r)),
                suffixIcon: isPassword == true
                    ? GestureDetector(
                        onTap: () {
                          _isShow.value = !_isShow.value;
                        },
                        child: _isShow.value
                            ? const Icon(Ionicons.eye_outline)
                            : const Icon(Ionicons.eye_off_outline))
                    : null),
          );
        });
  }
}
