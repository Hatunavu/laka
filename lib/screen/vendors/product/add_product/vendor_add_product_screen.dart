import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/variant_model.dart';
import 'package:client_tggt/screen/vendors/product/add_product/vendor_add_product_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:client_tggt/shared/widget/dialog/dialog_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class VendorAddProductScreen extends StatelessWidget {
  const VendorAddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorAddProductController controller =
        Get.put(VendorAddProductController(getIt.get<ApiClient>()));

    return BaseScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      title: "addService".tr,
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Ionicons.chevron_back_outline,
            size: 23,
            color: Colors.black,
          )),
      child: Obx(() => controller.isLoading.isTrue
          ? const LoadingScreen()
          : Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(
                left: kDefaultPaddingScreen.w,
                right: kDefaultPaddingScreen.w,
              ),
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
                  // margin: EdgeInsets.only(bottom: 32.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                        children: [
                          SizedBox(
                            height: kDefaultPaddingWidget.h,
                          ),
                          renderStep1(context),
                        ],
                      ))),
                      SizedBox(
                        height: kDefaultPaddingWidget.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWellButton(
                                label: "saveDraft".tr,
                                backgroundColor: HexColor(greyTextColor),
                                textColor: Colors.white,
                                maxWidth:
                                    (MediaQuery.of(context).size.width - 50.w) /
                                        2,
                                onPressed: () {
                                  controller.handleAddProduct("draft");
                                }),
                          ),
                          SizedBox(
                            width: kDefaultPaddingWidget.w,
                          ),
                          Expanded(
                            child: InkWellButton(
                                label: "confirm".tr,
                                maxWidth:
                                    (MediaQuery.of(context).size.width - 50.w) /
                                        2,
                                onPressed: () {
                                  controller.handleAddProduct("published");
                                }),
                          )
                        ],
                      )
                    ],
                  )),
            )),
    );
  }
}

Widget renderStep1(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      children: [
        renderSelectVariant(context, controller),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        renderAddTitleService(context),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        renderAddDescription(context),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        renderAddPrice(context),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        renderAddNote(context),
        // const SizedBox(
        //   height: kDefaultPaddingWidget,
        // ),
        // renderAddCustomer(context),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        renderAttribute(context),
        Visibility(
          visible: controller.listTimeAttribute.isNotEmpty,
          child: SizedBox(
            height: kDefaultPaddingWidget.h * 1.5,
          ),
        ),
        Visibility(
            visible: controller.listTimeAttribute.isNotEmpty,
            child: renderTimeattribute(context)),

        Visibility(
            visible: controller.listCustomAttribute.isNotEmpty,
            child: SizedBox(
              height: kDefaultPaddingWidget.h * 1.5,
            )),
        Visibility(
            visible: controller.listCustomAttribute.isNotEmpty,
            child: renderCustomAttribute(context)),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        Visibility(
            visible: controller.listSpecialAttribute.isNotEmpty,
            child: renderSpecialAttribute(context)),
        Container(
            alignment: Alignment.centerLeft,
            child: InkWell(
                onTap: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return dialogListSpecialAttribute(context);
                    },
                  );
                },
                child: Text("addYourGadget".tr,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: HexColor(secondaryColorLight)))))
      ],
    ),
  );
}

Widget renderSelectVariant(
    BuildContext context, VendorAddProductController controller) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    renderErrorMessage(context, "roomLevel".tr, "roomLevelIsObligatory".tr,
        controller.listError.contains("variant")),
    const SizedBox(
      height: kDefaultPaddingItem,
    ),
    controller.selectedVariant.value.id == ""
        ? Container()
        : DropdownButton<VariantModel>(
            value: controller.selectedVariant.value,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            isExpanded: true,
            underline: Container(
              height: 1,
              color: Colors.grey,
            ),
            onChanged: (VariantModel? item) {
              controller.selectedVariant.value = item ??
                  VariantModel(
                      id: "", name: "", category: CategoryType.karaoke);
            },
            items: controller.listVariant
                .map<DropdownMenuItem<VariantModel>>((VariantModel value) {
              return DropdownMenuItem<VariantModel>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
          )
  ]);
}

