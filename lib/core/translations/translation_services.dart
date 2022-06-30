import 'dart:collection';
import 'package:client_tggt/core/translations/en_Us/en_us_translations.dart';
import 'package:client_tggt/core/translations/ja_JP/ja_JP_translations.dart';
import 'package:client_tggt/core/translations/ko_KR/ko_kr_translations.dart';
import 'package:client_tggt/core/translations/vi_VN/vi_vn_translations.dart';
import 'package:client_tggt/core/translations/zh_CN/zh_cn_translations.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LocalizationService extends Translations {
// locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = _getLocaleFromLanguage();

// fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static const fallbackLocale = Locale('en', 'US');

// language code của những locale được support
  static final langCodes = ['en', 'vi', 'ko', 'ja', 'zh'];

// các Locale được support
  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
    const Locale('ko', 'KR'),
    const Locale('ja', 'JP'),
    const Locale('zh', 'CN'),
  ];

// cái này là Map các language được support đi kèm với mã code của lang đó: cái này dùng để đổ data vào Dropdownbutton và set language mà không cần quan tâm tới language của hệ thống
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
    'ko': 'Korean',
    'ja': '日本語',
    'zh': '中文'
  });

// function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
        'ko_KR': ko,
        'ja_JP': ja,
        'zh_CN': zh,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    final languageCode = AccountServices().getLanguageCode();
    if (languageCode == "") {
      var deviceLocate = Get.deviceLocale;
      if (deviceLocate != null) {
        var lang = langCode ?? deviceLocate.languageCode;
        for (int i = 0; i < langCodes.length; i++) {
          if (lang == langCodes[i]) return locales[i];
        }
      }
      return Get.locale ?? const Locale('vi', 'VN');
    } else {
      switch (languageCode) {
        case "vi":
          return const Locale('vi', 'VN');
        case "en":
          return const Locale('en', 'US');
        case "ko":
          return const Locale('ko', 'KR');
        case "ja":
          return const Locale('ja', 'JP');
        case "zh":
          return const Locale('zh', 'CN');
        default:
          return const Locale('vi', 'VN');
      }
    }
  }
}
