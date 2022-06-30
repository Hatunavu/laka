import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/product/vendor_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/instance_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:auto_route/auto_route.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({required this.serviceItem, Key? key}) : super(key: key);
  final ServicesModel serviceItem;
  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,##0  đ', 'ID');
    final VendorProductController productController =
        Get.put(VendorProductController(getIt.get<ApiClient>()));
    return InkWell(
        onTap: () {
          // Get.to(() => const ServiceItemDetailScreen(),
          //     arguments: {"serviceItemId": serviceItem.id});
          context.router
              .push(ServiceItemDetailPage(serviceItemId: serviceItem.id));
        },
        child: Container(
          padding: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width - 20.w) * 0.2,
                    height: (MediaQuery.of(context).size.width - 20.w) * 0.2,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        image: DecorationImage(
                            // image: AssetImage("assets/images/bar/bar3.jpg"),
                            image: CachedNetworkImageProvider(
                                serviceItem.thumbnail?.path ?? ""),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: defaultPaddingItem,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 6),
                    height: (MediaQuery.of(context).size.width - 20.w) * 0.2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.zero,
                              width:
                                  (MediaQuery.of(context).size.width - 30.w) *
                                      0.78,
                              child: Wrap(children: [
                                Text(
                                  serviceItem.name ?? "",
                                  style: titleStyle,
                                ),
                              ])),
                          const SizedBox(
                            height: defaultPaddingItem,
                          ),
                          Text(
                            currencyFormatter
                                .format(double.parse('${serviceItem.price}')),
                            style: const TextStyle(fontSize: 14),
                          ),
                          Visibility(
                              visible: serviceItem.status == "draft",
                              child: const SizedBox(
                                height: 5,
                              )),
                          Visibility(
                            visible: serviceItem.status == "draft",
                            child: RichText(
                              text: TextSpan(
                                text: 'Trạng thái: ',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: 'Lưu nháp',
                                  ),
                                ],
                              ),
                            ),
                          )
                        ]),
                  )
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              Visibility(
                  visible: serviceItem.status != "draft",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: (MediaQuery.of(context).size.width - 20.w) / 2,
                          padding: const EdgeInsets.only(
                              right: defaultPaddingItem / 2),
                          child: Row(
                            children: [
                              const Icon(
                                Ionicons.checkmark_circle_outline,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Đã đặt: ',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: HexColor(greyTextColor)),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: '10',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Container(
                          width: (MediaQuery.of(context).size.width - 20.w) / 2,
                          padding: const EdgeInsets.only(
                              right: defaultPaddingItem / 2),
                          child: Row(
                            children: [
                              const Icon(
                                Ionicons.eye_outline,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Lượt xem: ',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: HexColor(greyTextColor)),
                                  children: const <TextSpan>[
                                    TextSpan(
                                      text: '300',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  )),
              Visibility(
                visible: serviceItem.status != "draft",
                child: SizedBox(
                  height: 8.h,
                ),
              ),
              Visibility(
                visible: serviceItem.status != "draft",
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: (MediaQuery.of(context).size.width - 20.w) / 2,
                        padding: const EdgeInsets.only(
                            right: defaultPaddingItem / 2),
                        child: Row(
                          children: [
                            const Icon(
                              Ionicons.heart_outline,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Lượt thích: ',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: HexColor(greyTextColor)),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: '50',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    Container(
                        width: (MediaQuery.of(context).size.width - 20.w) / 2,
                        padding: const EdgeInsets.only(
                            right: defaultPaddingItem / 2),
                        child: Row(
                          children: [
                            const Icon(
                              Ionicons.alert_circle_outline,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Visibility(
                                visible: serviceItem.active == true,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Trạng thái: ',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: HexColor(greyTextColor)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: "Còn phòng",
                                          style:
                                              TextStyle(color: Colors.green)),
                                    ],
                                  ),
                                )),
                            Visibility(
                                visible: serviceItem.active == false,
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Trạng thái: ',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: HexColor(greyTextColor)),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "Hết phòng",
                                          style: TextStyle(
                                              color: HexColor(
                                                  secondaryColorLight))),
                                    ],
                                  ),
                                )),
                          ],
                        )),
                  ],
                ),
              ),

              Visibility(
                  visible: serviceItem.status != "draft",
                  child: const SizedBox(
                    height: defaultPaddingItem,
                  )),

              Visibility(
                visible: serviceItem.status != "draft",
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Tình trạng phòng: ',
                          style: TextStyle(
                              fontSize: 15, color: HexColor(greyTextColor))),
                      Container(
                        margin: EdgeInsets.only(right: kDefaultPaddingWidget.h),
                        child: Switch(
                            value: serviceItem.active ?? false,
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              serviceItem.active == true
                                  ? productController.handleUpdateStatus(
                                      serviceItem.id!, false)
                                  : productController.handleUpdateStatus(
                                      serviceItem.id!, true);
                            }),
                      )
                    ]),
              ),

              // AnimatedToggle(
              //   values: const ['Còn', 'Hết'],
              //   onToggleCallback: (value) {
              //     // setState(() {
              //     //   _toggleValue = value;
              //     // });
              //     serviceItem.active == true
              //         ? productController.handleUpdateStatus(
              //             serviceItem.id!, false)
              //         : productController.handleUpdateStatus(
              //             serviceItem.id!, true);
              //   },
              //   buttonColor: serviceItem.active == true
              //       ? Colors.green
              //       : HexColor("#c2c2c2"),
              //   backgroundColor: serviceItem.active == true
              //       ? HexColor("#c2c2c2")
              //       : HexColor(secondaryColorLight),
              //   textColor: serviceItem.active == true
              //       ? Colors.black
              //       : const Color(0xFFFFFFFF),
              //   textColor2: serviceItem.active == true
              //       ? const Color(0xFFFFFFFF)
              //       : Colors.black,
              // ),
              // Visibility(
              //     visible: serviceItem.active == true,
              //     child: InkWell(
              //         onTap: () {
              //           showDialog<void>(
              //             context: context,
              //             barrierDismissible: false,
              //             builder: (BuildContext dialogContext) {
              //               return CustomCupertinoAlert(
              //                 context: context,
              //                 title: 'Thông báo',
              //                 content:
              //                     'Bạn muốn xác nhận dịch vụ này đã hết phòng?',
              //                 rightButtonTitle: 'Xác nhận',
              //                 rightAction: () {
              //                   productController.handleUpdateStatus(
              //                       serviceItem.id!, false);
              //                   Navigator.pop(context);
              //                 },
              //               );
              //             },
              //           );
              //         },
              //         child: Container(
              //             width: double.infinity,
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //                 borderRadius:
              //                     BorderRadius.circular(defaultBorderRadius),
              //                 border:
              //                     Border.all(color: Colors.green, width: 0.5)),
              //             padding: const EdgeInsets.only(top: 8, bottom: 8),
              //             child: const Text("Cập nhật hết phòng",
              //                 style: TextStyle(color: Colors.green))))),
              // Visibility(
              //     visible: serviceItem.active == false,
              //     child: InkWell(
              //         onTap: () {
              //           showDialog<void>(
              //             context: context,
              //             barrierDismissible: false,
              //             builder: (BuildContext dialogContext) {
              //               return CustomCupertinoAlert(
              //                 context: context,
              //                 title: 'Thông báo',
              //                 content:
              //                     'Bạn muốn xác nhận dịch vụ này đã có phòng?',
              //                 rightButtonTitle: 'Xác nhận',
              //                 rightAction: () {
              //                   productController.handleUpdateStatus(
              //                       serviceItem.id!, true);
              //                   Navigator.pop(context);
              //                 },
              //               );
              //             },
              //           );
              //         },
              //         child: Container(
              //             width: double.infinity,
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //                 borderRadius:
              //                     BorderRadius.circular(defaultBorderRadius),
              //                 border: Border.all(
              //                     color: HexColor(secondaryColorLight),
              //                     width: 0.5)),
              //             padding: const EdgeInsets.only(top: 8, bottom: 8),
              //             child: Text("Cập nhật còn phòng",
              //                 style: TextStyle(
              //                     color: HexColor(secondaryColorLight)))))),
              const SizedBox(
                height: defaultPaddingItem,
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(color: HexColor(greyLightColor)),
              )
            ],
          ),
        ));
  }
}
