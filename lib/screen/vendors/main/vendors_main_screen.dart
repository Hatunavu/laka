import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:client_tggt/shared/widget/loading/loading_primary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class VendorMainScreen extends StatelessWidget {
  const VendorMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorMainController mainController =
        Get.put(VendorMainController(getIt.get<ApiClient>()));
    return GetBuilder<VendorMainController>(
      builder: (controller) {
        return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Obx(() => mainController.isLoading.isTrue
                ? const LoadingPrimaryScreen()
                : Scaffold(
                    body: mainController.getScreen(),
                    bottomNavigationBar: BottomNavigationBar(
                        onTap: mainController.changeTabIndex,
                        currentIndex: controller.tabIndex,
                        type: BottomNavigationBarType.fixed,
                        elevation: 0,
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(Ionicons.home_outline,
                                size: 26,
                                color: mainController.tabIndex == 0
                                    ? kColorPrimaryLight
                                    : HexColor(greyTextColor)),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Ionicons.reader_outline,
                                size: 26,
                                color: mainController.tabIndex == 1
                                    ? kColorPrimaryLight
                                    : HexColor(greyTextColor)),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Ionicons.albums_outline,
                                size: 26,
                                color: mainController.tabIndex == 2
                                    ? kColorPrimaryLight
                                    : HexColor(greyTextColor)),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Ionicons.chatbox_outline,
                                size: 26,
                                color: mainController.tabIndex == 3
                                    ? kColorPrimaryLight
                                    : HexColor(greyTextColor)),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Ionicons.person_circle_outline,
                                size: 26,
                                color: mainController.tabIndex == 4
                                    ? kColorPrimaryLight
                                    : HexColor(greyTextColor)),
                            label: '',
                          ),
                        ]))));
      },
    );
  }
}
