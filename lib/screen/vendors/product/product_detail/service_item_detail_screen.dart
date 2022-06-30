import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/gallery/gallery_controller.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/services_item_controller.dart';
import 'package:client_tggt/screen/vendors/product/widget/service_detail_shimmer.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/custome_cupertino_alert.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:client_tggt/shared/widget/dialog/dialog_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceItemDetailScreen extends StatelessWidget {
  const ServiceItemDetailScreen({Key? key, this.serviceItemId})
      : super(key: key);
  final String? serviceItemId;
  @override
  Widget build(BuildContext context) {
    final ServiceItemController serviceItemController =
        Get.put(ServiceItemController(getIt.get<ApiClient>()));
    serviceItemController.getServiceItem(serviceItemId!);
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "Thông tin dịch vụ",
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: const Icon(
              Ionicons.chevron_back_outline,
              size: 23,
              color: Colors.black,
            )),
        child: Obx(() => serviceItemController.isLoading.isTrue
            ? const ServiceDetailShimmer()
            : Container(
                padding: EdgeInsets.only(
                    left: kDefaultPaddingWidget.w,
                    // right: kDefaultPaddingWidget,
                    bottom: kDefaultPaddingWidget.h),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        renderThumbnail(context, serviceItemController),
                        renderLineWidget(context),
                        renderName(context, serviceItemController),
                        renderLineWidget(context),
                        renderDetail(context, serviceItemController),
                        renderLineWidget(context),
                        renderPrice(context, serviceItemController),
                        renderLineWidget(context),
                        renderNote(context, serviceItemController),
                        renderLineWidget(context),
                        renderGallery(context, serviceItemController),
                        renderLineWidget(context),
                        renderAttriute(context, serviceItemController),
                        renderSetting(context, serviceItemController),
                        SizedBox(
                          height: kDefaultPaddingWidget.h * 2,
                        )
                      ],
                    )))));
  }
}

Widget renderLineWidget(BuildContext context) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPaddingItem),
      child: Container(
          padding: EdgeInsets.zero,
          height: 1,
          decoration:
              BoxDecoration(color: HexColor(greyTextColor).withOpacity(.5))));
}

Widget renderGallery(BuildContext context, ServiceItemController controller) {
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                "Ảnh dịch vụ: ".toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  color: HexColor(greyTextColor),
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  context.router
                      .push(ServiceItemGalleryPage(
                          listGallery: controller.listServiceGallery,
                          serviceId: controller.serviceItem.value.id))
                      .then((value) =>
                          Get.delete<ServiceItemGalleryController>());
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPaddingWidget.w,
                      vertical: defaultPaddingItem.h),
                  child: Icon(
                    Ionicons.create_outline,
                    size: 23,
                    color: HexColor(secondaryColorLight),
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: defaultPaddingItem,
        ),
        RichText(
          text: TextSpan(
            text: 'Tất cả ảnh dịch vụ: ',
            style:
                titleStyle.copyWith(fontWeight: FontWeight.w400, height: 1.4),
            children: <TextSpan>[
              TextSpan(
                  text: ' ${controller.listServiceGallery.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    ),
  );
}

Widget renderNote(
    BuildContext context, ServiceItemController serviceItemController) {
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                "Nội Quy: ".toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  color: HexColor(greyTextColor),
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return DialogTextField(
                        context: context,
                        controller: serviceItemController.noteController.value,
                        hint: "Nhập nội quy",
                        title: 'Sửa nội quy',
                        minLines: 1,
                        confirmTitlel: "Cập nhật",
                        onConfirm: () {
                          serviceItemController.handleEditNote();
                        },
                        onDismiss: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.w,
                        vertical: defaultPaddingItem.h),
                    child: Icon(
                      Ionicons.create_outline,
                      size: 23,
                      color: HexColor(secondaryColorLight),
                    )))
          ],
        ),
        // const SizedBox(
        //   height: defaultPaddingItem,
        // ),
        serviceItemController.serviceItem.value.note != null
            ? Container(
                margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
                child: Text(
                  serviceItemController.serviceItem.value.note!,
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.w400, height: 1.4),
                ),
              )
            : Container()
      ],
    ),
  );
}

Widget renderPrice(
    BuildContext context, ServiceItemController serviceItemController) {
  final currencyFormatter = NumberFormat('#,##0  đ', 'ID');
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                "Bảng giá: ".toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  color: HexColor(greyTextColor),
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return DialogTextField(
                        context: context,
                        controller: serviceItemController.priceController.value,
                        hint: "Nhập giá",
                        title: 'Sửa giá',
                        minLines: 1,
                        confirmTitlel: "Cập nhật",
                        inputType: TextInputType.number,
                        onConfirm: () {
                          serviceItemController.handleEditPrice();
                        },
                        onDismiss: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.w,
                        vertical: defaultPaddingItem),
                    child: Icon(
                      Ionicons.create_outline,
                      size: 23,
                      color: HexColor(secondaryColorLight),
                    )))
          ],
        ),
        // const SizedBox(
        //   height: defaultPaddingItem,
        // ),
        Container(
          margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
          child: Text(
            currencyFormatter.format(double.parse(
                '${serviceItemController.serviceItem.value.price}')),
            style:
                titleStyle.copyWith(fontWeight: FontWeight.w400, height: 1.4),
          ),
        )
      ],
    ),
  );
}

