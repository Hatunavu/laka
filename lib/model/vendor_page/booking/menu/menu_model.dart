import 'package:json_annotation/json_annotation.dart';

part 'menu_model.g.dart';

@JsonSerializable()
class MenuModel {
  @JsonKey(name: '_id')
  final String id;
  final String image;
  final String name;
  final double price;
  final String status;
  final String? description;

  MenuModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.status,
      this.description});

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuModelToJson(this);
}

@JsonSerializable()
class SelectedMenuItemModel {
  int amount;
  final MenuModel item;
  int get getTotalPrice => (item.price * amount).toInt();
  SelectedMenuItemModel({required this.amount, required this.item});

  factory SelectedMenuItemModel.fromJson(Map<String, dynamic> json) =>
      _$SelectedMenuItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$SelectedMenuItemModelToJson(this);
}
