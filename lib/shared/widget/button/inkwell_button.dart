import 'package:auto_size_text/auto_size_text.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class InkWellButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? label;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double? maxWidth;
  final double? maxHeight;
  final TextStyle? style;
  final Color? borderColor;
  final double? borderWidth;
  final Color? textColor;
  final EdgeInsets? padding;
  final Widget? icon;
  final bool? textWithIcon;

  const InkWellButton(
      {Key? key,
      this.onPressed,
      this.label,
      this.borderRadius,
      this.backgroundColor,
      this.borderColor,
      this.textColor,
      this.borderWidth,
      this.maxWidth,
      this.maxHeight,
      this.style,
      this.padding,
      this.icon,
      this.textWithIcon = false})
      : super(key: key);

  InkWellButton.outline({
    Key? key,
    void Function()? onPressed,
    String? label,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    double? maxWidth,
    double? maxHeight,
    TextStyle? style,
    Color? borderColor,
    double? borderWidth,
    Color? textColor,
    EdgeInsets? padding,
    Widget? icon,
  }) : this(
          key: key,
          onPressed: onPressed,
          label: label,
          borderRadius: borderRadius,
          backgroundColor: Colors.transparent,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          style: style,
          borderColor: ThemeServices().isDarkMode
              ? kColorPrimaryDark
              : kColorPrimaryLight,
          borderWidth: 1.0,
          textColor: ThemeServices().isDarkMode
              ? kColorPrimaryDark
              : kColorPrimaryLight,
          padding: padding,
          icon: icon,
        );

  InkWellButton.disable({
    Key? key,
    void Function()? onPressed,
    String? label,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    double? maxWidth,
    double? maxHeight,
    TextStyle? style,
    Color? borderColor,
    double? borderWidth,
    Color? textColor,
    EdgeInsets? padding,
    Widget? icon,
  }) : this(
          key: key,
          onPressed: onPressed,
          label: label,
          borderRadius: borderRadius,
          backgroundColor:
              ThemeServices().isDarkMode ? kColorGreyDark : disableColor,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          style: style,
          borderColor: borderColor,
          borderWidth: borderWidth,
          textColor: textColor,
          padding: padding,
          icon: icon,
        );

  InkWellButton.small({
    Key? key,
    void Function()? onPressed,
    String? label,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    double? maxWidth,
    double? maxHeight,
    TextStyle? style,
    Color? borderColor,
    double? borderWidth,
    Color? textColor,
    EdgeInsets? padding,
    Widget? icon,
  }) : this(
          key: key,
          onPressed: onPressed,
          label: label,
          borderRadius: borderRadius,
          backgroundColor: backgroundColor,
          maxWidth: maxWidth,
          maxHeight: 19.h,
          style: style,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          textColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          icon: icon,
        );

  InkWellButton.outlineSmall({
    Key? key,
    void Function()? onPressed,
    String? label,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    double? maxWidth,
    double? maxHeight,
    TextStyle? style,
    Color? borderColor,
    double? borderWidth,
    Color? textColor,
    EdgeInsets? padding,
    Widget? icon,
  }) : this(
          key: key,
          onPressed: onPressed,
          label: label,
          borderRadius: borderRadius,
          backgroundColor: Colors.transparent,
          maxWidth: maxWidth,
          maxHeight: 19.h,
          style: style,
          borderColor:
              ThemeServices().isDarkMode ? kColorGreyDark : disableColor,
          borderWidth: 1.0,
          textColor: ThemeServices().isDarkMode ? kColorGreyDark : disableColor,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          icon: icon,
        );

  const InkWellButton.smallDisable(
      {Key? key,
      this.onPressed,
      this.label,
      this.borderRadius,
      this.backgroundColor = disableColor,
      this.borderColor = Colors.transparent,
      this.textColor = disableText,
      this.borderWidth = 0.0,
      this.maxWidth = double.infinity,
      this.maxHeight = 20,
      this.style,
      this.padding,
      this.icon,
      this.textWithIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: onPressed ?? () {},
      child: Container(
        // width: maxWidth ?? double.infinity,
        height: maxHeight ?? 45,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor,
          border: Border.all(
              width: borderWidth ?? 0,
              color: borderColor ?? Colors.transparent),
          borderRadius: borderRadius ?? BorderRadius.circular(999),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(8.0),
          child: Center(
            child: textWithIcon == true
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          child: icon ??
                              Icon(
                                Ionicons.calendar_outline,
                                color: Theme.of(context).backgroundColor,
                              ),
                        ),
                        SizedBox(
                          width: kDefaultPaddingItem.w,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2.h),
                          child: AutoSizeText(label ?? '',
                              style: style?.copyWith(
                                      color: textColor ??
                                          (ThemeServices().isDarkMode
                                              ? kColorBackgroundDark
                                              : kColorBackgroundLight)) ??
                                  TextStyle(
                                      color: textColor ??
                                          (ThemeServices().isDarkMode
                                              ? kColorBackgroundDark
                                              : kColorBackgroundLight))),
                        )
                      ],
                    ),
                  )
                : icon ??
                    (label != null
                        ? AutoSizeText(label ?? '',
                            style: style?.copyWith(
                                    color: textColor ??
                                        (ThemeServices().isDarkMode
                                            ? kColorBackgroundDark
                                            : kColorBackgroundLight)) ??
                                TextStyle(
                                    color: textColor ??
                                        (ThemeServices().isDarkMode
                                            ? kColorBackgroundDark
                                            : kColorBackgroundLight)))
                        : const SizedBox.shrink()),
          ),
        ),
      ),
    );
  }
}
