import 'package:flutter/material.dart';
import 'package:lianxiproject/%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86%E6%96%B9%E6%A1%88/Redux/redux02/first_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'redux_state.dart';
import 'user.dart';
import 'book.dart';

import 'package:flutter/material.dart';
main() {
  final store = Store<LZReduxState>(
      getReduce,
      initialState: LZReduxState(User.initData(),Book.initData())
  );
  runApp(MyApp(store));
}
class MyApp extends StatelessWidget {

  final Store<LZReduxState> store;
  MyApp(this.store);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<LZReduxState>(
      store: store,
      child:
           MaterialApp(
            title: "ReduxDemo",
            home: FirstPage(),
          ),
    );
  }
}

