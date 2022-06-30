import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class RewardsGuideScreen extends StatelessWidget {
  const RewardsGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Ionicons.chevron_back_outline,
            size: 23,
            color: Colors.black,
          )),
      title: 'pointGuide'.tr,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Text(
          "featureDeveloping".tr,
          style: titleStyle,
        ),
      ),
    );
  }
}
