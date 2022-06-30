import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/not_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController mainController =
        Get.put(MainController(getIt.get<ApiClient>()));
    // final BookmarkController bookmarkController = Get.put(BookmarkController());
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "favoriteList".tr,
        leading: null,
        child: Obx(
          () => Container(
              child: mainController.userToken.value == ""
                  ? NotLoginScreen(
                      title: "loginToViewFavoriteVendor".tr,
                      subTitle: "loginToViewFavoriteVendorSub".tr)
                  : underConstruction(context)),
        ));
  }
}
