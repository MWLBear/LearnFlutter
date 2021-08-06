import 'package:flutter/material.dart';

class APPTheme {

  static const double bodyFontSize = 14;
  static const double smallFontSize = 16;
  static const double normalFontSize = 20;
  static const double largeFontSize = 24;


  static final ThemeData lightThem = ThemeData(
    primarySwatch:Colors.pink,
    accentColor: Colors.amber,
    canvasColor:Color.fromRGBO(255, 254, 222, 1),
    scaffoldBackgroundColor: Color.fromRGBO(255, 254, 222, 1),
    textTheme: TextTheme(
        bodyText2: TextStyle(fontSize: bodyFontSize),
        headline1: TextStyle(fontSize: smallFontSize,color: Colors.black87),
        headline2: TextStyle(fontSize: normalFontSize,color: Colors.black87),
        headline3: TextStyle(fontSize: largeFontSize,color: Colors.black87),

    ),
  );


  // 3.暗黑主题
  static final ThemeData darkTheme = ThemeData(
      primaryColor: Colors.grey,

      textTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          body1: TextStyle(color: Colors.white70)
      )
  );
}