import 'package:flutter/material.dart';
import 'package:catefavor/ui/pages/mian/mian.dart';
import 'package:catefavor/ui/pages/meal/meal.dart';
import 'package:catefavor/ui/pages/detail/detail.dart';
class LZRouter {

  static final String initialRoute = LZMainScreen.routeName;

  static final  Map<String, WidgetBuilder> routes = {
    LZMainScreen.routeName: (ctx) => LZMainScreen(),
    LZMealScreen.routeName: (ctx) => LZMealScreen(),
    LZDetailScreen.routeName: (ctx) => LZDetailScreen(),
  };

  static final RouteFactory generateRoute = (settings){
    return null;
  };
  static final RouteFactory unknownRote = (setting){
    return null;
  };

}