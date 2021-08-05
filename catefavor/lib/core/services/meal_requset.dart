import 'package:catefavor/core/model/meal_model.dart';
import 'http_request.dart';

class LZMealRequest {
  static Future<List<LZMetalModel>> getMetalData() async {

    final url = "/meal";
    final data = await HttpRequest.request(url);
    final result = data['meal'];
    final List<LZMetalModel> meal = [];
    for ( var json in result) {
      meal.add(LZMetalModel.fromJson(json));
    }
    return meal;
  }
}