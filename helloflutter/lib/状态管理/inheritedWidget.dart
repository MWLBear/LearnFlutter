import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class HYDataWidget extends InheritedWidget {
  final int counter;

  HYDataWidget({required this.counter, required Widget child})
      : super(child: child);

  static HYDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  @override
  bool updateShouldNotify(HYDataWidget oldWidget) {
    return this.counter != oldWidget.counter;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "InheritedWidget",
      theme:
          ThemeData(primaryColor: Colors.blue, splashColor: Colors.transparent),
      home: HYHomePage(),
    );
  }
}

class HYHomePage extends StatefulWidget {
  const HYHomePage({Key? key}) : super(key: key);

  @override
  _HYHomePageState createState() => _HYHomePageState();
}

class _HYHomePageState extends State<HYHomePage> {
  int data = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InheritedWidget'),
      ),
      body: HYDataWidget(
        counter: data,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HYSHowData1(),
            HYShowData2(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            data++;
          });
        },
      ),
    );
  }
}

class HYSHowData1 extends StatefulWidget {
  @override
  _HYSHowData1State createState() => _HYSHowData1State();
}

class _HYSHowData1State extends State<HYSHowData1> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("执行了_HYShowData01State中的didChangeDependencies");
  }

  @override
  Widget build(BuildContext context) {
    int counter = HYDataWidget.of(context).counter;
    return Card(
      color: Colors.redAccent,
      child: Text(
        "当前计数: $counter",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}

class HYShowData2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int counter = HYDataWidget.of(context).counter;

    return Container(
      child: Text(
        "当前计数: $counter",
        style: TextStyle(fontSize: 30),
      ),
      color: Colors.blue,
    );
  }
}
