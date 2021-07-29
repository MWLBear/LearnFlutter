import 'package:flutter/material.dart';
import 'dart:math';

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
  final GlobalKey<_LZAnimationState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lz"),
      ),
      body: LZAnimation(key: globalKey),
      floatingActionButton:
      FloatingActionButton(
        onPressed: () {
          globalKey.currentState!.controller.forward();
        },
        child: Icon(Icons.play_circle_filled),
      ),
    );
  }
}

class LZAnimation extends StatefulWidget{
  LZAnimation({Key? key}) : super(key: key);

  @override
  _LZAnimationState createState() => _LZAnimationState();
}

class _LZAnimationState extends State<LZAnimation>  with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation<double> animation;

  late Animation<Color> colorAnim;
  late Animation<double> sizeAnim;
  late Animation<double> rotationAnim;
  late Animation<double> opacity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    animation.addListener(() {
      setState(() {
      });
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    opacity = Tween(begin: 0.0,end: 1.0).animate(controller);
    colorAnim = ColorTween(begin: Colors.blue, end: Colors.red).animate(controller) as Animation<Color>;
    sizeAnim = Tween(begin: 0.0,end: 200.0).animate(controller);
    rotationAnim = Tween(begin: 0.0,end: 2*pi).animate(controller);

  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (ctx,child){
          return Opacity(
              opacity: opacity.value,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(rotationAnim.value),
              child: Container(
                width: sizeAnim.value,
                height: sizeAnim.value,
                color: colorAnim.value,
                alignment: Alignment.center,
              ),
            ),
          );
        },
      ),
    );
  }
}

