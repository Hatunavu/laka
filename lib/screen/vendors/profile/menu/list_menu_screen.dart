import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/profile/menu/add_menu/add_menu_controller.dart';
import 'package:client_tggt/screen/vendors/profile/menu/add_menu/add_menu_screen.dart';
import 'package:client_tggt/screen/vendors/profile/menu/list_menu_controller.dart';
import 'package:client_tggt/screen/vendors/profile/menu/widget/vendors_menu_item.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class ListMenuScreen extends StatefulWidget {
  ListMenuScreen({Key? key}) : super(key: key);
  @override
  State<ListMenuScreen> createState() => _ListMenuScreenState();
}

class _ListMenuScreenState extends State<ListMenuScreen> {
  final controller = Get.put(ListMenuController(getIt.get<ApiClient>()));
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "Quản lý menu",
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(
              Ionicons.chevron_back_outline,
              color: Theme.of(context).iconTheme.color,
            )),
        trailing: [
          GestureDetector(
            onTap: () {
              context.router.push(AddMenuPage(onBack: (MenuModel item) {
                controller.handleAddMenu(item);
              })).then((value) => {Get.delete<AddMenuController>()});
            },
            child: Container(
              padding: EdgeInsets.zero,
              child: Icon(
                Ionicons.add_outline,
                size: 23.sp,
                color: kColorPrimaryLight,
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPaddingScreen.w,
          )
        ],
        child: Obx(
          () => controller.isLoading.isTrue
              ? const LoadingScreen()
              : renderBody(context),
        ));
  }

  Widget renderBody(BuildContext context) {
    if (controller.listMenu.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text("Cơ sở của bạn chưa có thực đơn!",
            style: titleStyle.copyWith(height: 1.3),
            textAlign: TextAlign.center),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingScreen.w,
            vertical: kDefaultPaddingWidget.h),
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.listMenu.length,
            itemBuilder: (ctx, index) {
              return VendorsMenuItem(item: controller.listMenu[index]);
            }),
      );
    }
  }
}
