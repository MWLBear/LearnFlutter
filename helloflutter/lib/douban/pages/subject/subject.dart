import 'package:flutter/material.dart';

class Subject extends StatefulWidget {
  const Subject({Key? key}) : super(key: key);

  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Center(
          child: Text("Subject",style: TextStyle(fontSize: 30,color: Colors.green),),
        )
    );
  }
}