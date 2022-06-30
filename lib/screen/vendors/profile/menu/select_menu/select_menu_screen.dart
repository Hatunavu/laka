import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/profile/menu/add_menu/add_menu_controller.dart';
import 'package:client_tggt/screen/vendors/profile/menu/select_menu/selected_menu_controller.dart';
import 'package:client_tggt/screen/vendors/profile/menu/select_menu/vendors_menu_item_secondary.dart';
import 'package:client_tggt/screen/vendors/profile/menu/widget/vendors_menu_item.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class SelectMenuScreen extends StatefulWidget {
  SelectMenuScreen({Key? key, this.onBack, this.selectedMenu})
      : super(key: key);
  final Function(List<SelectedMenuItemModel> listSelect)? onBack;
  final List<SelectedMenuItemModel>? selectedMenu;
  @override
  State<SelectMenuScreen> createState() => _SelectMenuScreenState();
}

class _SelectMenuScreenState extends State<SelectMenuScreen> {
  final SelectedMenuController controller =
      Get.put(SelectedMenuController(getIt.get<ApiClient>()));
  @override
  void initState() {
    // controller.handleUpdatelistSelectedMenu(widget.selectedMenu ?? []);
    controller.getListStaff(widget.selectedMenu ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "Thêm đồ",
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
      return Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPaddingScreen.w,
                  vertical: kDefaultPaddingWidget.h),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.listMenu.length,
                  itemBuilder: (ctx, index) {
                    final item = controller.listMenu[index];
                    final checkIsSelected = controller.listSelectedMenu2
                        .where((i) => i.item.id == item.id)
                        .toList();

                    return VendorsMenuItemSecondary(
                      item: controller.listMenu[index],
                      isSelected: checkIsSelected.isNotEmpty ? true : false,
                      amount: checkIsSelected.isNotEmpty
                          ? checkIsSelected[0].amount
                          : 0,
                      onSelect: () {
                        controller.handleAddSelectedMenu(
                            item, checkIsSelected.isNotEmpty ? true : false);
                      },
                      onSubAmount: () {
                        controller.onSubMenu(item);
                      },
                      onAddAmount: () {
                        controller.onAddAmount(item);
                      },
                    );
                  }),
            ),
          ),
          Visibility(
              visible: controller.listSelectedMenu2.length > 1000,
              child: Container(
                padding: EdgeInsets.zero,
                height: 100.h,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.listSelectedMenu2.length,
                    itemBuilder: (ctx, index) {
                      return VendorsMenuItem(
                        item: controller.listMenu[index],
                      );
                    }),
              )),
          Visibility(
              visible: controller.listSelectedMenu2.isNotEmpty,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWellButton(
                      label: "Xác nhận",
                      onPressed: () async {
                        await widget.onBack?.call(controller.listSelectedMenu2);
                        context.router.pop();
                      },
                    )
                  ],
                ),
              ))
        ],
      );
    }
  }
}
