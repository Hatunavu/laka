import 'package:client_tggt/screen/profile/language/language_controller.dart';
import 'package:get/get.dart';

class LanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
  }
}
