import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_menu_response.g.dart';

@JsonSerializable()
class VendorGetListMenuResponse {
  @JsonKey(name: 'data')
  final ListMenudata data;
  final int status;
  final String? message;
  final dynamic errors;

  VendorGetListMenuResponse(
      {required this.data, required this.status, this.message, this.errors});
  factory VendorGetListMenuResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorGetListMenuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorGetListMenuResponseToJson(this);
}

@JsonSerializable()
class ListMenudata {
  @JsonKey(name: 'docs')
  final List<MenuModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  ListMenudata(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory ListMenudata.fromJson(Map<String, dynamic> json) =>
      _$ListMenudataFromJson(json);

  Map<String, dynamic> toJson() => _$ListMenudataToJson(this);
}
