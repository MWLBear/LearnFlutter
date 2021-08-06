import 'package:flutter/material.dart';
import 'package:catefavor/core/model/meal_model.dart';

class LZFavorViewModel extends ChangeNotifier{
  List<LZMetalModel> _model = [];
  List<LZMetalModel> get favorMeals {
    return _model;
  }
  LZFavorViewModel();
  void addMeal(LZMetalModel model){
    _model.add(model);
    notifyListeners();
  }
  void removeMeal(LZMetalModel model){
    _model.remove(model);
    notifyListeners();
  }
  bool isFavorMeal(LZMetalModel model){
    return _model.contains(model);
  }

  void handelMeal(LZMetalModel model){
    if (isFavorMeal(model)){
      removeMeal(model);
    }else{
      addMeal(model);
    }
  }

}