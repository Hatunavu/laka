import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/filter_vendors/filter_vendors_controller.dart';
import 'package:get/get.dart';

class FilterVendorsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterVendorsController>(
        () => FilterVendorsController(getIt.get<ApiClient>()));
  }
}
