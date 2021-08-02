import 'package:flutter/material.dart';

class APPTheme {

  static double _titleFontSize = 20.0;
  static final ThemeData lightThem = ThemeData(
    primaryColor: Colors.pink,
    primaryTextTheme: TextTheme(
      title: TextStyle(
        color: Colors.yellow,
        fontSize: _titleFontSize
      )
    ),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.red)
    )
  );


  // 3.暗黑主题
  static final ThemeData darkTheme = ThemeData(
      primaryColor: Colors.grey,
      primaryTextTheme: TextTheme(
          title: TextStyle(
              color: Colors.white,
              fontSize: _titleFontSize
          )
      ),
      textTheme: TextTheme(
          title: TextStyle(color: Colors.white),
          body1: TextStyle(color: Colors.white70)
      )
  );
}