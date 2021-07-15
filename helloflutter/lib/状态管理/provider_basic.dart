import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodel/counter_view_model.dart';

void main(){
  runApp(ChangeNotifierProvider(create: (ctx)=>HYCounterViewModel(),
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        title: Text("列表测试"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HYShowData01(),
            HYShowData2()
          ],
        ),
      ),
      floatingActionButton: Selector<HYCounterViewModel,HYCounterViewModel>(
        selector: (ctx,countPro) => countPro,
        shouldRebuild: (prev,next) => false,
        builder: (ctx,countPro,child){
          print("floatingActionButton build方法被执行");
          return FloatingActionButton(
              child: child,
              onPressed: (){
                countPro.counter += 1;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class HYShowData01 extends StatelessWidget {
  const HYShowData01({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int counter = Provider.of<HYCounterViewModel>(context).counter;
    print("data01的build方法");

    return Container(
      color: Colors.blue,
      child: Text("当前计数器:$counter",style: TextStyle(fontSize: 30),),
    );
  }
}

class HYShowData2 extends StatelessWidget {
  const HYShowData2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("data02的build方法");

    return Container(
      color: Colors.red,
      child: Consumer<HYCounterViewModel>(
        builder: (ctx,countPro,child){
          print("data02 Consumer build方法被执行");
          return Text("当前计数器:${countPro.counter}",style: TextStyle(fontSize: 30),);
        },
      ),
    );
  }
}


