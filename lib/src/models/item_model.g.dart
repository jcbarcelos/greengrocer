// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      itemName: json['title'] as String,
      imgUrl: json['picture'] as String,
      unit: json['unit'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      id: json['id'] as String?,
      category: json['category'] == null
          ? null
          : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'title': instance.itemName,
      'picture': instance.imgUrl,
      'unit': instance.unit,
      'price': instance.price,
      'description': instance.description,
      'id': instance.id,
      'category': instance.category,
    };
