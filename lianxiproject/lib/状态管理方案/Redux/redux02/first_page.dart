import "package:flutter/material.dart";
import 'package:lianxiproject/pagesView_tabBarView/second_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'redux_state.dart';
import 'package:lianxiproject/状态管理方案/Redux/redux02/next_page.dart';

class FirstPage extends StatefulWidget {
  static final String sName = "/";

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<LZReduxState>(builder: (ctx,store){
      return Scaffold(
        appBar: AppBar(
          title: Text("Redux"),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text("姓名是: "+ store.state.user.name),
              SizedBox(height: 50,),
              Text("书名是: "+ store.state.book.name),
              SizedBox(height: 100,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx){
                    return NextPage();
                  }
                ));
              }, child: Text("下一页"))

            ],
          ),
        ),
      );
    });
  }
}
