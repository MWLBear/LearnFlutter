import 'package:bibili_flutter/db/hi_cache.dart';
import 'package:bibili_flutter/page/login_page.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: BiliApp(),
    );
  }
}

class BiliApp extends StatelessWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return LoginPage();
      },
    );
  }
}

void test2() {
  HiCache.getInstance().setString("aa", "1234");
  var value = HiCache.getInstance().get("aa");
  print('value:$value');
}
