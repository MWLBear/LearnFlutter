import 'package:flutter/material.dart';
import 'detail.dart';
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
          title: Text("路由"),
        ),
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  String _homeMessage = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HomeBody build");

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_homeMessage,style: TextStyle(color: Colors.red),),
          ElevatedButton(
            child: Text("跳转到详情页"),
            onPressed: () => _jumpDetail(context)
          ),
        ],
      ),
    );
  }

  void _jumpDetail(BuildContext context){
    //普通的跳转方式
    final future =  Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Detail("a home message");
    }));

    future.then((value){
      setState(() {
        _homeMessage = value;
      });
    });
  }
}
