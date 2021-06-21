import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text("lz"),
        ),
        body: HomeBody(),
      ) ,
    );
  }
}
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HomeBody build");
    return MyCounterWidget("你好,磊子");
  }
}


class MyCounterWidget extends StatefulWidget {

  final String message;
  // MyCounterWidget(String message, this.message){
  //   this.message = message;
  //   print("执行了MyCounterWidget的构造方法");
  // }
  MyCounterWidget(this.message);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("执行了MyCounterWidget的createState方法");
    return MyCounterState();
  }
}
class MyCounterState extends State<MyCounterWidget> {
  int counter = 0;
  MyCounterState(){
    print("执行MyCounterState的构造方法");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("执行MyCounterState的init方法");

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("执行MyCounterState的didChangeDependencies方法");
  }
  @override
  void didUpdateWidget(covariant MyCounterWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print("执行MyCounterState的didUpdateWidget方法");

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("执行MyCounterState的dispose方法");
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("执行执行MyCounterState的build方法");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    counter ++;
                  });
                },
                child: Text('+',style: TextStyle(fontSize: 18,color: Colors.black)),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              ),
              ElevatedButton(
                onPressed: (){
                  setState(() {
                    counter --;
                  });
                },
                child: Text('-',style: TextStyle(fontSize: 18,color: Colors.black)),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)),
              )
            ],
          ),
          Text("当前计数: $counter",style: TextStyle(fontSize: 20)),
          Text("传递过来的信息:${this.widget.message}",style: TextStyle(fontSize: 20),)
        ],
      ),
    );


    Text("当前计数: $counter",style: TextStyle(fontSize: 20));
  }
}