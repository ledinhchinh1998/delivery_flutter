import 'package:flutter/foundation.dart';
import 'dart:convert';

class ItemModel {
  String name;
  int price;
  String image;
  String detail;

  ItemModel({this.name, this.price, this.image, this.detail});
  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    name: json['name'],
    price: json['price'],
    image: json['image'],
    detail: json['detail']
  );

  Map<String, dynamic> toJSON() => {
    'name': name,
    'price': price,
    'image': image,
    'detail': detail
  };

}