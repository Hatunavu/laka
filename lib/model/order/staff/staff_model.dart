import 'package:client_tggt/model/user/update_account_information_request.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'staff_model.g.dart';

@JsonSerializable()
class StaffModel {
  @JsonKey(name: '_id')
  final String id;
  final String image;
  final String name;
  final String status;
  final String? description;

  StaffModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.status,
      this.description});

  factory StaffModel.fromJson(Map<String, dynamic> json) =>
      _$StaffModelFromJson(json);

  Map<String, dynamic> toJson() => _$StaffModelToJson(this);
}
