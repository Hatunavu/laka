import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_location_response.g.dart';

@JsonSerializable()
class SearchLocationResponse {
  @JsonKey(name: 'data')
  final ListVendor? data;
  final int status;
  final String message;

  SearchLocationResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory SearchLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchLocationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchLocationResponseToJson(this);
}

@JsonSerializable()
class ListVendor {
  @JsonKey(name: 'docs')
  final List<VendorModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  ListVendor(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory ListVendor.fromJson(Map<String, dynamic> json) =>
      _$ListVendorFromJson(json);

  Map<String, dynamic> toJson() => _$ListVendorToJson(this);
}
