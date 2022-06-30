import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressBar extends StatelessWidget {
  final int max;
  final int current;
  final Color? contentColor;
  final Color? backgroundColor;

  const ProgressBar({
    Key? key,
    required this.max,
    required this.current,
    this.contentColor,
    this.backgroundColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current / max) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: 6.h,
              decoration: BoxDecoration(
                color: backgroundColor ??
                    Theme.of(context).colorScheme.secondaryVariant,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: 6.h,
              decoration: BoxDecoration(
                color: contentColor ?? Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
