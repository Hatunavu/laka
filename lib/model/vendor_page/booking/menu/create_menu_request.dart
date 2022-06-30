import 'package:json_annotation/json_annotation.dart';

part 'create_menu_request.g.dart';

@JsonSerializable()
class CreateMenuRequest {
  final String name;
  final double price;
  final String image;
  final String? description;

  CreateMenuRequest(
      {required this.name,
      required this.price,
      required this.image,
      this.description});

  factory CreateMenuRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateMenuRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateMenuRequestToJson(this);
}
