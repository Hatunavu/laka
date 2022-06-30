// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) => MenuModel(
      id: json['_id'] as String,
      image: json['image'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      status: json['status'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) => <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'status': instance.status,
      'description': instance.description,
    };

SelectedMenuItemModel _$SelectedMenuItemModelFromJson(
        Map<String, dynamic> json) =>
    SelectedMenuItemModel(
      amount: json['amount'] as int,
      item: MenuModel.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SelectedMenuItemModelToJson(
        SelectedMenuItemModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'item': instance.item,
    };
