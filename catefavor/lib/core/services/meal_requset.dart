import 'package:catefavor/core/model/meal_model.dart';
import 'http_request.dart';
import 'dart:convert';

class LZMealRequest {
  static Future<List<LZMetalModel>> getMetalData() async {

    final url = "/meal";
    final data = await HttpRequest.request(url);
    final result = jsonDecode(data)["meal"];
    final List<LZMetalModel> meal = [];
    for ( var json in result) {
      meal.add(LZMetalModel.fromJson(json));
    }
    return meal;
  }
}