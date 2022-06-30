import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownListButton<T> extends StatelessWidget {
  const DropDownListButton({
    Key? key,
    required this.listItem,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  final List<T> listItem;
  final T selectedValue;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        icon: Padding(
          padding: EdgeInsets.only(left: 4.0.w),
          child: Icon(
            CupertinoIcons.chevron_down,
            color: Theme.of(context).primaryColor,
            size: 14,
          ),
        ),
        items: listItem
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: AppTextStyle().subtitleRegular14,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          onChanged(value);
        },
        focusColor: Theme.of(context).backgroundColor,
        buttonHeight: kDefaultButtonHeight35.h,
        itemHeight: kDefaultButtonHeight35.h,
        dropdownDecoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(defaultBorderRadius.r),
          // border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        ),
      ),
    );
  }
}
