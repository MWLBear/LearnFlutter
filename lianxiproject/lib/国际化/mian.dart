import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization.dart';
import 'localizations_delegate.dart';
import '../generated/l10n.dart';
import 'curve_painter.dart';

main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
        GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
      ],
      title: "国际化",
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text("国际化"),
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
  double _currentSliderValue = 20.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("HomeBody build");
<<<<<<< HEAD
    InheritedWidget;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text(S.of(context).greet),
            SizedBox(height: 10),
            ElevatedButton(onPressed: (){
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2019),
                  lastDate: DateTime(2022)
              );
            }, child: Text(S.of(context).picktime))
          ],
=======
    return Container(
      color: Colors.green,
      height: 60,
      child: CustomPaint(
        painter: CurvePainter(),
        child: buildCenter(),
      )
      );
  }

  Center buildCenter() {
    return Center(
        child: Slider(
          activeColor:Colors.red,
          min: 0,
          max: 100,
          divisions: 100,
          label: _currentSliderValue.round().toString(),
          value: _currentSliderValue,
          onChanged: (value){
            setState(() {
              _currentSliderValue = value;
            });
          },
>>>>>>> 7ae29a297999b9d38818819e2d3198033ac1fc71
        ),
      );
  }

  final ColorTween colorTween = ColorTween(
    begin: Colors.red,
    end: Colors.green
  );

  Widget _paddView (BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Column(
        children: [
          Text(S.of(context).greet),
          SizedBox(height: 10),
          ElevatedButton(onPressed: (){
            showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2022)
            );
          }, child: Text(S.of(context).picktime))
        ],
      ),
    ),
  );
}
