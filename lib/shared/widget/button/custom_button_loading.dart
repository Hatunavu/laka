import 'package:client_tggt/core/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CustomButtonLoading extends StatelessWidget {
  const CustomButtonLoading(
      {Key? key,
      this.icon,
      this.horizontal = 32.0,
      this.vertical = 16.0,
      this.borderRadius = 20})
      : super(key: key);
  final double? horizontal;
  final double? vertical;
  final double? borderRadius;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal!, vertical: vertical!),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: HexColor(secondaryColorLight),
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: LoadingOverlay(child: Container(), isLoading: true),
      ),
    );
  }
}
