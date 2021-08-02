
import 'package:flutter/material.dart';
import 'appthem.dart';

main() {

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      darkTheme: APPTheme.darkTheme,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
        primaryColor: Colors.pink,
        accentColor: Colors.green,
        cardTheme: CardTheme(
          color: Colors.greenAccent,
          elevation: 10,
          shape: Border.all(width: 3,color: Colors.red),
          margin: EdgeInsets.all(10)
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 15, color: Colors.green),
          bodyText2: TextStyle(fontSize: 20, color: Colors.red),

        ),
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
    // TODO: implement build
    print("HomeBody build");
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = mediaQueryData.size.width;
    final screenHeight = mediaQueryData.size.height;
    final screengHeight = mediaQueryData.size.height;
     // final phsicalWidth = window.screen!.width;
     // final physicalHeight = window.screen!.height;

    print("屏幕width:$screenWidth height:$screenHeight");
    //print("分辨率: $phsicalWidth - $physicalHeight");


    final statusBarHeight = mediaQueryData.padding.top;
    final bottomHeight = mediaQueryData.padding.bottom;

    print("状态栏height: $statusBarHeight 底部高度: $bottomHeight");

    return Scaffold(
      appBar: AppBar(
        title: Text("lz"),
      ),
      body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("123456",style: Theme.of(context).textTheme.headline4,),
                Text("123456"),
                Switch(value: true, onChanged: (event){}),
                Card(
                  child: Text("传奇世界",style: TextStyle(fontSize: 50),),
                )
              ],
            ),
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: "分类"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          print("add click");
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx){
                return LZDetail();
              })
          );
        },
      ),
    )  ;


  }
}

class LZDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.red),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("详情页"),
        ),
        body: Container(
          child: Center(
            child: Text("detail"),
          ),
        ),
        floatingActionButton: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: Colors.purple
            )
          ),
          child: FloatingActionButton(
            child: Icon(Icons.pedal_bike),
            onPressed: (){

            },
          ),
        ),
      ),
    );
  }
}
