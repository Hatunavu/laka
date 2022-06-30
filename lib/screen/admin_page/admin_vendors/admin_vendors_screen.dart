import 'package:client_tggt/core/theme/theme.dart';

import 'package:client_tggt/shared/base_screen.dart';

import 'package:flutter/material.dart';

class AdminVendorsScreen extends StatefulWidget {
  AdminVendorsScreen({Key? key}) : super(key: key);

  @override
  State<AdminVendorsScreen> createState() => _AdminVendorsScreenState();
}

class _AdminVendorsScreenState extends State<AdminVendorsScreen> {
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
