import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:client_tggt/model/message/message_item_model.dart';

part 'get_list_message_detail_response.g.dart';

@JsonSerializable()
class GetListMessageDetailResponse {
  @JsonKey(name: 'data')
  final MessagesDetailData data;
  final int status;
  final String? message;

  GetListMessageDetailResponse(
      {required this.data, required this.status, this.message});

  String get getBookingId {
    if (data.roomInfo.ref == null) return "";
    return data.roomInfo.ref!.orderId ?? "";
  }

  BookingStatus get getBookingStatus {
    if (data.roomInfo.ref == null) return BookingStatus.pending;
    return data.roomInfo.ref!.status;
  }

  double get getBookingPrice {
    if (data.roomInfo.ref == null) {
      return 0.0;
    } else {
      return data.roomInfo.ref!.totalPrice ??
          0 + data.roomInfo.ref!.totalStaffPrice;
    }
  }

  // (data.roomInfo.ref.totalPrice ?? 0 + data.roomInfo.ref.totalStaffPrice);
  String get getProductImage {
    if (data.roomInfo.ref == null) {
      return "";
    } else {
      return data.roomInfo.ref!.product!.thumbnail!.path ?? "";
    }
  }

  String get getOrderId {
    if (data.roomInfo.ref == null) return "";
    return data.roomInfo.ref!.id ?? "";
  }

  factory GetListMessageDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListMessageDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListMessageDetailResponseToJson(this);
}

@JsonSerializable()
class MessagesDetailData {
  final MessageeDetailDocs messages;
  final MessageeRoomInfo roomInfo;

  MessagesDetailData({
    required this.messages,
    required this.roomInfo,
  });
  factory MessagesDetailData.fromJson(Map<String, dynamic> json) =>
      _$MessagesDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesDetailDataToJson(this);
}

@JsonSerializable()
class MessageeRoomInfo {
  @JsonKey(name: '_id')
  final String id;
  List<AccountModel> accounts;
  final String? type;
  final BookingItemModel? ref;

  MessageeRoomInfo(
      {required this.id, required this.accounts, this.type, required this.ref});
  factory MessageeRoomInfo.fromJson(Map<String, dynamic> json) =>
      _$MessageeRoomInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageeRoomInfoToJson(this);
}

@JsonSerializable()
class MessageeDetailDocs {
  final List<MessageItemModel> docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  MessageeDetailDocs(
      {required this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});
  factory MessageeDetailDocs.fromJson(Map<String, dynamic> json) =>
      _$MessageeDetailDocsFromJson(json);

  Map<String, dynamic> toJson() => _$MessageeDetailDocsToJson(this);
}