Widget renderAddTitleService(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      renderErrorMessage(context, "serviceName".tr + ": ",
          "serviceNameIsObligatory".tr, controller.listError.contains("name")),
      const SizedBox(
        height: kDefaultPaddingItem,
      ),
      InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return DialogTextField(
                  context: context,
                  controller: controller.vendorNameController.value,
                  title: 'serviceName'.tr,
                  hint: "addNameForService".tr,
                  onConfirm: () {
                    controller.handleSaveServicesName();
                    Navigator.pop(context);
                  },
                  onDismiss: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          child: Container(
            constraints: BoxConstraints(minHeight: 100.h),
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 10.h, bottom: 16.h),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: controller.listError.contains("name")
                        ? Colors.red
                        : Colors.grey,
                    width: 1.0)),
            child: Stack(
              children: [
                Visibility(
                  visible: controller.servicesName.value == "",
                  child: Text(
                    "serviceClass".tr,
                    style: subTitleStyle,
                  ),
                ),
                Visibility(
                    visible: controller.servicesName.value != "",
                    child: Text(
                      controller.servicesName.value,
                      style: const TextStyle(fontSize: 13),
                    )),
              ],
            ),
          )),
    ],
  );
}

Widget renderAddDescription(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      renderErrorMessage(context, "productInfo".tr, "Mô tả dịch vụ là bắt buộc",
          controller.listError.contains("details")),
      const SizedBox(
        height: kDefaultPaddingItem,
      ),
      InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return DialogTextField(
                  context: context,
                  controller: controller.vendorDetailController.value,
                  inputType: TextInputType.multiline,
                  hint: "Thêm mô tả cho gói dịch vụ",
                  title: 'Thêm mô tả',
                  onConfirm: () {
                    controller.handleSaveServicesDetail();
                    Navigator.pop(context);
                  },
                  onDismiss: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          child: Container(
            constraints: BoxConstraints(minHeight: 100.h),
            padding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 10.h, bottom: 16.h),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: controller.listError.contains("details")
                        ? Colors.red
                        : Colors.grey,
                    width: 1.0)),
            child: Stack(
              children: [
                Visibility(
                  visible: controller.servicesDetail.value == "",
                  child: Text(
                    "Thêm mô tả để khách hàng biết những điểm nổi bật mà chỉ gói dịch vụ này có",
                    style: subTitleStyle,
                  ),
                ),
                Visibility(
                    visible: controller.servicesDetail.value != "",
                    child: Text(
                      controller.servicesDetail.value,
                      style: const TextStyle(fontSize: 13),
                    )),
              ],
            ),
          )),
    ],
  );
}

Widget renderAddNote(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Chú thích: ",
        style: titleStyle,
      ),
      const SizedBox(
        height: kDefaultPaddingItem,
      ),
      InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return DialogTextField(
                  context: context,
                  controller: controller.vendorNoteController.value,
                  hint: "Thêm chú thích",
                  title: 'Thêm chú thích',
                  onConfirm: () {
                    controller.handleSaveServicesNote();
                    Navigator.pop(context);
                  },
                  onDismiss: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          child: Container(
              constraints: BoxConstraints(minHeight: 100.h),
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 10.h, bottom: 16.h),
              // height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1.0)),
              child: Stack(
                children: [
                  Visibility(
                    visible: controller.servicesNote.value == "",
                    child: Text(
                      "Một vài lưu ý khi khách hàng sử dụng dịch vụ ( nếu có )",
                      style: subTitleStyle,
                    ),
                  ),
                  Visibility(
                      visible: controller.servicesNote.value != "",
                      child: Text(
                        controller.servicesNote.value,
                        style: const TextStyle(fontSize: 13),
                      )),
                ],
              ))),
    ],
  );
}

