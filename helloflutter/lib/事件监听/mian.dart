import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';


final eventBus = EventBus();
class UserInfo{
  String nickName;
  int age;
  UserInfo(this.nickName,this.age);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("事件监听"),
      ),
      body: Center(
        child: Column(
          children: [
            Button(),
            Text_View(),
          ],
        ),
      )
    );
  }
}

class HYContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
        onPointerDown: (event) {
          print("手指按下0: ${event.position}");
          print("手指按下1: ${event.localPosition}");

        } ,
        onPointerMove: (event) => print("手指移动: $event"),
        onPointerUp: (event)=> print("手指抬起: $event"),
      ),
    );
  }
}

class HYContent1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 200,
        height: 200,
        color: Colors.green,
      ),
      onTapDown: (detail){
        print('按下');
        print(detail.globalPosition);
        print(detail.localPosition);
      },
      onTapUp: (detail){
        print("抬起");
        print(detail.globalPosition);
        print(detail.localPosition);
      },
      onDoubleTap: (){
        print("双击");
      },
      onLongPress: (){
        print("长按");
      },
    );
  }
}
class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      eventBus.fire(UserInfo("lz", 19));
    }, child: Text("Button"));
  }
}

class Text_View extends StatefulWidget {

  @override
  _Text_ViewState createState() => _Text_ViewState();
}

class _Text_ViewState extends State<Text_View> {
  var _message = "Hello world";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    eventBus.on<UserInfo>().listen((event) {
      print(event.nickName);
      print(event.age);
      setState(() {
        _message = "${event.nickName}-${event.age}";
      });
    });


  }
  @override
  Widget build(BuildContext context) {
    return Text(_message,style: TextStyle(fontSize: 20),);
  }
}

