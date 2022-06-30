import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.label,
      required this.onTap,
      this.icon,
      this.horizontal = 32.0,
      this.vertical = 0,
      this.backgroundColor,
      this.borderRadius = 20})
      : super(key: key);
  final String label;
  final double? horizontal;
  final double? vertical;
  final double? borderRadius;
  final Function() onTap;
  final Color? backgroundColor;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal!, vertical: vertical!),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: Text(label,
            style: AppTextStyle()
                .titleRegular16
                .copyWith(color: Theme.of(context).backgroundColor)),
      ),
    );
  }
}
