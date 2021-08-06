
import 'package:flutter/material.dart';
import 'package:catefavor/ui/pages/mian/mian.dart';
import 'package:catefavor/ui/pages/meal/meal.dart';
import 'package:catefavor/ui/pages/detail/detail.dart';
import 'package:catefavor/ui/pages/filter/filter.dart';
class LZRouter {

  static final String initialRoute = LZMainScreen.routeName;

  static final  Map<String, WidgetBuilder> routes = {
    LZMainScreen.routeName: (ctx) => LZMainScreen(),
    LZMealScreen.routeName: (ctx) => LZMealScreen(),
    LZDetailScreen.routeName: (ctx) => LZDetailScreen(),
  };

  static final RouteFactory generateRoute = (settings){
    if (settings.name == LZFilterScreen.routeName){
      return MaterialPageRoute(
        builder: (ctx){
          return LZFilterScreen();
        },
        fullscreenDialog: true
      );
    }
    return null;
  };
  static final RouteFactory unknownRote = (setting){
    return null;
  };

}