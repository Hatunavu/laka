import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_voucher_response.g.dart';

@JsonSerializable()
class GetListVoucherResponse {
  ListVoucherData? data;
  int? status;
  String? message;
  dynamic errors;

  GetListVoucherResponse({
    this.data,
    this.status,
    this.message,
    this.errors,
  });

  factory GetListVoucherResponse.fromJson(Map<String, dynamic> json) {
    return _$GetListVoucherResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetListVoucherResponseToJson(this);
}

@JsonSerializable()
class ListVoucherData {
  @JsonKey(name: 'docs')
  final List<VoucherModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  ListVoucherData(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory ListVoucherData.fromJson(Map<String, dynamic> json) =>
      _$ListVoucherDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListVoucherDataToJson(this);
}
