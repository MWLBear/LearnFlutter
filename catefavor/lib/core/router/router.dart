import 'package:flutter/material.dart';
import 'package:catefavor/ui/pages/mian/mian.dart';

class LZRouter {

  static final String initialRoute = LZMainScreen.routeName;

  static final  Map<String, WidgetBuilder> routes = {
    LZMainScreen.routeName: (ctx)=> LZMainScreen(),

  };
  static final RouteFactory generateRoute = (settings){
    return null;
  };
  static final RouteFactory unknownRote = (setting){
    return null;
  };

}