import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'count_model.dart';
import 'custom_home.dart';
class TopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CounterModel>(
        builder: (ctx,child,model){
          return Scaffold(
            appBar: AppBar(
              title: Text("top Screen"),
            ),
            body: Center(
              child: Text(
                model.counter.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx){
                    return CounterHome("Under Screen");
                  }
                ));
              },
              child: Icon(Icons.forward),
            ),
          );
        }) ;
  }
}
