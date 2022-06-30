import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/list_attribute/service_item_list_attribute_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceItemListAttributeScreen extends StatelessWidget {
  const ServiceItemListAttributeScreen({Key? key, this.type}) : super(key: key);
  final String? type;
  @override
  Widget build(BuildContext context) {
    final ServiceItemListAttributeController controller =
        Get.put(ServiceItemListAttributeController(getIt.get<ApiClient>()));
    controller.handleGetListAttribute(type!);
    return BaseScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      title: "Tiện ích",
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Ionicons.chevron_back_outline,
            size: 23,
            color: Colors.black,
          )),
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingScreen.w,
              vertical: kDefaultPaddingWidget.h),
          child: Obx(() => controller.isLoading.isTrue
              ? const LoadingScreen()
              : renderContent(context, controller))),
    );
  }
}

Widget renderContent(
    BuildContext context, ServiceItemListAttributeController controller) {
  return Container(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: controller.attributeType.value == "general",
                child: Text(
                  "Tiện ích chung: ".toUpperCase(),
                  style: TextStyle(
                    fontSize: 13,
                    color: HexColor(greyTextColor),
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPaddingItem,
              ),
              Visibility(
                  visible: controller.attributeType.value == "general",
                  child: Stack(
                    children: [
                      controller.listGeneralAtrribute.isNotEmpty
                          ? renderListAttribute(context,
                              controller.listGeneralAtrribute, controller)
                          : renderEmtyAttribute(
                              context, "Chưa có tiện ích chung")
                    ],
                  )),
              Visibility(
                visible: controller.attributeType.value == "custom",
                child: Text(
                  "Tiện ích của bạn: ".toUpperCase(),
                  style: TextStyle(
                    fontSize: 13,
                    color: HexColor(greyTextColor),
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPaddingItem,
              ),
              Visibility(
                  visible: controller.attributeType.value == "custom",
                  child: Stack(
                    children: [
                      controller.listCustomAtrribute.isNotEmpty
                          ? renderListAttribute(context,
                              controller.listCustomAtrribute, controller)
                          : renderEmtyAttribute(
                              context, "Chưa có tiện ích riêng")
                    ],
                  )),
              Visibility(
                visible: controller.attributeType.value == "time",
                child: Text(
                  "Thời gian: ".toUpperCase(),
                  style: TextStyle(
                    fontSize: 13,
                    color: HexColor(greyTextColor),
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPaddingItem,
              ),
              Visibility(
                  visible: controller.attributeType.value == "time",
                  child: Stack(
                    children: [
                      controller.listTimeAtrribute.isNotEmpty
                          ? renderListAttribute(
                              context, controller.listTimeAtrribute, controller)
                          : renderEmtyAttribute(
                              context, "Bạn chưa có tiện ích thời gian")
                    ],
                  )),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 32.h),
            child: InkWellButton(
              label: "Cập nhật",
              onPressed: () {
                controller.handleUpdateAttribute();
              },
              backgroundColor: Colors.white,
              borderColor: HexColor(secondaryColorLight),
              textColor: HexColor(secondaryColorLight),
            ),
          )
        ],
      ));
}

Widget renderListAttribute(
    BuildContext context,
    List<AttributeModel> listAttribute,
    ServiceItemListAttributeController controller) {
  return Obx(() => Column(children: [
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            itemCount: listAttribute.length,
            itemBuilder: (context, int index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPaddingItem),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: 26.w,
                              height: 26.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          listAttribute[index].image ??
                                              "https://www.opanvietnam.com/wp-content/uploads/2021/04/thi-cong-phong-karaoke-6.jpg"),
                                      fit: BoxFit.contain),
                                  borderRadius: BorderRadius.circular(
                                      defaultBorderRadius))),
                          const SizedBox(
                            width: defaultPaddingItem,
                          ),
                          Text(
                            listAttribute[index].name,
                            style: const TextStyle(fontSize: 13),
                          ),
                          Visibility(
                              visible: listAttribute[index].description != "",
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(":",
                                      style: TextStyle(fontSize: 13)),
                                  const SizedBox(
                                    width: defaultPaddingItem,
                                  ),
                                  Text(listAttribute[index].description!,
                                      style: const TextStyle(fontSize: 13))
                                ],
                              ))
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            controller
                                .handleCheckAttribute(listAttribute[index]);
                          },
                          child: Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: controller.listAttributeSelected
                                            .contains(listAttribute[index])
                                        ? HexColor(secondaryColorLight)
                                        : HexColor("#949AA9"))),
                            child: Stack(
                              children: [
                                Visibility(
                                    visible: controller.listAttributeSelected
                                        .contains(listAttribute[index]),
                                    child: Icon(Icons.check,
                                        size: 20,
                                        color: HexColor(secondaryColorLight))),
                              ],
                            ),
                          )),
                    ]),
              );
            }),
        Visibility(
            visible: controller.listAttributeSelected.isEmpty,
            child: Container(
                padding: EdgeInsets.zero,
                height: 0,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: controller.listAttributeSelected.length,
                    itemBuilder: (context, int index) {
                      return Text(controller.listAttributeSelected[index].id!);
                    })))
      ]));
}

Widget renderEmtyAttribute(BuildContext context, String content) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      content,
      style: subTitleStyle,
    ),
  );
}
