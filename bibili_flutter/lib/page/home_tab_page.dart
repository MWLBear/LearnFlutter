import 'package:flutter/material.dart';

class HomeTabPage extends StatelessWidget {
  final String name;

  const HomeTabPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(name),
    );
  }
}
