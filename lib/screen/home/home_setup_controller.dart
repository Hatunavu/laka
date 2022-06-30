import 'package:client_tggt/core/translations/translation_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeSetupController extends GetxController {
  final RxString title = "home".obs;
  final _key = "isDarkMode";
  final _box = GetStorage();
  final language = 'english'.obs;

  var theme = false.obs;
  @override
  void onReady() async {
    if (_box.read(_key) == null) {
      theme.value = false;
    } else {
      theme.value = _box.read(_key);
    }
    super.onReady();
  }

  changeModeThem() {
    theme.value = theme.value ? false : true;
    update();
  }

  changeLanguage(String lang) {
    language.value = lang;
    if (lang == "vietnamese") {
      LocalizationService.changeLocale("vi");
    } else if (lang == "english") {
      LocalizationService.changeLocale("en");
    }
  }
}
