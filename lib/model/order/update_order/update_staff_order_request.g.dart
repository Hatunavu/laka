// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_staff_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStaffOrderRequest _$UpdateStaffOrderRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateStaffOrderRequest(
      staffIds:
          (json['staffIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UpdateStaffOrderRequestToJson(
        UpdateStaffOrderRequest instance) =>
    <String, dynamic>{
      'staffIds': instance.staffIds,
    };
