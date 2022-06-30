// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorInfoModel _$VendorInfoModelFromJson(Map<String, dynamic> json) =>
    VendorInfoModel(
      id: json['_id'] as String?,
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      type: json['type'] as String?,
      vendor: json['vendor'] == null
          ? null
          : VendorModel.fromJson(json['vendor'] as Map<String, dynamic>),
      authentication: json['authentication'] == null
          ? null
          : Authentication.fromJson(
              json['authentication'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VendorInfoModelToJson(VendorInfoModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'phone': instance.phone,
      'type': instance.type,
      'profile': instance.profile,
      'vendor': instance.vendor,
      'authentication': instance.authentication,
    };

VendorProfile _$VendorProfileFromJson(Map<String, dynamic> json) =>
    VendorProfile(
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$VendorProfileToJson(VendorProfile instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
    };

VendorModel _$VendorModelFromJson(Map<String, dynamic> json) => VendorModel(
      details: json['details'] as String?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => AttributeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String?,
      taglines: (json['taglines'] as List<dynamic>?)
          ?.map((e) => TaglineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      brandName: json['brandName'] as String? ?? '',
      address:
          VendorAddressModel.fromJson(json['address'] as Map<String, dynamic>),
      totalReviews: json['totalReviews'] as int?,
      avgRating: (json['avgRating'] as num?)?.toDouble(),
      category: json['category'] == null
          ? CategoryType.karaoke
          : stringToCategoryType(json['category'] as String),
      categoryImage: json['categoryImage'] as String?,
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => VariantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      thumbnail: json['thumbnail'] == null
          ? null
          : VendorThumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      priceRange: json['priceRange'] == null
          ? null
          : VendorPriceRange.fromJson(
              json['priceRange'] as Map<String, dynamic>),
      reviewStatistics: (json['reviewStatistics'] as List<dynamic>?)
          ?.map(
              (e) => ReviewStatisticsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      dist: json['dist'] == null
          ? null
          : Dist.fromJson(json['dist'] as Map<String, dynamic>),
      active: json['active'] as bool?,
      status: json['status'] as int? ?? 0,
      verifyStatus: json['verifyStatus'] as int?,
      owner: json['owner'] == null
          ? null
          : AccountModel.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VendorModelToJson(VendorModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'attributes': instance.attributes,
      'brandName': instance.brandName,
      'taglines': instance.taglines,
      'address': instance.address,
      'reviews': instance.reviews,
      'totalReviews': instance.totalReviews,
      'avgRating': instance.avgRating,
      'categoryImage': instance.categoryImage,
      'dist': instance.dist,
      'category': categoryTypeToString(instance.category),
      'gallery': instance.gallery,
      'products': instance.products,
      'variants': instance.variants,
      'details': instance.details,
      'thumbnail': instance.thumbnail,
      'priceRange': instance.priceRange,
      'reviewStatistics': instance.reviewStatistics,
      'active': instance.active,
      'status': instance.status,
      'verifyStatus': instance.verifyStatus,
      'owner': instance.owner,
    };

VendorThumbnail _$VendorThumbnailFromJson(Map<String, dynamic> json) =>
    VendorThumbnail(
      type: json['type'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$VendorThumbnailToJson(VendorThumbnail instance) =>
    <String, dynamic>{
      'type': instance.type,
      'path': instance.path,
    };

VendorPriceRange _$VendorPriceRangeFromJson(Map<String, dynamic> json) =>
    VendorPriceRange(
      min: (json['min'] as num?)?.toDouble(),
      max: (json['max'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VendorPriceRangeToJson(VendorPriceRange instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };

VendorLocaltion _$VendorLocaltionFromJson(Map<String, dynamic> json) =>
    VendorLocaltion(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$VendorLocaltionToJson(VendorLocaltion instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

VendorAddressCodeNames _$VendorAddressCodeNamesFromJson(
        Map<String, dynamic> json) =>
    VendorAddressCodeNames(
      province: json['province'] as String?,
      district: json['district'] as String?,
      ward: json['ward'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$VendorAddressCodeNamesToJson(
        VendorAddressCodeNames instance) =>
    <String, dynamic>{
      'province': instance.province,
      'district': instance.district,
      'ward': instance.ward,
      'address': instance.address,
    };

VendorAddressModel _$VendorAddressModelFromJson(Map<String, dynamic> json) =>
    VendorAddressModel(
      fullAddress: json['fullAddress'] as String? ?? '',
      location:
          VendorLocaltion.fromJson(json['location'] as Map<String, dynamic>),
      codeNames: json['codeNames'] == null
          ? null
          : VendorAddressCodeNames.fromJson(
              json['codeNames'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VendorAddressModelToJson(VendorAddressModel instance) =>
    <String, dynamic>{
      'fullAddress': instance.fullAddress,
      'location': instance.location,
      'codeNames': instance.codeNames,
    };

GalleryModel _$GalleryModelFromJson(Map<String, dynamic> json) => GalleryModel(
      id: json['_id'] as String?,
      path: json['path'] as String?,
      type: json['type'] as String?,
      pathUrl: json['pathUrl'] as String?,
      dimensions: json['dimensions'] == null
          ? null
          : DimensionsModel.fromJson(
              json['dimensions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GalleryModelToJson(GalleryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'path': instance.path,
      'type': instance.type,
      'pathUrl': instance.pathUrl,
      'dimensions': instance.dimensions,
    };

ReviewStatisticsModel _$ReviewStatisticsModelFromJson(
        Map<String, dynamic> json) =>
    ReviewStatisticsModel(
      total: json['total'] as int?,
      rating: json['rating'] as int?,
    );

Map<String, dynamic> _$ReviewStatisticsModelToJson(
        ReviewStatisticsModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'rating': instance.rating,
    };

DimensionsModel _$DimensionsModelFromJson(Map<String, dynamic> json) =>
    DimensionsModel(
      width: json['width'] as int?,
      height: json['height'] as int?,
    );

Map<String, dynamic> _$DimensionsModelToJson(DimensionsModel instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
    };
