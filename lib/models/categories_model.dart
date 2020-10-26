import 'package:flutter/foundation.dart';

class CategoriesModel {
  int id;
  String name;
  String count;
  String image;
  String urlStr;

  CategoriesModel({this.id, this.name, this.count, this.image, this.urlStr});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
    id: json['id'],
    name : json['name'],
    count: json['count'],
    image: json['image'],
    urlStr: json['url']
  );
}