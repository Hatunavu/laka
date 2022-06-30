import 'package:client_tggt/model/notification/notification_model.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendor_get_list_staff_response.g.dart';

@JsonSerializable()
class VendorsGetListStaffResponse {
  @JsonKey(name: 'data')
  final ListStaffData data;
  final int status;
  final String? message;
  final dynamic errors;

  VendorsGetListStaffResponse(
      {required this.data, required this.status, this.message, this.errors});
  factory VendorsGetListStaffResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorsGetListStaffResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorsGetListStaffResponseToJson(this);
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
