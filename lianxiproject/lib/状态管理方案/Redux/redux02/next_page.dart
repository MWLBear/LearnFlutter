import "package:flutter/material.dart";
import 'package:lianxiproject/%E7%8A%B6%E6%80%81%E7%AE%A1%E7%90%86%E6%96%B9%E6%A1%88/Redux/redux02/user.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'redux_state.dart';
import 'user_reducer.dart';
import 'book_reducer.dart';
import 'user.dart';
import 'book.dart';


class NextPage extends StatefulWidget {

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<LZReduxState>(builder: (ctx,store){
      return Scaffold(
        appBar: AppBar(
          title: Text("第二页"),
        ),
        body: Center(
          child:
          Column(
            children: [
              SizedBox(height: 10,),
              Text(store.state.user.name),
              SizedBox(height: 10,),
              Text(store.state.book.name),
              SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: () {
                    store.dispatch(AddUserAction(User("孟德斯鸠")));
                  },
                  child: Text("添加用户")
              ),
              ElevatedButton(
                  onPressed: () {
                    store.dispatch(UpdateUserAction(User("张飞")));
                  },
                  child: Text("更新用户")
              ),
              ElevatedButton(
                  onPressed: () {
                    store.dispatch(AddBookAction(Book("五年高考,三年模拟")));
                  },
                  child: Text("添加书名")
              ),
              ElevatedButton(
                  onPressed: () {
                    store.dispatch(UpdateBookAction(Book("从入门到放弃")));
                  },
                  child: Text("更新书名")
              ),
            ],
          ),
        ),
      );
    });
  }
}
