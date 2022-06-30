// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingItemModel _$BookingItemModelFromJson(Map<String, dynamic> json) =>
    BookingItemModel(
      id: json['_id'] as String?,
      product: json['product'] == null
          ? null
          : ServicesModel.fromJson(json['product'] as Map<String, dynamic>),
      productOptions: (json['productOptions'] as List<dynamic>?)
          ?.map((e) => ProductOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      customer: json['customer'] == null
          ? null
          : AccountModel.fromJson(json['customer'] as Map<String, dynamic>),
      vendor: json['vendor'] == null
          ? null
          : VendorModel.fromJson(json['vendor'] as Map<String, dynamic>),
      status: json['status'] == null
          ? BookingStatus.pending
          : stringToBookingStatus(json['status'] as String),
      totalPeople: json['totalPeople'] as int?,
      orderAt: json['orderAt'] == null
          ? null
          : DateTime.parse(json['orderAt'] as String),
      note: json['note'] as String?,
      cancelNote: json['cancelNote'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
      orderId: json['orderId'] as String?,
      receipt: json['receipt'] == null
          ? null
          : ReceiptModel.fromJson(json['receipt'] as Map<String, dynamic>),
      voucherDiscount: json['voucherDiscount'] == null
          ? null
          : DiscountVoucherModel.fromJson(
              json['voucherDiscount'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      chatRoomId: json['chatRoomId'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      totalStaffPrice: (json['totalStaffPrice'] as num?)?.toDouble() ?? 0,
      totalMenuPrice: (json['totalMenuPrice'] as num?)?.toDouble(),
      staffs: (json['staffs'] as List<dynamic>?)
          ?.map((e) => StaffModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      review: json['review'] == null
          ? null
          : ReviewModel.fromJson(json['review'] as Map<String, dynamic>),
      menuItems: (json['menuItems'] as List<dynamic>?)
          ?.map(
              (e) => SelectedMenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSubFeePrice: (json['totalSubFeePrice'] as num?)?.toDouble(),
      subFees: (json['subFees'] as List<dynamic>?)
          ?.map((e) => SubFeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingItemModelToJson(BookingItemModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'vendor': instance.vendor,
      'productOptions': instance.productOptions,
      'customer': instance.customer,
      'status': bookingStatusToString(instance.status),
      'totalPeople': instance.totalPeople,
      'orderAt': instance.orderAt?.toIso8601String(),
      'note': instance.note,
      'cancelNote': instance.cancelNote,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'orderId': instance.orderId,
      'receipt': instance.receipt,
      'voucherDiscount': instance.voucherDiscount,
      'chatRoomId': instance.chatRoomId,
      'review': instance.review,
      'totalStaffPrice': instance.totalStaffPrice,
      'totalMenuPrice': instance.totalMenuPrice,
      'totalSubFeePrice': instance.totalSubFeePrice,
      'staffs': instance.staffs,
      'menuItems': instance.menuItems,
      'subFees': instance.subFees,
    };

ReceiptModel _$ReceiptModelFromJson(Map<String, dynamic> json) => ReceiptModel(
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0,
      finalPrice: (json['finalPrice'] as num?)?.toDouble() ?? 0,
      discountPercent: (json['discountPercent'] as num?)?.toDouble() ?? 0,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ReceiptModelToJson(ReceiptModel instance) =>
    <String, dynamic>{
      'totalPrice': instance.totalPrice,
      'finalPrice': instance.finalPrice,
      'discountPercent': instance.discountPercent,
      'images': instance.images,
    };

ProductOptionModel _$ProductOptionModelFromJson(Map<String, dynamic> json) =>
    ProductOptionModel(
      option: json['option'] == null
          ? null
          : OptionModel.fromJson(json['option'] as Map<String, dynamic>),
      amount: json['amount'] as int?,
    );

Map<String, dynamic> _$ProductOptionModelToJson(ProductOptionModel instance) =>
    <String, dynamic>{
      'option': instance.option,
      'amount': instance.amount,
    };

OptionModel _$OptionModelFromJson(Map<String, dynamic> json) => OptionModel(
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      priority: json['priority'] as int?,
      type: json['type'] as String?,
      cost: json['cost'] as int?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$OptionModelToJson(OptionModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'priority': instance.priority,
      'type': instance.type,
      'cost': instance.cost,
      'id': instance.id,
    };