Widget renderAddCustomer(BuildContext context) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      "Số khách: ",
      style: titleStyle,
    ),
    const SizedBox(
      height: 6,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Lượng khách tiêu chuẩn: ", style: TextStyle(fontSize: 13)),
        Container(
          alignment: Alignment.center,
          height: 32.w,
          width: 50.w,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey, width: 1)),
          child: TextFormField(
              cursorColor: const Color(0xFF9b9b9b),
              autofocus: false,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor, width: 1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor, width: 1)))),
        ),
      ],
    ),
    SizedBox(
      height: kDefaultPaddingWidget.h,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Lượng khách tối đa: ", style: TextStyle(fontSize: 13)),
        Container(
          alignment: Alignment.center,
          height: 32.w,
          width: 50.w,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey, width: 1)),
          child: TextFormField(
              cursorColor: const Color(0xFF9b9b9b),
              autofocus: false,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor, width: 1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor, width: 1)))),
        ),
      ],
    ),
  ]);
}

Widget renderTimeattribute(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Thời gian: ",
        style: titleStyle,
      ),
      const SizedBox(
        height: 6,
      ),
      Container(
          // height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.zero,
          child: controller.listTimeAttribute.isNotEmpty
              ? renderListAttribute(
                  context, controller.listTimeAttribute, controller)
              : renderEmtyAttribute(context, "Chưa có tiện ích thời gian")),
    ],
  );
}

Widget renderCustomAttribute(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Tiện ích của bạn: ",
        style: titleStyle,
      ),
      const SizedBox(
        height: 6,
      ),
      Container(
          // height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.zero,
          child: renderListAttribute(
              context, controller.listCustomAttribute, controller)),
    ],
  );
}

Widget renderAttribute(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Tiện ích chung: ",
            style: titleStyle,
          ),
          Visibility(
              visible: controller.listError.contains("attribute"),
              child: const Text("Chưa có tiện ích",
                  style: TextStyle(fontSize: 13, color: Colors.red)))
        ],
      ),
      const SizedBox(
        height: 6,
      ),
      Container(
          // height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.zero,
          child: controller.listAttribute.isNotEmpty
              ? renderListAttribute(
                  context, controller.listAttribute, controller)
              : renderEmtyAttribute(context, "Chưa có tiện ích chung")),
    ],
  );
}

Widget renderSpecialAttribute(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Tiện ích mới: ",
        style: titleStyle,
      ),
      const SizedBox(
        height: 6,
      ),
      Column(children: [
        Container(
            padding: EdgeInsets.zero,
            child: renderListSpecialAttribute(
                context, controller.listSpecialAttribute, controller)),
        const SizedBox(
          height: defaultPaddingItem,
        ),
      ]),
      const SizedBox(
        height: defaultPaddingItem,
      ),
    ],
  );
}

Widget dialogListSpecialAttribute(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  return Dialog(
    backgroundColor: Colors.transparent,
    insetPadding: const EdgeInsets.all(kDefaultPaddingScreen),
    child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: kDefaultPaddingScreen.w,
                    right: kDefaultPaddingScreen.w,
                    bottom: 16.h,
                    top: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Ionicons.close_circle_sharp,
                            color: HexColor(secondaryColorLight),
                            size: 30,
                          )),
                    ),
                    SizedBox(
                      height: kDefaultPaddingWidget.h,
                    ),
                    Text(
                      "Tiện ích đặc biệt",
                      style: titleStyle,
                    ),
                    SizedBox(
                      height: kDefaultPaddingWidget.h,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: TextFormField(
                            cursorColor: const Color(0xFF9b9b9b),
                            autofocus: false,
                            maxLines: 1,
                            controller: controller.specialNameController.value,
                            // controller: controller,
                            decoration: InputDecoration(
                                hintText: "Tên tiện ích",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: context.theme.backgroundColor,
                                        width: 0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: context.theme.backgroundColor,
                                        width: 0))))),
                    const SizedBox(
                      height: kDefaultPaddingItem,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: TextFormField(
                            cursorColor: const Color(0xFF9b9b9b),
                            autofocus: false,
                            maxLines: 3,
                            controller: controller.specialValueController.value,
                            decoration: InputDecoration(
                                hintText: "Nội dung ( nếu có )",
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: context.theme.backgroundColor,
                                        width: 0)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: context.theme.backgroundColor,
                                        width: 0))))),
                    SizedBox(
                      height: kDefaultPaddingWidget.h,
                    ),
                    InkWellButton(
                        onPressed: () {
                          controller.handleAddSpecialAttribute();
                          Navigator.of(context).pop();
                        },
                        label: "Xác nhận",
                        borderWidth: 1,
                        borderColor: HexColor(secondaryColorLight),
                        backgroundColor: Colors.transparent,
                        textColor: HexColor(secondaryColorLight))
                  ],
                ))
          ],
        )),
  );
}

