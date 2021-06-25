import 'package:flutter/material.dart';

class Mail extends StatefulWidget {
  const Mail({Key? key}) : super(key: key);

  @override
  _MailState createState() => _MailState();
}

class _MailState extends State<Mail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Center(
          child: Text("Mail",style: TextStyle(fontSize: 30),),
        )
    );
  }
}