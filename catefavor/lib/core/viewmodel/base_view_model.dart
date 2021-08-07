import 'package:catefavor/core/model/meal_model.dart';
import 'package:flutter/material.dart';
import 'filter_view_model.dart';

class LZBaseViewModel extends ChangeNotifier {
  List<LZMetalModel> _meals = [];
  late LZFilterViewModel _filterVM;

  updateFilters(LZFilterViewModel filterViewModel){
    _filterVM = filterViewModel;
  }
  List<LZMetalModel> get meals {
    return _meals.where((meal) {
      if (_filterVM.isGlutenFree && !meal.isGlutenFree!) return false;
      if (_filterVM.isLactoseFree && !meal.isLactoseFree!) return false;
      if (_filterVM.isVegetarian && !meal.isVegetarian!) return false;
      if (_filterVM.isVegan && !meal.isVegan!) return false;
      return true;
    }).toList();
  }


  List<LZMetalModel> get originMeals {
    return _meals;
  }
  set meals(List<LZMetalModel> value) {
    _meals = value;
    notifyListeners();
  }
}