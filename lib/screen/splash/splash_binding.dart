import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/splash/splash_controller.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorMainController>(
        () => VendorMainController(getIt.get<ApiClient>()));
    Get.lazyPut<SplashController>(
        () => SplashController(getIt.get<ApiClient>()));
  }
}
