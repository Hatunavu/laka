import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var themeType = ThemeTypeEnum.colorful.obs;

  @override
  void onInit() {
    if (ThemeServices().isDarkMode) {
      themeType.value = ThemeTypeEnum.luxury;
    } else {
      themeType.value = ThemeTypeEnum.colorful;
    }
    super.onInit();
  }
}
