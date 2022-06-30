import 'package:client_tggt/model/notification/notification_model.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_get_list_staff_response.g.dart';

@JsonSerializable()
class CustomerGetListStaffResponse {
  @JsonKey(name: 'data')
  final ListStaffData data;
  final int status;
  final String? message;
  final dynamic errors;

  CustomerGetListStaffResponse(
      {required this.data, required this.status, this.message, this.errors});
  factory CustomerGetListStaffResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerGetListStaffResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerGetListStaffResponseToJson(this);
}

@JsonSerializable()
class ListStaffData {
  @JsonKey(name: 'docs')
  final List<StaffModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  ListStaffData(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory ListStaffData.fromJson(Map<String, dynamic> json) =>
      _$ListStaffDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListStaffDataToJson(this);
}
