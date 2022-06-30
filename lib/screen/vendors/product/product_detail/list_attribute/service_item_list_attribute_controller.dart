import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/services_item_controller.dart';
import 'package:get/get.dart';

class ServiceItemListAttributeController extends GetxController {
  final String title = "vendor_booking";
  final isLoading = false.obs;
  final selectedIndex = 0.obs;
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;
  final ApiClient _apiClient;
  final attributeType = "".obs;

  ServiceItemListAttributeController(this._apiClient);

  final RxList<AttributeModel> listGeneralAtrribute = RxList<AttributeModel>();
  final RxList<AttributeModel> listCustomAtrribute = RxList<AttributeModel>();
  final RxList<AttributeModel> listTimeAtrribute = RxList<AttributeModel>();

  final RxList<AttributeModel> listAttributeSelected = RxList<AttributeModel>();
  final ServiceItemController serviceItemController =
      Get.put(ServiceItemController(getIt.get<ApiClient>()));

  handleGetListAttribute(String type) {
    attributeType.value = type;
    getListAttribute();
  }

  getListAttribute() async {
    // final VendorMainController mainController =
    //     Get.put(VendorMainController(_apiClient));

    final attributeOfProduct =
        serviceItemController.serviceItem.value.attributes;
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
            .where((element) => element.type == "custom")
            .toList();
        listCustomAtrribute.value = customAttribute;
        listGeneralAtrribute.value = defaultAttributes;
        listTimeAtrribute.value = timeAttribute;
        final listAttribute = [...defaultAttributes, ...vendorAttributes];

        listAttributeSelected.value = listAttribute
            .where((element) => attributeOfProduct!
                .any((element2) => element2.id == element.id))
            .toList();
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleUpdateAttribute() {
    // ignore: invalid_use_of_protected_member
    serviceItemController.handleEditAttribute(listAttributeSelected.value);
  }

  handleCheckAttribute(AttributeModel attribute) {
    if (listAttributeSelected.contains(attribute)) {
      listAttributeSelected.remove(attribute);
    } else {
      listAttributeSelected.add(attribute);
    }
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
