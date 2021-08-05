// To parse this JSON data, do
//
//     final lzMetalModel = lzMetalModelFromJson(jsonString);

import 'dart:convert';

List<LZMetalModel> lzMetalModelFromJson(String str) => List<LZMetalModel>.from(json.decode(str).map((x) => LZMetalModel.fromJson(x)));

String lzMetalModelToJson(List<LZMetalModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
List<String> complexes = ["简单", "中等", "困难"];

class LZMetalModel {
  LZMetalModel(this.complexStr,{
    this.id,
    this.categories,
    this.title,
    this.affordability,
    this.complexity,
    this.imageUrl,
    this.duration,
    this.ingredients,
    this.steps,
    this.isGlutenFree,
    this.isVegan,
    this.isVegetarian,
    this.isLactoseFree,
  });

  String complexStr;
  String? id;
  List<String>? categories;
  String? title;
  int? affordability;
  int? complexity;
  String? imageUrl;
  int? duration;
  List<String>? ingredients;
  List<String>? steps;
  bool? isGlutenFree;
  bool? isVegan;
  bool? isVegetarian;
  bool? isLactoseFree;
  factory LZMetalModel.fromJson(Map<String, dynamic> json) => LZMetalModel(
    complexes[json["complexity"]],
    id: json["id"],
    categories: List<String>.from(json["categories"].map((x) => x)),
    title: json["title"],
    affordability: json["affordability"],
    complexity: json["complexity"],
    imageUrl: json["imageUrl"],
    duration: json["duration"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    steps: List<String>.from(json["steps"].map((x) => x)),
    isGlutenFree: json["isGlutenFree"],
    isVegan: json["isVegan"],
    isVegetarian: json["isVegetarian"],
    isLactoseFree: json["isLactoseFree"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categories": List<dynamic>.from(categories!.map((x) => x)),
    "title": title,
    "affordability": affordability,
    "complexity": complexity,
    "imageUrl": imageUrl,
    "duration": duration,
    "ingredients": List<dynamic>.from(ingredients!.map((x) => x)),
    "steps": List<dynamic>.from(steps!.map((x) => x)),
    "isGlutenFree": isGlutenFree,
    "isVegan": isVegan,
    "isVegetarian": isVegetarian,
    "isLactoseFree": isLactoseFree,
  };
}
