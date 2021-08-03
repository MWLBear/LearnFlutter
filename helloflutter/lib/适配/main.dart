import 'dart:ui';
import 'package:flutter/src/widgets/media_query.dart';
import 'package:flutter/material.dart';
import 'LZSizeFit.dart';

main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    LZSizeFit.initialize();

    final physicalWidth =  window.physicalSize.width;
    final physicalHeight = window.physicalSize.height;
    final dpr = window.devicePixelRatio;

    final width = physicalWidth / dpr;
    final height = physicalHeight / dpr;

    print("分辨率: $physicalWidth - $physicalHeight");
    print("屏幕宽高: $width - $height");

    final statusHeight = window.padding.top / dpr;
    print("drp: $dpr");
    print("状态栏高度: $statusHeight");

    return MaterialApp(
      title: "Demo",
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      ),

      home: HomeBody()
    );
  }
}
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final mediaQueryData = MediaQuery.of(context);
    //
    // final screenWidth = mediaQueryData.size.width;
    // final screenHeight = mediaQueryData.size.height;
    // print("屏幕width:$screenWidth height:$screenHeight");

    return Scaffold(
      appBar: AppBar(
        title: Text("lz"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          color: Colors.red,
          width: 200.px,
          height: 200.px,
          child: Text("123",style: TextStyle(fontSize: 30),),
        ),
      ),
    ) ;
  }
}
