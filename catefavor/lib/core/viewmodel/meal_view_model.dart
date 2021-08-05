import 'package:catefavor/core/model/meal_model.dart';
import 'package:catefavor/core/services/meal_requset.dart';
import 'package:flutter/material.dart';
class LZMealViewModel extends ChangeNotifier {
  List<LZMetalModel> _meals = [];
  List<LZMetalModel> get meals {
    return _meals;
  }
  LZMealViewModel(){
    LZMealRequest.getMetalData().then((res){
      _meals = res;
    });
    notifyListeners();
  }
}