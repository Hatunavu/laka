import 'package:flutter/material.dart';

class BaseScreenSecondary extends StatelessWidget {
  const BaseScreenSecondary({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: GestureDetector(
        child: SafeArea(child: child),
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
      ),
    );
  }
}
