import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_filter_vendor_response.g.dart';

@JsonSerializable()
class GetFilterVendorReponse {
  @JsonKey(name: 'data')
  final FilterVendorData data;
  final int status;
  final String? message;
  final dynamic errors;

  GetFilterVendorReponse(
      {required this.data, required this.status, this.message, this.errors});
  factory GetFilterVendorReponse.fromJson(Map<String, dynamic> json) =>
      _$GetFilterVendorReponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetFilterVendorReponseToJson(this);
}

@JsonSerializable()
class FilterVendorData {
  @JsonKey(name: 'docs')
  final List<VendorModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  FilterVendorData(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory FilterVendorData.fromJson(Map<String, dynamic> json) =>
      _$FilterVendorDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterVendorDataToJson(this);
}
