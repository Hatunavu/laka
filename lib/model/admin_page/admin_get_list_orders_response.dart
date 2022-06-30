import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'admin_get_list_orders_response.g.dart';

@JsonSerializable()
class AdminGetListOrdersReponse {
  @JsonKey(name: 'data')
  final GetListOrdersData data;
  final int status;
  final String? message;

  AdminGetListOrdersReponse({
    required this.data,
    required this.status,
    this.message,
  });
  factory AdminGetListOrdersReponse.fromJson(Map<String, dynamic> json) =>
      _$AdminGetListOrdersReponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminGetListOrdersReponseToJson(this);
}

@JsonSerializable()
class GetListOrdersData {
  final List<BookingItemModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  GetListOrdersData(
      {required this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});
  factory GetListOrdersData.fromJson(Map<String, dynamic> json) =>
      _$GetListOrdersDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetListOrdersDataToJson(this);
}
