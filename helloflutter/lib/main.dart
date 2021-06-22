import 'package:flutter/material.dart';
import "dart:io";
import 'package:helloflutter/service/http_request.dart';
main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter layout Demo",
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter layout demo"),
        ),
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NetTextContent();
  }
}

class NetTextContent extends StatefulWidget {
  const NetTextContent({Key? key}) : super(key: key);

  @override
  _NetTextContentState createState() => _NetTextContentState();
}

class _NetTextContentState extends State<NetTextContent> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpRequest.requset("https://httpbin.org/get",params: {'name':'why'}).then((value){
      print(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Future<String> getNetWork(){
  return Future<String>((){
    sleep(Duration(seconds: 3));
    return "net work";
  });
}


