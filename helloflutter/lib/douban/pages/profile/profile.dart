import 'dart:math';

import 'package:flutter/material.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> names = ['aaa', 'bbb', 'ccc'];

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }

  Widget getWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Key'),
      ),
      body: ListView(
        children: names.map((name) {
          return ListItemFul(name, key: ValueKey(name));
        }).toList(),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            names.removeAt(0);
          });
        },
      ),
    );
  }
}

class ListItemLess extends StatelessWidget {
  final String name;
  ListItemLess(this.name);
  final Color randomColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Text(name),
      color: randomColor,
    );
  }
}

class ListItemFul extends StatefulWidget {
  final String name;
  ListItemFul(this.name,{Key? key}): super(key: key);

  @override
  _ListItemFulState createState() => _ListItemFulState();
}

class _ListItemFulState extends State<ListItemFul> {
  final Color randomColor = Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256));
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Text(widget.name),
      color: randomColor,
    );
  }
}

// GlobalKey 使用测试
class HYHomePage extends StatelessWidget {
  final GlobalKey<_HYHomeContentState> homeKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("列表测试"),
      ),
      body: HYHomeContent(key: homeKey),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.data_usage),
        onPressed: () {
          print("${homeKey.currentState?.value}");
          print("${homeKey.currentState?.widget.name}");
          print("${homeKey.currentContext}");
        },
      ),
    );
  }
}

class HYHomeContent extends StatefulWidget {
  final String name = "123";

  HYHomeContent({Key? key}): super(key: key);

  @override
  _HYHomeContentState createState() => _HYHomeContentState();
}

class _HYHomeContentState extends State<HYHomeContent> {
  final String value = "abc";

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}