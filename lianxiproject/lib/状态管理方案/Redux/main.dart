import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'count_state.dart';

/**
 * 我们在Redux中，所有的状态都储存在Store里。这个Store会放在App顶层。
 * action 用于定义一个数据变化的请求。
 * reducer 用于根据 action 产生新状态
 * store 用于存储和管理 state，监听 action，将 action 自动分配给 reducer 并根据 reducer 的执行结果更新 state。

**/

main() {
  final store = Store<CountState>(reducer,initialState: CountState.initState());
  runApp(MyApp(store));
}
class MyApp extends StatelessWidget {
  final Store<CountState> store;
  MyApp(this.store);
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: "Flutter Redux Demo",
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Flutter Redux Demo"),
          ),
          body: HomeBody(),


          floatingActionButton: StoreConnector<CountState,VoidCallback>(
            converter: (store) {
              return () => store.dispatch(LZActions.Increment);
              },
            builder: (ctx,callback){
              return FloatingActionButton(
                onPressed: callback,
                child: Icon(Icons.add),
              );
            },
          ),
        ) ,
      ),
    );
  }
}
class HomeBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          //首先这里需要强制声明类型，S代表我们需要从store中获取什么类型的state，ViewModel指的是我们使用这个State时的实际类型。
          //converter<S,ViewModel>，它的作用是将Store转化成实际ViewModel将要使用的信息
          //builder是我们实际根据state创建Widget的地方，它接收一个上下文context，以及刚才我们转化出来的ViewMode

          StoreConnector<CountState,int>(
              converter: (store) => store.state.count,
              builder: (ctx,count){
                return Text(count.toString(),style: Theme.of(context).textTheme.headline3,);
          }),
        ],
      ),
    );
  }
}