Widget renderDetail(
    BuildContext context, ServiceItemController serviceItemController) {
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                "Mô tả: ".toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  color: HexColor(greyTextColor),
                ),
              ),
            ),
            InkWell(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return DialogTextField(
                        context: context,
                        controller:
                            serviceItemController.detailController.value,
                        hint: "Nhập mô tả dịch vụ",
                        title: 'Sửa mô tả dịch vụ',
                        minLines: 1,
                        confirmTitlel: "Cập nhật",
                        onConfirm: () {
                          serviceItemController.handleEditDetail();
                        },
                        onDismiss: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.w,
                        vertical: defaultPaddingItem.h),
                    child: Icon(
                      Ionicons.create_outline,
                      size: 23,
                      color: HexColor(secondaryColorLight),
                    )))
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
          child: Text(
            serviceItemController.serviceItem.value.details ?? '',
            style:
                titleStyle.copyWith(fontWeight: FontWeight.w400, height: 1.4),
          ),
        )
      ],
    ),
  );
}

Widget renderName(
    BuildContext context, ServiceItemController serviceItemController) {
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tên dịch vụ: ".toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: HexColor(greyTextColor),
              ),
            ),
            InkWell(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return DialogTextField(
                        context: context,
                        controller: serviceItemController.nameController.value,
                        hint: "Nhập tên dịch vụ",
                        title: 'Sửa Tên dịch vụ',
                        minLines: 1,
                        confirmTitlel: "Cập nhật",
                        onConfirm: () {
                          serviceItemController.handleEditName();
                        },
                        onDismiss: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.w,
                        vertical: defaultPaddingItem.h),
                    child: Icon(
                      Ionicons.create_outline,
                      size: 23,
                      color: HexColor(secondaryColorLight),
                    )))
          ],
        ),
        // const SizedBox(
        //   height: defaultPaddingItem,
        // ),
        Container(
          margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
          child: Text(
            serviceItemController.serviceItem.value.name ?? '',
            style: titleStyle,
          ),
        )
      ],
    ),
  );
}

Widget renderThumbnail(
    BuildContext context, ServiceItemController serviceItemController) {
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ảnh đại diện: ".toUpperCase(),
              style: TextStyle(
                fontSize: 13,
                color: HexColor(greyTextColor),
              ),
            ),
            InkWell(
              onTap: () {
                showCupertinoModalPopup<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return CupertinoActionSheet(
                        title: const Text('Thao tác'),
                        // message: const Text('Message'),
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            child: const Text('Chụp ảnh'),
                            onPressed: () {
                              serviceItemController
                                  .handleEditThumbnail(ImageSource.camera);
                              context.router.pop();
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('Thư viện hình ảnh'),
                            onPressed: () {
                              serviceItemController
                                  .handleEditThumbnail(ImageSource.gallery);
                              context.router.pop();
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () => context.router.pop(),
                          child: const Text(
                            'Huỷ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPaddingWidget.w,
                    vertical: defaultPaddingItem.h),
                child: Icon(
                  Ionicons.create_outline,
                  size: 23,
                  color: HexColor(secondaryColorLight),
                ),
              ),
            )
          ],
        ),
        Container(
          width: double.infinity,
          height: 200.h,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadius.r),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(serviceItemController
                          .serviceThumbnail.value.path ??
                      "https://www.bartender.edu.vn/wp-content/uploads/2017/09/khong-gian-cua-club.jpg"),
                  fit: BoxFit.cover)),
        ),
      ],
    ),
  );
}

