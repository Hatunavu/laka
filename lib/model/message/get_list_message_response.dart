import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/shared/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:client_tggt/extensions/date_formatting.dart';

part 'get_list_message_response.g.dart';

@JsonSerializable()
class GetListMessageResponse {
  @JsonKey(name: 'data')
  final GetListMessageDocs data;
  final int status;
  final String? message;

  GetListMessageResponse({
    required this.data,
    required this.status,
    this.message,
  });
  factory GetListMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListMessageResponseToJson(this);
}

@JsonSerializable()
class GetListMessageDocs {
  final List<MessageItemInList>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  GetListMessageDocs(
      {required this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});
  factory GetListMessageDocs.fromJson(Map<String, dynamic> json) =>
      _$GetListMessageDocsFromJson(json);

  Map<String, dynamic> toJson() => _$GetListMessageDocsToJson(this);
}

@JsonSerializable()
class MessageItemInList {
  @JsonKey(name: '_id')
  final String id;
  final VendorModel? vendor;
  final String? orderId;
  final String? message;
  final AccountModel? by;
  final AccountModel? customer;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageItemInList(
      {required this.id,
      this.vendor,
      this.orderId,
      this.message,
      this.by,
      this.customer,
      this.createdAt,
      this.updatedAt});

  String? get urlAvatar {
    if (vendor != null) {
      return vendor?.thumbnail?.path;
    } else {
      return by?.profile?.avatar?.path;
    }
  }

  String? get getAvatarCustomer {
    if (by != null) return by!.profile!.avatar!.path;
    return "";
  }

  String? get getAvatarVendor {
    if (customer != null) return customer?.profile!.avatar!.path ?? "";
    return "";
  }

  String? get getFullNameVendor {
    if (customer != null) return customer?.profile!.fullName ?? "";
    return "";
  }

  String? get getFullnameCustomer {
    if (by != null) return by!.profile!.fullName;
    return "";
  }

  String get fullname {
    if (vendor != null) {
      return vendor?.brandName ?? "";
    } else {
      return by?.profile?.fullName ?? "";
    }
  }

  String get displayTimeCreated =>
      StringUtils?.calcTimePost(createdAt ?? DateTime.now()) ?? '';

  CategoryType get getCategory => vendor?.category ?? CategoryType.bar;

  String get displayMessageTime {
    // final getDate =
    //     DateFormat("hh:mm dd-MM-yyyy").format(createdAt ?? DateTime.now());
    final getDate = createdAt?.tohhmmddMMyyyy() ?? '';
    final getTime = DateFormat("hh:mm").format(createdAt ?? DateTime.now());
    final getToday = DateFormat("dd-MM-yyyy").format(DateTime.now());
    final checkDate = getDate.split(" ")[1] == getToday;
    if (checkDate == true) {
      return getTime;
    } else {
      return getDate;
    }
  }

  factory MessageItemInList.fromJson(Map<String, dynamic> json) =>
      _$MessageItemInListFromJson(json);

  Map<String, dynamic> toJson() => _$MessageItemInListToJson(this);
}
