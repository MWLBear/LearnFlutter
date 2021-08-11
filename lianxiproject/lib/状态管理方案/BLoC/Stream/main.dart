import 'dart:async';
import 'package:flutter/material.dart';

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

      home: Scaffold(
        appBar: AppBar(
          title: Text("lz"),
        ),
        body: HomeBody(),
      ) ,
    );
  }
}
class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
 late Stream<String> _stream;

  @override
  void initState() {
    super.initState();
    _stream = fetchEmojis(10);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HomeBody build");
    return Center(
      child: StreamBuilder(
        builder: _buildChildByStream,
        stream: _stream,
      ),
    );
  }

 Widget _buildChildByStream(
     BuildContext context, AsyncSnapshot<String> snapshot) {

    if(snapshot.data != null){
      return Text(snapshot.data!,style: TextStyle(fontSize: 60));
    }
   switch(snapshot.connectionState){
     case ConnectionState.none:
       break;
     case ConnectionState.waiting:
       return CircularProgressIndicator();
       break;
     case ConnectionState.active:
       return Text(snapshot.requireData,style: TextStyle(fontSize: 60));
       break;
     case ConnectionState.done:
       return Text('Stream Over--${snapshot.requireData}',style: TextStyle(fontSize: 30),);
       break;
   }
   return Container();
 }

//当下一个数据项准备好时，yield语句将此项发送到数据序列中，
// 这本质上是函数的生成结果。数据序列可以是同步的或异步的。

 Stream<String> fetchEmojis(int count) async* {
   for (int i = 0; i < count; i++) {
     yield await fetchEmoji(i);
   }
 }

 Future<String> fetchEmoji(int count) async {
   Runes first = Runes('\u{1f47f}');
   await Future.delayed(Duration(seconds: 1)); //模拟耗时
   return String.fromCharCodes(first.map((e) => e + count));
 }

}
