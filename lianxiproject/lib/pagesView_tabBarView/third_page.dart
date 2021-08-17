import 'package:flutter/material.dart';

class ThirdPages extends StatefulWidget {
  const ThirdPages({Key? key}) : super(key: key);

  @override
  _ThirdPagesState createState() => _ThirdPagesState();
}

class _ThirdPagesState extends State<ThirdPages> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("third_page",style: TextStyle(fontSize: 20),),
    );
  }
}
