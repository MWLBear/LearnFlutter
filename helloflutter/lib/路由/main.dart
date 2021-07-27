import 'package:flutter/material.dart';
import 'package:helloflutter/%E8%B7%AF%E7%94%B1/about.dart';
import 'package:helloflutter/%E8%B7%AF%E7%94%B1/unknow.dart';
import 'detail.dart';
main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeBody.routeName,
      routes: {
        HomeBody.routeName: (ctx) => HomeBody(),
        AboutPage.routeName: (ctx) => AboutPage(),
      },
      onGenerateRoute: (settings){
        if (settings.name == Detail.routeName){
          return MaterialPageRoute(builder: (ctx){
            return Detail(settings.arguments as String);
          });
        }
        return null;
      },
      onUnknownRoute: (setting){
        return MaterialPageRoute(builder: (ctx){
          return UnKnownPage();
        });
      },
      title: "Demo",
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  static const String routeName = "/";
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  String _homeMessage = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HomeBody build");

    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_homeMessage, style: TextStyle(color: Colors.red),),
            ElevatedButton(
                child: Text("跳转到详情页"),
                onPressed: () => _jumpDetail(context)
            ),
            ElevatedButton(
                child: Text("跳转到关于页面"),
                onPressed: () => _jumpToAbout(context)
            ),
            ElevatedButton(
                onPressed: () => _jumpDetail2(context),
                child: Text("跳转到详情页2")
            ),
            ElevatedButton(onPressed: () => _jumpToSettings(context),
                child: Text("跳转转到设置界面"))
          ],
        ),
      ),
    );
  }

  void _jumpDetail(BuildContext context){
    //1.0 普通的跳转方式
    final future =  Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Detail("a home message");
    }));

    future.then((value){
      setState(() {
        _homeMessage = value;
      });
    });
  }

  void _jumpToAbout(BuildContext context){
    Navigator.of(context).pushNamed(AboutPage.routeName,arguments: "a home message");
  }
  void _jumpDetail2(BuildContext context) {
    Navigator.of(context).pushNamed(Detail.routeName,arguments: "a home detaile2 message");
  }
  void _jumpToSettings(BuildContext context){
    Navigator.of(context).pushNamed("/aaaa");
  }
}

