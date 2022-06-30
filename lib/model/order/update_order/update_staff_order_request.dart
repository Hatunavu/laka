import 'package:json_annotation/json_annotation.dart';

part 'update_staff_order_request.g.dart';

@JsonSerializable()
class UpdateStaffOrderRequest {
  final List<String> staffIds;

  UpdateStaffOrderRequest({
    required this.staffIds,
  });

  factory UpdateStaffOrderRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateStaffOrderRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateStaffOrderRequestToJson(this);
}