Widget renderAttriute(
    BuildContext context, ServiceItemController serviceItemController) {
  return Column(children: [
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
                    context.router.push(AttributeListPage(type: "general"));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.w,
                        vertical: defaultPaddingItem.h),
                    child: Icon(
                      Ionicons.create_outline,
                      size: 23,
                      color: HexColor(secondaryColorLight),
                    ),
                  ))
            ],
          ),

          Container(
              margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
              child: serviceItemController.listGeneralAtrribute.isNotEmpty
                  ? renderListAttribute(
                      context, serviceItemController.listGeneralAtrribute)
                  : renderEmtyAttribute(context, "Chưa có tiện ích chung")),
          // Visibility(
          //     visible: serviceItemController.listGeneralAtrribute.isNotEmpty,
          //     child: Obx(() => renderListAttribute(
          //         context, serviceItemController.listGeneralAtrribute)))

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
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPaddingWidget.w,
                      vertical: defaultPaddingItem.h),
                  child: Icon(
                    Ionicons.create_outline,
                    size: 23,
                    color: HexColor(secondaryColorLight),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: defaultPaddingItem,
          ),
          Container(
              child: serviceItemController.listTimeAtrribute.isNotEmpty
                  ? renderListAttribute(
                      context, serviceItemController.listTimeAtrribute)
                  : renderEmtyAttribute(context, "Chưa có tiện ích thời gian")),
          // serviceItemController.listTimeAtrribute.isNotEmpty
          //     ? renderListAttribute(
          //         context, serviceItemController.listTimeAtrribute)
          //     : renderEmtyAttribute(context, "Chưa có tiện ích chung"),
          // Visibility(
          //     visible: serviceItemController.listTimeAtrribute.isNotEmpty,
          //     child: Obx(() => renderListAttribute(
          //         context, serviceItemController.listTimeAtrribute)))

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
                  context.router.push(AttributeListPage(type: "custom"));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPaddingWidget.w,
                      vertical: defaultPaddingItem.h),
                  child: Icon(
                    Ionicons.create_outline,
                    size: 23,
                    color: HexColor(secondaryColorLight),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: defaultPaddingItem.h,
          ),

          Container(
              child: serviceItemController.listCustomAtrribute.isNotEmpty
                  ? renderListAttribute(
                      context, serviceItemController.listCustomAtrribute)
                  : renderEmtyAttribute(context, "Chưa có tiện của bạn")),
          // Visibility(
          //     visible: serviceItemController.listCustomAtrribute.isNotEmpty,
          //     child: Obx(() => renderListAttribute(
          //         context, serviceItemController.listCustomAtrribute)))
        ],
      ),
    ),
    renderLineWidget(context),
  ]);
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
                          ))
                    ],
                  ),
                ]),
          );
        }),
  ]);
}

Widget renderSetting(
    BuildContext context, ServiceItemController serviceItemController) {
  return Column(children: [
    Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Trạng thái: ".toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  color: HexColor(greyTextColor),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                child: DropdownButton<String>(
                  underline: const SizedBox(),
                  value: "Hoạt động",
                  style: const TextStyle(color: Colors.green),
                  items: <String>[
                    'Hoạt động',
                    'Lưu nháp',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    renderLineWidget(context),
    const SizedBox(
      height: defaultPaddingItem,
    ),
    Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPaddingItem.w, vertical: kDefaultPaddingWidget.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          border: Border.all(
              width: 1,
              color: serviceItemController.serviceItem.value.status == "hidden"
                  ? Colors.green
                  : HexColor(secondaryColorLight))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible:
                  serviceItemController.serviceItem.value.status != "hidden",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ẩn dịch vụ",
                    style: titleStyle,
                  ),
                  const SizedBox(
                    height: defaultPaddingItem,
                  ),
                  Text(
                      "Khi ẩn dịch vụ, bạn sẽ không thể xem và quản lý dịch vụ này nữa.!",
                      style: subTitleStyle),
                  SizedBox(
                    height: kDefaultPaddingWidget.h * 2,
                  ),
                  InkWellButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext dialogContext) {
                          return CustomCupertinoAlert(
                            context: context,
                            title: 'Thông báo',
                            content: 'Bạn muốn ẩn dịch vụ này?',
                            rightButtonTitle: 'Xác nhận',
                            rightAction: () {
                              serviceItemController.handleEditStatus("hidden");
                            },
                          );
                        },
                      );
                    },
                    label: "Ẩn dịch vụ",
                    backgroundColor: Colors.white,
                    borderColor: HexColor(secondaryColorLight),
                    textColor: HexColor(secondaryColorLight),
                  )
                ],
              )),
          Visibility(
              visible:
                  serviceItemController.serviceItem.value.status == "hidden",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mở dịch vụ",
                    style: titleStyle,
                  ),
                  const SizedBox(
                    height: defaultPaddingItem,
                  ),
                  Text(
                      "Khi mở dịch vụ, khách hàng có thể đặt lịch dịch vụ này.!",
                      style: subTitleStyle),
                  const SizedBox(
                    height: kDefaultPaddingWidget * 2,
                  ),
                  InkWellButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext dialogContext) {
                          return CustomCupertinoAlert(
                            context: context,
                            title: 'Thông báo',
                            content: 'Bạn muốn mở dịch vụ này?',
                            rightButtonTitle: 'Xác nhận',
                            rightAction: () {
                              serviceItemController
                                  .handleEditStatus("published");
                            },
                          );
                        },
                      );
                    },
                    label: "Mở dịch vụ",
                    backgroundColor: Colors.white,
                    borderColor: Colors.green[400],
                    textColor: Colors.green[400],
                  )
                ],
              ))
        ],
      ),
    )
  ]);
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
