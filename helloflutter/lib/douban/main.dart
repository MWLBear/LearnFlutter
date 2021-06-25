import 'package:flutter/material.dart';
import 'wigets/LZStartRating.dart';
import 'wigets/LZDashedLine.dart';
import 'package:helloflutter/douban/pages/main/main.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "豆瓣",
      theme: ThemeData(
          primaryColor: Colors.green,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent),

      home:LZMainPage() ,
    );
  }
}


