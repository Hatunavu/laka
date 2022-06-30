import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/services_item_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceItemAttributeScreen extends StatelessWidget {
  const ServiceItemAttributeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceItemController serviceItemController =
        Get.put(ServiceItemController(getIt.get<ApiClient>()));
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
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingWidget.w,
              vertical: kDefaultPaddingWidget.h),
          child: Column(children: [
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tiện ích chung: ".toUpperCase(),
                        style: TextStyle(
                          fontSize: 13,
                          color: HexColor(greyTextColor),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            // Get.to(() => const ServiceItemListAttributeScreen(),
                            //     arguments: {"type": "general"});
                            context.router
                                .push(AttributeListPage(type: "general"));
                          },
                          child: Icon(
                            Ionicons.create_outline,
                            size: 23,
                            color: HexColor(secondaryColorLight),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: defaultPaddingItem,
                  ),
                  Visibility(
                      visible:
                          serviceItemController.listGeneralAtrribute.isNotEmpty,
                      child: Obx(() => renderListAttribute(
                          context, serviceItemController.listGeneralAtrribute)))

                  // Text(
                  //   serviceItemController.serviceItem.value.name,
                  //   style: titleStyle,
                  // )
                ],
              ),
            ),
            renderLineWidget(context),
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Thời gian: ".toUpperCase(),
                        style: TextStyle(
                          fontSize: 13,
                          color: HexColor(greyTextColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Get.to(() => const ServiceItemListAttributeScreen(),
                          //     arguments: {"type": "time"});
                          context.router.push(AttributeListPage(type: "time"));
                        },
                        child: Icon(
                          Ionicons.create_outline,
                          size: 23,
                          color: HexColor(secondaryColorLight),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: defaultPaddingItem,
                  ),
                  Visibility(
                      visible:
                          serviceItemController.listTimeAtrribute.isNotEmpty,
                      child: Obx(() => renderListAttribute(
                          context, serviceItemController.listTimeAtrribute)))

                  // Text(
                  //   serviceItemController.serviceItem.value.name,
                  //   style: titleStyle,
                  // )
                ],
              ),
            ),
            renderLineWidget(context),
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tiện ích của bạn: ".toUpperCase(),
                        style: TextStyle(
                          fontSize: 13,
                          color: HexColor(greyTextColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Get.to(() => const ServiceItemListAttributeScreen(),
                          //     arguments: {"type": "custom"});
                          context.router
                              .push(AttributeListPage(type: "custom"));
                        },
                        child: Icon(
                          Ionicons.create_outline,
                          size: 23,
                          color: HexColor(secondaryColorLight),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: defaultPaddingItem,
                  ),
                  Visibility(
                      visible:
                          serviceItemController.listCustomAtrribute.isNotEmpty,
                      child: Obx(() => renderListAttribute(
                          context, serviceItemController.listCustomAtrribute)))
                ],
              ),
            ),
            renderLineWidget(context),
          ])),
    );
  }
}

Widget renderListAttribute(
    BuildContext context, List<AttributeModel> listAttribute) {
  return Column(children: [
    ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemCount: listAttribute.length,
        itemBuilder: (context, int index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: defaultPaddingItem),
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
                                  image: CachedNetworkImageProvider(listAttribute[
                                              index]
                                          .image ??
                                      "https://www.opanvietnam.com/wp-content/uploads/2021/04/thi-cong-phong-karaoke-6.jpg"),
                                  fit: BoxFit.contain),
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius))),
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
                            const Text(":", style: TextStyle(fontSize: 13)),
                            const SizedBox(
                              width: defaultPaddingItem,
                            ),
                            Text(listAttribute[index].description!,
                                style: const TextStyle(fontSize: 13))
                          ],
                        ),
                      )
                    ],
                  ),
                ]),
          );
        }),
  ]);
}

Widget renderLineWidget(BuildContext context) {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.w),
      child: Container(
          padding: EdgeInsets.zero,
          height: 0.5,
          decoration:
              BoxDecoration(color: HexColor(greyTextColor).withOpacity(.5))));
}
