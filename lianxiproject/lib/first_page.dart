import 'package:flutter/material.dart';
class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (ctx, index){
        return  Divider(height: 1.0, color: Colors.black12);
      },
      itemCount: 50,
      itemBuilder: (ctx,index){
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("$index",style: TextStyle(fontSize: 20),),
        );
      },
    );
  }
}
