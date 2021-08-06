import 'package:flutter/material.dart';
import 'filter_content.dart';
class LZFilterScreen extends StatelessWidget {
  static const String routeName = "filter";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("过滤美食"),
      ),
      body: LZFilterContent() ,
    );
  }
}
