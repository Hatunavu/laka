import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/dist.dart';
import 'package:client_tggt/model/vendor/review_model.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/model/vendor/tagline_model.dart';
import 'package:client_tggt/model/vendor/variant_model.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendor_info_model.g.dart';

@JsonSerializable()
class VendorInfoModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? phone;
  final String? type;
  final Profile? profile;
  VendorModel? vendor;

  final Authentication? authentication;

  VendorInfoModel(
      {this.id,
      this.profile,
      this.phone,
      this.type,
      this.vendor,
      this.authentication});

  String get accountAvatar {
    return profile!.avatar!.path ?? "";
  }

  String? get getVendorThumnail {
    if (vendor == null) return "";
    return vendor?.thumbnail!.path;
  }

  String? get vendorBrandname {
    if (vendor == null) return "";
    return vendor?.brandName;
  }

  List<GalleryModel> get listVendorGallery {
    return vendor?.gallery ?? [];
  }

  String? get vendorFullAddress {
    return vendor?.address.fullAddress ?? "";
  }

  VendorLocaltion? get vendorLocation {
    return vendor?.address.location;
  }

  factory VendorInfoModel.fromJson(Map<String, dynamic> json) =>
      _$VendorInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$VendorInfoModelToJson(this);
}

@JsonSerializable()
class VendorProfile {
  final String avatar;
  VendorProfile({required this.avatar});

  factory VendorProfile.fromJson(Map<String, dynamic> json) =>
      _$VendorProfileFromJson(json);

  Map<String, dynamic> toJson() => _$VendorProfileToJson(this);
}

@JsonSerializable()
class VendorModel {
  @JsonKey(name: '_id')
  final String? id;
  final List<AttributeModel>? attributes;
  @JsonKey(name: 'brandName', defaultValue: "")
  final String brandName;
  final List<TaglineModel>? taglines;
  final VendorAddressModel address;
  final List<ReviewModel>? reviews;
  final int? totalReviews;
  final double? avgRating;
  final String? categoryImage;
  final Dist? dist;
  @JsonKey(
      name: 'category',
      fromJson: stringToCategoryType,
      toJson: categoryTypeToString,
      defaultValue: CategoryType.karaoke)
  final CategoryType category;
  final List<GalleryModel>? gallery;
  final List<ServicesModel>? products;
  final List<VariantModel>? variants;
  final String? details;
  VendorThumbnail? thumbnail;
  final VendorPriceRange? priceRange;
  final List<ReviewStatisticsModel>? reviewStatistics;
  final bool? active;
  final int? status;
  final int? verifyStatus;
  final AccountModel? owner;

  VendorModel(
      {this.details,
      this.attributes,
      this.id,
      this.taglines,
      required this.brandName,
      required this.address,
      this.totalReviews,
      this.avgRating,
      required this.category,
      this.categoryImage,
      this.gallery,
      this.products,
      this.variants,
      this.reviews,
      this.thumbnail,
      this.priceRange,
      this.reviewStatistics,
      this.dist,
      this.active,
      this.status = 0,
      this.verifyStatus,
      this.owner});

  String get getOwnerPhone {
    if (owner == null) return "";
    return owner!.phone ?? "";
  }

  String get fullAddressPrimary {
    if (address.codeNames == null) {
      return address.fullAddress;
    } else {
      return '${address.codeNames?.address}, ${address.codeNames?.ward}, ${address.codeNames?.district}';
    }
  }

  factory VendorModel.fromJson(Map<String, dynamic> json) =>
      _$VendorModelFromJson(json);

  Map<String, dynamic> toJson() => _$VendorModelToJson(this);
}

@JsonSerializable()
class VendorThumbnail {
  final String? type;
  final String? path;
  VendorThumbnail({this.type, this.path});
  factory VendorThumbnail.fromJson(Map<String, dynamic> json) =>
      _$VendorThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$VendorThumbnailToJson(this);
}

@JsonSerializable()
class VendorPriceRange {
  final double? min;
  final double? max;
  VendorPriceRange({this.min, this.max});

  String toPriceRange() {
    final currencyFormatter = NumberFormat('#,##0  đ', 'ID');
    return "${currencyFormatter.format(min ?? 0.0)} - ${currencyFormatter.format(max ?? 0.0)}";
  }

  String getMinPrice() {
    final currencyFormatter = NumberFormat('#,##0  đ', 'ID');
    return currencyFormatter.format(min ?? 0.0);
  }

  factory VendorPriceRange.fromJson(Map<String, dynamic> json) =>
      _$VendorPriceRangeFromJson(json);

  Map<String, dynamic> toJson() => _$VendorPriceRangeToJson(this);
}

@JsonSerializable()
class VendorLocaltion {
  final String? type;
  final List<double>? coordinates;
  VendorLocaltion({this.type, this.coordinates});
  factory VendorLocaltion.fromJson(Map<String, dynamic> json) =>
      _$VendorLocaltionFromJson(json);

  Map<String, dynamic> toJson() => _$VendorLocaltionToJson(this);
}

@JsonSerializable()
class VendorAddressCodeNames {
  final String? province;
  final String? district;
  final String? ward;
  final String? address;
  VendorAddressCodeNames(
      {this.province, this.district, this.ward, this.address});
  factory VendorAddressCodeNames.fromJson(Map<String, dynamic> json) =>
      _$VendorAddressCodeNamesFromJson(json);

  Map<String, dynamic> toJson() => _$VendorAddressCodeNamesToJson(this);
}

@JsonSerializable()
class VendorAddressModel {
  @JsonKey(name: 'fullAddress', defaultValue: "")
  final String fullAddress;
  final VendorLocaltion location;
  final VendorAddressCodeNames? codeNames;
  VendorAddressModel(
      {required this.fullAddress, required this.location, this.codeNames});
  factory VendorAddressModel.fromJson(Map<String, dynamic> json) =>
      _$VendorAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$VendorAddressModelToJson(this);
}

@JsonSerializable()
class GalleryModel {
  GalleryModel({this.id, this.path, this.type, this.pathUrl, this.dimensions});
  @JsonKey(name: '_id')
  final String? id;
  final String? path;
  final String? type;
  final String? pathUrl;
  final DimensionsModel? dimensions;

  factory GalleryModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryModelToJson(this);
}

@JsonSerializable()
class ReviewStatisticsModel {
  ReviewStatisticsModel({this.total, this.rating});
  final int? total;
  final int? rating;

  factory ReviewStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewStatisticsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewStatisticsModelToJson(this);
}

@JsonSerializable()
class DimensionsModel {
  final int? width;
  final int? height;

  DimensionsModel({
    this.width,
    this.height,
  });

  factory DimensionsModel.fromJson(Map<String, dynamic> json) {
    return _$DimensionsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DimensionsModelToJson(this);
}
