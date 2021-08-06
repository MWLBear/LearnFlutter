import 'package:catefavor/ui/pages/favor/favor_content.dart';
import 'package:flutter/material.dart';
class LZFavorScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏"),
      ),
      body: Center(
        child: LZFavorContent(),
      ),
    );
  }
}
