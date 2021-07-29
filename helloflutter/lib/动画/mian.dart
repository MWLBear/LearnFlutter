import 'dart:ffi';

import 'package:flutter/material.dart';
main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      ),

      home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  final GlobalKey<_AnmationDemo1State> demoKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HomeBody build");
    return Scaffold(
      appBar: AppBar(
        title: Text("动画测试"),
      ),
      body: AnmationDemo1(key: demoKey),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_circle_filled),
        onPressed: (){
          if(demoKey.currentState!.controller .isAnimating){
            demoKey.currentState!.controller.stop();
          }else if(demoKey.currentState!.controller.status == AnimationStatus.forward){
            demoKey.currentState!.controller.forward();
          }else if (demoKey.currentState!.controller.status == AnimationStatus.reverse){
            demoKey.currentState!.controller.reverse();
          }else {
            demoKey.currentState!.controller.forward();
          }
        },
      ),
    );
  }
}

class AnmationDemo1 extends StatefulWidget {
  AnmationDemo1({Key? key}) : super(key: key);

  @override
  _AnmationDemo1State createState() => _AnmationDemo1State();
}

class _AnmationDemo1State extends State<AnmationDemo1>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut, reverseCurve: Curves.easeOut);

    animation.addListener(() {
      setState(() {
      });
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    animation = Tween(begin: 50.0, end: 100.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (ctx, child){
          return Icon(Icons.favorite,color: Colors.red,size: animation.value,);
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}

//缺点:创建类 , widget有子类子类会不断构建
class IconAnimation extends AnimatedWidget {
  IconAnimation(Animation animation): super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Animation animation = listenable as Animation;
    return Icon(Icons.favorite,color: Colors.red,size: animation.value,);
  }
}
