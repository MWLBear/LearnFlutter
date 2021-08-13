import 'package:flutter/material.dart';
class BottomNoMore extends StatelessWidget {
  const BottomNoMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("没有更多数据了"),
        ],
      ),
    );
  }
}
