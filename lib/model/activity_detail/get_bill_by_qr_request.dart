import 'package:json_annotation/json_annotation.dart';

part 'get_bill_by_qr_request.g.dart';

@JsonSerializable()
class GetBillByQrRequest {
  final String orderId;

  GetBillByQrRequest({
    required this.orderId,
  });

  factory GetBillByQrRequest.fromJson(Map<String, dynamic> json) {
    return _$GetBillByQrRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetBillByQrRequestToJson(this);
}
