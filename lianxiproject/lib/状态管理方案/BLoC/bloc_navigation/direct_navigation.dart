import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


/*
* 在这个例子中，我们将看看如何使用 BlocBuilder
* 在不使用路由的情况下显示特定页面（小部件）以响应 bloc 中的状态更改。
* */
void main(){
  runApp(
    BlocProvider(
      create: (ctx) => MyBloc(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<MyBloc,MyState>(
        builder:(ctx,state){
          return state is StateA ? PageA() : PageB();
        },
      ),
    );
  }
}

class PageA extends StatelessWidget {
  const PageA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageA",)
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Go to Page B"),
          onPressed: (){
            BlocProvider.of<MyBloc>(context).add(MyEvent.eventB);
          },
        ),
      ),
    );
  }
}

class PageB extends StatelessWidget {
  const PageB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("PageB",)
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Go to Page A"),
          onPressed: (){
            BlocProvider.of<MyBloc>(context).add(MyEvent.eventA);
          },
        ),
      ),
    );
  }
}


enum MyEvent{ eventA, eventB}

@immutable
abstract class MyState {}

class StateA extends MyState {}
class StateB extends MyState {}

class MyBloc extends Bloc<MyEvent,MyState> {
  MyBloc() :super(StateA());

  @override
  Stream<MyState> mapEventToState(MyEvent event) async* {
    switch (event) {
      case MyEvent.eventA:
        yield StateA();
        break;
      case MyEvent.eventB:
        yield StateB();
        break;
    }
  }
}
