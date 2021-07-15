import 'package:flutter/material.dart';
import 'package:helloflutter/%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'viewmodel/counter_view_model.dart';
import 'viewmodel/intialize_providers.dart';

void main() {
  runApp(MultiProvider(
    providers: providers,
    child: MyApp(),
  ));
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
        title: Text("列表测试"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HYShowData01(),
            HYShowData2(),
            HYShowData3(),
            HYShowData4()
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


class HYShowData3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Consumer<HYUserViewModel>(
        builder: (ctx,userVM,child){
          return Text("nickname: ${userVM.user.nickname}",style: TextStyle(fontSize: 30),);
        },
      ),
    );
  }
}
class HYShowData4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Consumer2<HYCounterViewModel,HYUserViewModel>(
        builder: (ctx,counterVM,userVM,child){
          return Text("nickname: ${userVM.user.nickname} counter:${counterVM.counter}",style: TextStyle(fontSize: 30),);
        },
      ),
    );
  }
}
