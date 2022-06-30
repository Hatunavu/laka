import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _box = GetStorage();
  final _key = "isDarkMode";

  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  bool get isDarkMode => _loadThemeFromBox() ? true : false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  _saveThemBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  _changeStatus(bool status) => isDarkMode == status;
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemBox(!_loadThemeFromBox());
    _changeStatus(!isDarkMode);
  }
}
