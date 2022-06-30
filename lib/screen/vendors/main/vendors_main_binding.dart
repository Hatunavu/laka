import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/vendors/booking/vendor_booking_controller.dart';
import 'package:client_tggt/screen/vendors/home/vendor_home_controller.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:client_tggt/screen/vendors/message/message/vendor_message_controller.dart';
import 'package:client_tggt/screen/vendors/product/add_product/vendor_add_product_controller.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/list_attribute/service_item_list_attribute_controller.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/services_item_controller.dart';
import 'package:client_tggt/screen/vendors/product/vendor_product_controller.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_profile_controller.dart';
import 'package:client_tggt/screen/vendors/qrcode/qrcode_controller.dart';
import 'package:get/get.dart';

class VendorsMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorMainController>(
        () => VendorMainController(getIt.get<ApiClient>()));
    Get.lazyPut<VendorsHomeController>(
        () => VendorsHomeController(getIt.get<ApiClient>()));
    Get.lazyPut<VendorBookingController>(
        () => VendorBookingController(getIt.get<ApiClient>()));
    Get.lazyPut<VendorProductController>(
        () => VendorProductController(getIt.get<ApiClient>()));
    Get.lazyPut<VendorMessageController>(
        () => VendorMessageController(getIt.get<ApiClient>()));
    Get.lazyPut<VendorProfileController>(
        () => VendorProfileController(getIt.get<ApiClient>()));
    Get.lazyPut<VendorAddProductController>(
        () => VendorAddProductController(getIt.get<ApiClient>()));
    Get.lazyPut<ServiceItemController>(
        () => ServiceItemController(getIt.get<ApiClient>()));
    Get.lazyPut<ServiceItemListAttributeController>(
        () => ServiceItemListAttributeController(getIt.get<ApiClient>()));
    Get.lazyPut<QrCodeController>(() => QrCodeController());
  }
}
