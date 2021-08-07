import 'package:flutter/material.dart';
import 'package:catefavor/core/model/meal_model.dart';
import 'base_view_model.dart';

class LZFavorViewModel extends LZBaseViewModel{

  void addMeal(LZMetalModel model){
    originMeals.add(model);
    notifyListeners();
  }
  void removeMeal(LZMetalModel model){
    originMeals.remove(model);
    notifyListeners();
  }
  bool isFavorMeal(LZMetalModel model){
    return originMeals.contains(model);
  }

  void handleMeal(LZMetalModel model){
    if (isFavorMeal(model)){
      print("removeMeal");
      removeMeal(model);
    }else{
      print("add");
      addMeal(model);
    }
  }

}