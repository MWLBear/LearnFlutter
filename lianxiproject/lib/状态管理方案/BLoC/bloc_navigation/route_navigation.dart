import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*
* 在这个例子中，我们将看看如何使用 BlocListener 导航到特定页面（小部件）
* 以响应使用路由的 bloc 中的状态更改*/
void main(){
  runApp(
    BlocProvider(
      create: (ctx)=> MyBloc(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (ctx)=>PageA(),
        "/pageB": (ctx)=>PageB(),
      },
      initialRoute: "/",
    );
  }
}

class PageA extends StatelessWidget {
  const PageA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //我们使用 BlocListener 小部件来推送新路由以响应 MyBloc 中的状态更改
    return BlocListener<MyBloc,MyState>(
      listener: (ctx,state){
        if(state is MyStateB){
          print("监听到改变");
          Navigator.of(context).pushNamed("/pageB");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Page A"),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Go to PagB"),
            onPressed: (){
              print("点击");
              BlocProvider.of<MyBloc>(context).add(MyEvent.eventB);
            },
          ),
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
        title: Text("Page B"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Pop'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}


enum MyEvent {eventA, eventB}

@immutable
abstract class MyState{ }

class MyStateA extends MyState {}
class MyStateB extends MyState {}

class MyBloc extends Bloc<MyEvent,MyState>{

  MyBloc():super(MyStateA());

  @override
  Stream<MyState> mapEventToState(MyEvent event) async*{
    switch(event){
      case MyEvent.eventA:
        yield MyStateA();
        break;
      case MyEvent.eventB:
        yield MyStateB();
        break;
    }
  }
}
