import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/app.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/variant_model.dart';
import 'package:client_tggt/model/vendor_page/add_services/vendor_add_services_request.dart';
import 'package:client_tggt/screen/home/widget/category_widget.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VendorAddProductController extends GetxController {
  final String title = "vendor_add_product";
  final VendorMainController vendorMainController =
      Get.put(VendorMainController(getIt.get<ApiClient>()));
  VendorAddProductController(this._apiClient);
  final ApiClient _apiClient;
  final isLoading = false.obs;

  RxList<AttributeModel> listAttribute = RxList<AttributeModel>();
  RxList<AttributeModel> listSpecialAttribute = RxList<AttributeModel>();
  final RxList<AttributeModel> listSpecialAttributeSelected =
      RxList<AttributeModel>();

  final RxList<AttributeModel> listTimeAttribute = RxList<AttributeModel>();

  final RxList<AttributeModel> listCustomAttribute = RxList<AttributeModel>();

  var listIdAttributeSelected = <String>[].obs;
  var listIdSpecialAttributeSelected = <String>[].obs;

  var listAttributeSelected = <AttributeModel>[].obs;
  final listVariant = <VariantModel>[].obs;
  final selectedVariant =
      VariantModel(id: "", name: "", category: CategoryType.karaoke).obs;

  final isOpenSpecialAttribute = true.obs;

  final vendorNameController = TextEditingController(text: "").obs;
  final vendorDetailController = TextEditingController(text: "").obs;
  final vendorNoteController = TextEditingController(text: "").obs;
  final vendorPriceController = TextEditingController(text: "").obs;

  final specialNameController = TextEditingController(text: "").obs;
  final specialValueController = TextEditingController(text: "").obs;

  final servicesNote = "".obs;
  final servicesName = "".obs;
  final servicesDetail = "".obs;
  final servicesPrice = "0".obs;
  final specialAttributeName = "".obs;
  final specialAttributeValue = "".obs;
  final listError = <String>[].obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() async {
    Future.wait([handleGetListVarient(), getListAttribute()]);
  }

  Future<void> handleGetListVarient() async {
    final mainController = Get.find<VendorMainController>();
    final category = mainController.account.value.vendor!.category;
    try {
      var response = await _apiClient.getVariantsByCategory(category.getType());
      if (response.status == 200) {
        listVariant.value = response.data;
        if (response.data != []) {
          selectedVariant.value = response.data[0];
        }
      }
    } on Exception catch (err) {
      log("err $err");
    }
  }

  Future<void> getListAttribute() async {
    // final VendorInfoModel account = vendorMainController.account.value;
    // final category = account.vendor!.category;
    try {
      isLoading(true);
      final response = await _apiClient.getListAttributeByCategory();
      if (response.status == 200) {
        final defaultAttributes = response.data!.defaultAttributes;
        final vendorAttributes = response.data!.vendorAttributes;
        final timeAttribute = vendorAttributes
            .where((element) => element.type == "time")
            .toList();
        final customAttribute = vendorAttributes
            .where((element) => element.type != "time")
            .toList();
        listAttribute.value = defaultAttributes;
        listTimeAttribute.value = timeAttribute;
        listCustomAttribute.value = customAttribute;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleOpenSpecialAttribute(bool status) {
    isOpenSpecialAttribute.value = status;
  }

  handleSaveServicesDetail() {
    servicesDetail.value = vendorDetailController.value.text;
  }

  handleSaveServicesName() {
    servicesName.value = vendorNameController.value.text;
  }

  handleSaveServicesNote() {
    servicesNote.value = vendorNoteController.value.text;
  }

  handleSaveServicesPrice() {
    servicesPrice.value = vendorPriceController.value.text;
  }

  handleCheckIdAttribute(AttributeModel attribute) {
    if (listIdAttributeSelected.contains(attribute.id)) {
      listIdAttributeSelected.remove(attribute.id);
      listAttributeSelected.remove(attribute);
    } else {
      listIdAttributeSelected.add(attribute.id!);
      listAttributeSelected.add(attribute);
    }
  }

  handleAddProduct(String type) async {
    final name = vendorNameController.value.text;
    final details = vendorDetailController.value.text;
    final price = vendorPriceController.value.text;
    final note = vendorNoteController.value.text;
    final variantId = selectedVariant.value.id;

    final attributes = [...listAttributeSelected, ...listSpecialAttribute];
    var errors = <String>[];
    if (name == "") {
      errors.add("name");
    }
    if (details == "") {
      errors.add("details");
    }
    if (price == "0" || price == "") {
      errors.add("price");
    }
    if (attributes.isEmpty) {
      errors.add("attribute");
    }
    if (variantId == "") {
      errors.add("variant");
    }
    if (errors.isEmpty) {
      final request = VendorAddServicesRequest(
          name: name,
          details: details,
          variantId: variantId,
          note: note,
          price: int.parse(price),
          attributes: attributes,
          active: true,
          status: type);
      try {
        isLoading(true);
        final response = await _apiClient.postCreateNewServices(request);
        if (response.status == 200) {
          // Get.back();
          Get.find<RouterController>().back();
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        isLoading(false);
      }
    } else {
      listError.value = errors;
    }
  }

  // handleCheckListSpecialAttribute(String id) {
  //   if (listIdSpecialAttributeSelected.contains(id)) {
  //     listIdSpecialAttributeSelected.remove(id);
  //   } else {
  //     listIdSpecialAttributeSelected.add(id);
  //   }
  // }

  handleAddSpecialAttribute() {
    listSpecialAttribute.add(AttributeModel(
        name: specialNameController.value.text,
        description: specialValueController.value.text,
        type: "custom"));
    specialNameController.value.text = "";
    specialValueController.value.text = "";
  }

  handleRemoveSpecialAttribute(AttributeModel specialAttribute) {
    listSpecialAttribute.remove(specialAttribute);
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