Widget renderListAttribute(BuildContext context,
    List<AttributeModel> listAttribute, VendorAddProductController controller) {
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
                                              .image !=
                                          null
                                      ? listAttribute[index].image!
                                      : "https://www.opanvietnam.com/wp-content/uploads/2021/04/thi-cong-phong-karaoke-6.jpg"),
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
                  InkWell(
                      onTap: () {
                        controller.handleCheckIdAttribute(listAttribute[index]);
                      },
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: controller.listIdAttributeSelected
                                        .contains(listAttribute[index].id)
                                    ? HexColor(secondaryColorLight)
                                    : HexColor("#949AA9"))),
                        child: Stack(
                          children: [
                            Visibility(
                                visible: controller.listIdAttributeSelected
                                    .contains(listAttribute[index].id),
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
        visible: controller.listIdAttributeSelected.isEmpty,
        child: Container(
            padding: EdgeInsets.zero,
            height: 0,
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                itemCount: controller.listIdAttributeSelected.length,
                itemBuilder: (context, int index) {
                  return Text(controller.listIdAttributeSelected[index]);
                })))
  ]);
}

Widget renderListSpecialAttribute(BuildContext context,
    List<AttributeModel> listAttribute, VendorAddProductController controller) {
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.handleRemoveSpecialAttribute(
                              listAttribute[index]);
                        },
                        child: const Icon(
                          Icons.delete,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                ]),
          );
        }),
  ]);
}

Widget renderAddPrice(BuildContext context) {
  final VendorAddProductController controller =
      Get.put(VendorAddProductController(getIt.get<ApiClient>()));
  final currencyFormatter = NumberFormat('#,##0  đ', 'ID');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      renderErrorMessage(context, "Giá dịch vụ: ", "Giá dịch vụ là bắt buộc",
          controller.listError.contains("price")),
      const SizedBox(
        height: kDefaultPaddingItem,
      ),
      InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext dialogContext) {
                return DialogTextField(
                  context: context,
                  controller: controller.vendorPriceController.value,
                  hint: "Thêm giá",
                  title: 'Thêm giá',
                  minLines: 1,
                  inputType: TextInputType.number,
                  onConfirm: () {
                    controller.handleSaveServicesPrice();
                    Navigator.pop(context);
                  },
                  onDismiss: () {
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
          child: Container(
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
              // height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: controller.listError.contains("price")
                          ? Colors.red
                          : Colors.grey,
                      width: 1.0)),
              child: Stack(
                children: [
                  Visibility(
                    visible: controller.servicesPrice.value == "0",
                    child: Text(
                      "0",
                      style: subTitleStyle,
                    ),
                  ),
                  Visibility(
                      visible: controller.servicesPrice.value != "0",
                      child: Text(
                        currencyFormatter.format(
                            double.parse(controller.servicesPrice.value)),
                        style: const TextStyle(fontSize: 15),
                      )),
                ],
              ))),
    ],
  );
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

Widget renderErrorMessage(
    BuildContext context, String name, String errorMessage, bool visible) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: titleStyle,
        ),
        Visibility(
            visible: visible,
            child: Text(errorMessage,
                style: TextStyle(fontSize: 13.sp, color: Colors.red)))
      ]);
}
