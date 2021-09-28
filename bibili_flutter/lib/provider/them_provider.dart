import 'package:bibili_flutter/db/hi_cache.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:bibili_flutter/util/hi_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

extension ThemeModeExtesion on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemProvider extends ChangeNotifier {
  ThemeMode? _themeMode;
  var _platformBrightness =
      SchedulerBinding.instance?.window.platformBrightness;

  ///系统Dark Mode 发生变化
  void darkModeChange() {
    if (_platformBrightness !=
        SchedulerBinding.instance?.window.platformBrightness) {
      _platformBrightness =
          SchedulerBinding.instance?.window.platformBrightness;
      notifyListeners();
    }
  }

  ///判断是否是Dark Mode
  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      return SchedulerBinding.instance?.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  ///获取主题模式
  ThemeMode getThemeMode() {
    String? theme = HiCache.getInstance().get(HiConstants.theme);
    print("them:$theme");
    switch (theme) {
      case "Dark":
        _themeMode = ThemeMode.dark;
        break;
      case "System":
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode!;
  }

  ///设置主题
  void setTheme(ThemeMode mode) {
    HiCache.getInstance().setString(HiConstants.theme, mode.value);
    notifyListeners();
  }

  /// 获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        errorColor: isDarkMode ? HiColor.dark_red : HiColor.red,
        primaryColor: isDarkMode ? HiColor.dark_bg : white,
        accentColor: isDarkMode ? primary[50] : white,
        //指示器颜色
        indicatorColor: isDarkMode ? primary[50] : white,
        //页面背景色
        scaffoldBackgroundColor: isDarkMode ? HiColor.dark_bg : white);
    return themeData;
  }
}
