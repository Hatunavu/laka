import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';

class AdminNotificationScreen extends StatefulWidget {
  AdminNotificationScreen({Key? key}) : super(key: key);

  @override
  State<AdminNotificationScreen> createState() =>
      _AdminNotificationScreenState();
}

class _AdminNotificationScreenState extends State<AdminNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          "Tính năng đang được phát triển",
          style: titleStyle,
        ),
      ),
    );
  }
}
