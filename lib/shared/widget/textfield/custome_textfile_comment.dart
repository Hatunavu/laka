import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeTextFieldComment extends StatelessWidget {
  const CustomeTextFieldComment(
      {Key? key,
      required this.hint,
      this.controller,
      this.widget,
      this.onTap,
      this.onShowKeyboard,
      this.isLoading = false,
      this.focusNode,
      this.autoFocus = false})
      : super(key: key);
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final Function()? onTap;
  final Function()? onShowKeyboard;

  final bool? isLoading;
  final bool? autoFocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 5.w, vertical: defaultPaddingItem.h),
      child: Column(
        children: [
          Container(
            // constraints: BoxConstraints(minHeight: 42.h),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                border: Border.all(
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    width: 1.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     padding: EdgeInsets.zero,
                //     margin: EdgeInsets.only(top: 9.h),
                //     child: const Icon(
                //       Ionicons.image_outline,
                //       size: 26,
                //     ),
                //   ),
                // ),
                // const SizedBox(width: defaultPaddingItem),
                Expanded(
                    child: GestureDetector(
                  onTap: onShowKeyboard,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 1),
                    alignment: Alignment.center,
                    child: TextFormField(
                      autofocus: autoFocus!,
                      minLines: 1,
                      maxLines: 20,
                      focusNode: focusNode,
                      readOnly: widget == null ? false : true,
                      cursorColor: Theme.of(context).primaryColor,
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: AppTextStyle().subtitleRegular14Grey,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                )),
                SizedBox(width: defaultPaddingItem.w),
                isLoading == true
                    ? const CircularProgressIndicator(
                        strokeWidth: 2.0,
                      )
                    : InkWell(
                        onTap: onTap,
                        child: Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.only(top: 7.h),
                          child: Icon(
                            Ionicons.send_sharp,
                            color: Theme.of(context).primaryColor,
                            size: 23.sp,
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
