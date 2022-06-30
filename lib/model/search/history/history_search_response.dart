import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_search_response.g.dart';

@JsonSerializable()
class HistorySearchResponse {
  @JsonKey(name: 'data')
  final HistorySearchData? data;
  final int status;
  final String message;

  HistorySearchResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory HistorySearchResponse.fromJson(Map<String, dynamic> json) =>
      _$HistorySearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistorySearchResponseToJson(this);
}

@JsonSerializable()
class HistorySearchData {
  final List<HistorySearchModel>? searches;
  final List<VendorModel> suggestedVendors;

  HistorySearchData({
    this.searches,
    required this.suggestedVendors,
  });

  factory HistorySearchData.fromJson(Map<String, dynamic> json) =>
      _$HistorySearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$HistorySearchDataToJson(this);
}

@JsonSerializable()
class HistorySearchModel {
  @JsonKey(name: '_id')
  final String id;
  final String account;
  final String t;

  HistorySearchModel({
    required this.id,
    required this.account,
    required this.t,
  });

  factory HistorySearchModel.fromJson(Map<String, dynamic> json) =>
      _$HistorySearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistorySearchModelToJson(this);
}
