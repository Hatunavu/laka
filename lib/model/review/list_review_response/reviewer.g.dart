// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviewer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reviewer _$ReviewerFromJson(Map<String, dynamic> json) => Reviewer(
      id: json['_id'] as String?,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      type: json['type'] as String?,
      authentication: json['authentication'] == null
          ? null
          : Authentication.fromJson(
              json['authentication'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ReviewerToJson(Reviewer instance) => <String, dynamic>{
      '_id': instance.id,
      'profile': instance.profile,
      'phone': instance.phone,
      'type': instance.type,
      'authentication': instance.authentication,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
