import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_account_information_request.g.dart';

@JsonSerializable()
class UpdateAccountInformationRequest {
  final String? email;
  final String? fullName;
  // final String? dateOfBirth;
  final String? biography;
  final String? gender;

  UpdateAccountInformationRequest(
      {this.email,
      this.fullName,
      // this.dateOfBirth,
      this.biography,
      this.gender});

  factory UpdateAccountInformationRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateAccountInformationRequestFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$UpdateAccountInformationRequestToJson(this);
}

enum GenderType { male, female, other }

extension EnumGender on GenderType {
  String toJsonString() {
    switch (this) {
      case GenderType.male:
        return 'male';
      case GenderType.female:
        return "female";
      case GenderType.other:
        return "other";
    }
  }

  String getType() {
    switch (this) {
      case GenderType.male:
        return "male";
      case GenderType.female:
        return "female";
      case GenderType.other:
        return "other";
    }
  }

  String display() {
    switch (this) {
      case GenderType.male:
        return "male".tr;
      case GenderType.female:
        return "female".tr;
      case GenderType.other:
        return "other".tr;
    }
  }
}

GenderType stringToGenderType(String type) {
  switch (type) {
    case 'male':
      return GenderType.male;
    case 'female':
      return GenderType.female;
    case 'other':
      return GenderType.other;
    default:
      return GenderType.other;
  }
}

String genderTypeToString(GenderType type) {
  switch (type) {
    case GenderType.male:
      return 'male';
    case GenderType.female:
      return 'female';
    case GenderType.other:
      return 'other';
  }
}
