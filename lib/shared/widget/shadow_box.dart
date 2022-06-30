import 'package:flutter/material.dart';

class ShadowBox extends StatelessWidget {
  const ShadowBox(
      {Key? key,
      required this.child,
      required this.radius,
      this.margin,
      this.padding})
      : super(key: key);

  final Widget child;
  final double radius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1))
        ],
      ),
      child: child,
    );
  }
}
