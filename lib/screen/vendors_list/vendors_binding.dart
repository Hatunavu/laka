import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/vendors_list/vendors_controller.dart';
import 'package:get/get.dart';

class VendorsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorsController>(
        () => VendorsController(getIt.get<ApiClient>()));
  }
}
