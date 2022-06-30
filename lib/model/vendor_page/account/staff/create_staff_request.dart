import 'package:json_annotation/json_annotation.dart';

part 'create_staff_request.g.dart';

@JsonSerializable()
class CreateStaffRequest {
  final String name;
  final String? description;
  final String image;

  CreateStaffRequest(
      {required this.name, this.description, required this.image});

  factory CreateStaffRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateStaffRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateStaffRequestToJson(this);
}
