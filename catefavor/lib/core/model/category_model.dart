import 'package:catefavor/core/router/router.dart';
import 'package:flutter/cupertino.dart';

class LZCategoryModel {
  late String id;
  late String title;
  late String color;
  late Color cColor;

  LZCategoryModel(this.id, this.title, this.color);

  LZCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    color = json['color'];

    final colorInt = int.parse(color,radix: 16);
    cColor = Color(colorInt | 0xFF000000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['color'] = this.color;
    return data;
  }
}