import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/model/category/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum CategoryType { karaoke, bar, massage, restaurant }

extension EnumCategory on CategoryType {
  String value() {
    return categoryTypeToString(this);
  }

  CategoryType parse(String value) {
    return stringToCategoryType(value);
  }

  String toJsonString() {
    switch (this) {
      case CategoryType.bar:
        return 'bar'.tr;
      case CategoryType.karaoke:
        return "karaoke".tr;
      case CategoryType.massage:
        return "massage".tr;
      case CategoryType.restaurant:
        return "restaurant".tr;
    }
  }

  String getType() {
    switch (this) {
      case CategoryType.karaoke:
        return "KARAOKE";
      case CategoryType.bar:
        return 'BAR';
      case CategoryType.massage:
        return "MASSAGE";
      case CategoryType.restaurant:
        return "RESTAURANT";
    }
  }

  String display() {
    switch (this) {
      case CategoryType.karaoke:
        return "karaoke".tr;
      case CategoryType.bar:
        return 'bar'.tr;
      case CategoryType.massage:
        return "massage".tr;
      case CategoryType.restaurant:
        return "restaurant".tr;
    }
  }
}

CategoryType stringToCategoryType(String type) {
  switch (type) {
    case 'BAR':
      return CategoryType.bar;
    case 'KARAOKE':
      return CategoryType.karaoke;
    case 'RESTAURANT':
      return CategoryType.restaurant;
    case 'MASSAGE':
      return CategoryType.massage;
    default:
      return CategoryType.massage;
  }
}

String categoryTypeToString(CategoryType type) {
  switch (type) {
    case CategoryType.bar:
      return 'bar'.tr;
    case CategoryType.restaurant:
      return 'restaurant'.tr;
    case CategoryType.massage:
      return 'massage'.tr;
    case CategoryType.karaoke:
      return "karaoke".tr;
  }
}

String categoryTypeToSymbol(CategoryType type) {
  switch (type) {
    case CategoryType.bar:
      return 'người';
    case CategoryType.restaurant:
      return 'người';
    case CategoryType.massage:
      return 'người';
    case CategoryType.karaoke:
      return "giờ";
  }
}

String categoryTypeToVariantCategory(CategoryType type) {
  switch (type) {
    case CategoryType.bar:
      return 'người';
    case CategoryType.restaurant:
      return 'người';
    case CategoryType.massage:
      return 'người';
    case CategoryType.karaoke:
      return "giờ";
  }
}

List<CategoryModel> listCategory = [
  CategoryModel(
      id: "0",
      title: CategoryType.bar.display(),
      iconName: AppPath.barIconGrey,
      type: CategoryType.bar.getType(),
      backgroundColor: const Color(0xFFE64A19)),
  CategoryModel(
      id: "1",
      title: CategoryType.karaoke.display(),
      iconName: AppPath.karaokeIconGrey,
      type: CategoryType.karaoke.getType(),
      backgroundColor: const Color(0xFFff9800)),
  CategoryModel(
      id: "2",
      title: CategoryType.massage.display(),
      iconName: AppPath.massageIconGrey,
      type: CategoryType.massage.getType(),
      backgroundColor: const Color(0xFF673AB7)),
  CategoryModel(
      id: "3",
      title: CategoryType.restaurant.display(),
      iconName: AppPath.restaurantIconGrey,
      type: CategoryType.restaurant.getType(),
      backgroundColor: const Color(0xFF2196F3)),
];
