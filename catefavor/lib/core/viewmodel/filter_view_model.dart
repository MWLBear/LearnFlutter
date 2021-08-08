import 'package:catefavor/core/user_default/use_default.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:catefavor/core/user_default/sputils.dart';

class LZFilterViewModel extends ChangeNotifier{

  final _keyGlutenFree = "isGlutenFree";
  final _keyLactoseFree = "isLactoseFree";
  final _keyVegetarian = "isVegetarian";
  final _keyVegan = "isVegan";

  // 无谷蛋白
  bool _isGlutenFree = false;
  // 有无乳糖
  bool _isLactoseFree = false;
  // 素食主义
  bool _isVegetarian = false;
  // 严格素食主义
  bool _isVegan = false;

  bool get isGlutenFree => SpUtils.getBool(_keyGlutenFree);

  set isGlutenFree(bool value) {
    SpUtils.setBool(_keyGlutenFree, value);
    _isGlutenFree = value;
    notifyListeners();
  }


  bool get isLactoseFree => SpUtils.getBool(_keyLactoseFree);

  set isLactoseFree(bool value) {
    SpUtils.setBool(_keyLactoseFree, value);
    _isLactoseFree = value;
    notifyListeners();
  }

  bool get isVegan => SpUtils.getBool(_keyVegan);

  set isVegan(bool value) {
    _isVegan = value;
    SpUtils.setBool(_keyVegan, value);
    notifyListeners();
  }

  bool get isVegetarian => SpUtils.getBool(_keyVegetarian);

  set isVegetarian(bool value) {
    _isVegetarian = value;
    SpUtils.setBool(_keyVegetarian, value);
    notifyListeners();
  }
}