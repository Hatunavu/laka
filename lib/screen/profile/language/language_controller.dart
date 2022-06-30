import 'package:client_tggt/core/translations/translation_services.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  final String title = "language";
  final languageCode = AccountServices().getLanguageCode().obs;

  handleUpdateLanguageCode(String code) {
    languageCode.value = code;
    AccountServices().saveLanguageCode(code);
    LocalizationService.changeLocale(code);
  }
}
