import 'package:client_tggt/model/user/update_account_information_request.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable()
class AccountModel {
  @JsonKey(name: '_id')
  final String? id;
  final Profile? profile;
  final Affiliate? affiliate;
  final String? phone;
  final String? type;
  final int? unreadNotifications;
  final Authentication? authentication;
  final Balance? balance;
  final VendorModel? vendor;
  final int? pendingVendorApplications;
  AccountModel(
      {this.id,
      this.profile,
      this.affiliate,
      this.phone,
      this.type,
      this.authentication,
      this.unreadNotifications,
      this.balance,
      this.vendor,
      this.pendingVendorApplications});

  String? get urlUserAvatar => profile!.avatar!.path ?? '';
  String? get phoneNumber => phone ?? "";
  String? get emailAddress => profile!.email ?? "";

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}

@JsonSerializable()
class Affiliate {
  final String? link;
  final String? key;

  Affiliate({this.link, this.key});

  factory Affiliate.fromJson(Map<String, dynamic> json) =>
      _$AffiliateFromJson(json);
  Map<String, dynamic> toJson() => _$AffiliateToJson(this);
}

@JsonSerializable()
class Balance {
  final double? coin;
  final double? point;

  Balance({this.coin, this.point});

  factory Balance.fromJson(Map<String, dynamic> json) =>
      _$BalanceFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceToJson(this);
}

@JsonSerializable()
class Profile {
  AvatarAccount? avatar;
  final String? fullName;
  @JsonKey(
    name: 'gender',
    fromJson: stringToGenderType,
    toJson: genderTypeToString,
  )
  final GenderType gender;
  final String? biography;
  final DateTime? dateOfBirth;
  final String? email;
  // final String? dateOfBirth;

  Profile(
      {this.avatar,
      required this.gender,
      // this.dateOfBirth,
      this.fullName,
      this.biography,
      this.dateOfBirth,
      this.email});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class AvatarAccount {
  final String? path;
  final String? type;

  AvatarAccount({
    this.path,
    this.type,
  });

  factory AvatarAccount.fromJson(Map<String, dynamic> json) =>
      _$AvatarAccountFromJson(json);
  Map<String, dynamic> toJson() => _$AvatarAccountToJson(this);
}

@JsonSerializable()
class Authentication {
  final bool? lock;
  final bool? isPhoneVerified;
  final bool? status;

  Authentication({
    this.lock,
    this.isPhoneVerified,
    this.status,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
}

// @JsonSerializable()
// class AvatarAccount {
//   @JsonKey(name: '_id')
//   final String? id;
//   final String? path;
//   final String? type;

//   AvatarAccount({
//     this.id,
//     this.path,
//     this.type,
//   });

//   factory AvatarAccount.fromJson(Map<String, dynamic> json) =>
//       _$AvatarAccountFromJson(json);
//   Map<String, dynamic> toJson() => _$AvatarAccountToJson(this);
// }
