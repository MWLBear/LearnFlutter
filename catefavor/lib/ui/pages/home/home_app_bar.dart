import 'package:flutter/material.dart';
class LZHomeAppBar extends AppBar{
  LZHomeAppBar(BuildContext context):super(
    title: Text("美食广场"),
    leading: IconButton(onPressed: (){
        Scaffold.of(context).openDrawer();
      }, icon: Icon(Icons.settings))
    );
}