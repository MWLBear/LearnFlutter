import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  static const String routeName = "/detail";
  final String _message;
  Detail(this._message);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context).pop("a detail message");
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back_ios),
          //   onPressed: (){
          //     Navigator.of(context).pop("b detail message");
          //     print("点击了返回按钮");
          //   },
          // ),
          title: Text("详情页"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_message,style: TextStyle(color: Colors.red),),
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop("a detail message");
                },
                child: Text("返回首页"),
              ),
            ],
          )
        ),
      ),
    );
  }
}
