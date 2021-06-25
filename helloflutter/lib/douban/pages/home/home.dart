import 'package:flutter/material.dart';
import 'home_content.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        foregroundColor: Colors.green,
      ),
      body: HomeContent(),
    );
  }
}
