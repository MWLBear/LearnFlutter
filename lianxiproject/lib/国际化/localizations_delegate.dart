import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'localization.dart';

class LZLocalizationDelegate extends LocalizationsDelegate<LZLocalizations>{

  @override
  bool isSupported(Locale locale) {
    return ["en", "zh"].contains(locale.languageCode);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LZLocalizations> old) {
    return false;
  }
  @override
  Future<LZLocalizations> load(Locale locale) async{
    final localizations = LZLocalizations(locale);
    await localizations.loadJson();
    return localizations;
  }
  static LZLocalizationDelegate delegate = LZLocalizationDelegate();
}