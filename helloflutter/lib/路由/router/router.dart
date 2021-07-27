import 'package:flutter/material.dart';
import '../main.dart';
import '../about.dart';
import '../detail.dart';
import '../unknow.dart';

class LZRouter {
  static final  Map<String, WidgetBuilder> routes = {
      HomeBody.routeName: (ctx) => HomeBody(),
      AboutPage.routeName: (ctx) => AboutPage(),
  };
  static final String initialRoute = HomeBody.routeName;
  static final RouteFactory generateRoute = (settings){
    if (settings.name == Detail.routeName){
      return MaterialPageRoute(builder: (ctx){
        return Detail(settings.arguments as String);
      });
    }
    return null;
  };
  static final RouteFactory unknownRote = (setting){
    return MaterialPageRoute(builder: (ctx){
      return UnKnownPage();
    });
  };

}