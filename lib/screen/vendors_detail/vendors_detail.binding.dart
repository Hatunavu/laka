import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/vendors_detail/vendors_detail.controller.dart';
import 'package:get/get.dart';

class VendorsDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorsDetailController>(
        () => VendorsDetailController(getIt.get<ApiClient>()));
  }
}
