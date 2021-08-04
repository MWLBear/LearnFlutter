import 'dart:convert';
import 'package:catefavor/core/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class LZJsonParse{

  static Future<List<LZCategoryModel>> getCategoryData() async{
    final jsonString = await rootBundle.loadString("assets/json/category.json");
    final reslut = json.decode(jsonString);
    final resultList = reslut["category"];

    List<LZCategoryModel> categories = [];
    for (var json in resultList){
      categories.add(LZCategoryModel.fromJson(json));
    }
    return categories;
  }

}