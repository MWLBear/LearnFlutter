import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class LZLocalizations {
  final Locale locale;
  LZLocalizations(this.locale);

  static LZLocalizations of(BuildContext context){
    return Localizations.of(context, LZLocalizations);
  }
  static Map<String, Map<String, String>> _localizeValues = {};
  // static Map<String, Map<String, String>> _localizeValues = {
  //   "en": {
  //     "title": "home",
  //     "hello": "hello~",
  //     "pickTime": "Pick a Time"
  //   },
  //   "zh": {
  //     "title": "首页",
  //     "hello": "你好~",
  //     "pickTime": "选择一个时间"
  //   }
  // };


  Future loadJson() async {
    // 1.加载json文件
    final jsonString = await rootBundle.loadString("assets/json/i18n.json");

    // 2.对json进行解析
    Map<String, dynamic> map = json.decode(jsonString);

    _localizeValues = map.map((key, value) {
      return MapEntry(key, value.cast<String, String>());
    });
  }

  String get title {
    return _localizeValues[locale.languageCode]!["title"]!;
  }

  String get hello {
    return _localizeValues[locale.languageCode]!["hello"]!;
  }

  String get pickTime {
    return _localizeValues[locale.languageCode]!["pickTime"]!;
  }

}