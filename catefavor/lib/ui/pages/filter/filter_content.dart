import 'package:flutter/material.dart';

class LZFilterContent extends StatelessWidget {
  const LZFilterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text("filter",style: TextStyle(fontSize: 30,color: Colors.red),)
      ),
    );
  }
}
