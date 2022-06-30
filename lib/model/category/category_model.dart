import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String title;
  final String iconName;
  final Color? backgroundColor;
  final String type;
  final bool? isEnalble;

  CategoryModel(
      {required this.id,
      required this.title,
      required this.iconName,
      this.backgroundColor,
      required this.type,
      this.isEnalble = true});
}
