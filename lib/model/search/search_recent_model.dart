import 'package:client_tggt/model/category/enum_category.dart';

class SearchRecentModel {
  final CategoryType category;
  final String ventorName;
  final String ventorAddress;

  SearchRecentModel(
      {required this.category,
      required this.ventorName,
      required this.ventorAddress});
}
