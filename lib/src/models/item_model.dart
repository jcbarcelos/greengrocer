// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:greengrocer/src/models/category_model.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  @JsonKey(name: 'title')
  late String itemName;
  @JsonKey(name: 'picture')
  late String imgUrl;
  late String unit;
  late double price;
  late String description;
  late String? id;
  late CategoryModel? category;

  ItemModel({
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
    this.id,
    this.category,
  });

  factory ItemModel.fromJson(Map<String, dynamic> map) =>
      _$ItemModelFromJson(map);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description, id: $id, category: $category';
  }
}
