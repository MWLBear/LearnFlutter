import 'package:catefavor/core/user_default/use_default.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:catefavor/core/user_default/sputils.dart';

class LZFilterViewModel extends ChangeNotifier{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // 无谷蛋白
  bool _isGlutenFree = false;
  // 有无乳糖
  bool _isLactoseFree = false;
  // 素食主义
  bool _isVegetarian = false;
  // 严格素食主义
  bool _isVegan = false;

  bool get isGlutenFree {
    _isGlutenFree = SpUtils.getBool(LZUserDefault.isGlutenFree);
    return _isGlutenFree;
  }

  set isGlutenFree(bool value) {
    SpUtils.setBool(LZUserDefault.isGlutenFree, value);
    _isGlutenFree = value;
    notifyListeners();
  }


  bool get isLactoseFree {
    return _isLactoseFree;
  }

  set isLactoseFree(bool value) {
    _isLactoseFree = value;
    notifyListeners();
  }

  bool get isVegan => _isVegan;

  set isVegan(bool value) {
    _isVegan = value;
    notifyListeners();
  }

  bool get isVegetarian => _isVegetarian;

  set isVegetarian(bool value) {
    _isVegetarian = value;
    notifyListeners();
  }
}