// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountModel _$AccountModelFromJson(Map<String, dynamic> json) => AccountModel(
      id: json['_id'] as String?,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      affiliate: json['affiliate'] == null
          ? null
          : Affiliate.fromJson(json['affiliate'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      type: json['type'] as String?,
      authentication: json['authentication'] == null
          ? null
          : Authentication.fromJson(
              json['authentication'] as Map<String, dynamic>),
      unreadNotifications: json['unreadNotifications'] as int?,
      balance: json['balance'] == null
          ? null
          : Balance.fromJson(json['balance'] as Map<String, dynamic>),
      vendor: json['vendor'] == null
          ? null
          : VendorModel.fromJson(json['vendor'] as Map<String, dynamic>),
      pendingVendorApplications: json['pendingVendorApplications'] as int?,
    );

Map<String, dynamic> _$AccountModelToJson(AccountModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'profile': instance.profile,
      'affiliate': instance.affiliate,
      'phone': instance.phone,
      'type': instance.type,
      'unreadNotifications': instance.unreadNotifications,
      'authentication': instance.authentication,
      'balance': instance.balance,
      'vendor': instance.vendor,
      'pendingVendorApplications': instance.pendingVendorApplications,
    };

Affiliate _$AffiliateFromJson(Map<String, dynamic> json) => Affiliate(
      link: json['link'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$AffiliateToJson(Affiliate instance) => <String, dynamic>{
      'link': instance.link,
      'key': instance.key,
    };

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
      coin: (json['coin'] as num?)?.toDouble(),
      point: (json['point'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BalanceToJson(Balance instance) => <String, dynamic>{
      'coin': instance.coin,
      'point': instance.point,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      avatar: json['avatar'] == null
          ? null
          : AvatarAccount.fromJson(json['avatar'] as Map<String, dynamic>),
      gender: stringToGenderType(json['gender'] as String),
      fullName: json['fullName'] as String?,
      biography: json['biography'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'avatar': instance.avatar,
      'fullName': instance.fullName,
      'gender': genderTypeToString(instance.gender),
      'biography': instance.biography,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'email': instance.email,
    };

AvatarAccount _$AvatarAccountFromJson(Map<String, dynamic> json) =>
    AvatarAccount(
      path: json['path'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$AvatarAccountToJson(AvatarAccount instance) =>
    <String, dynamic>{
      'path': instance.path,
      'type': instance.type,
    };

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      lock: json['lock'] as bool?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
      status: json['status'] as bool?,
    );

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'isPhoneVerified': instance.isPhoneVerified,
      'status': instance.status,
    };
