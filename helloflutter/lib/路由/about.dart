import 'package:flutter/material.dart';


class AboutPage extends StatelessWidget {
  static const String routeName = "/about";
  @override
  Widget build(BuildContext context) {
    final String _message = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text("关于页"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_message),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("返回首页"),
            ),
          ],
        ),
      ),
    );
  }
}
