import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'top_screen.dart';
import 'count_model.dart';

void main() {
  runApp(MyApp(
    model: CounterModel(),
  ));
}

class MyApp extends StatelessWidget {
  final CounterModel model;

  const MyApp({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    InheritedWidget;
    return ScopedModel<CounterModel>(
      model: model,
      child: MaterialApp(
        title: 'Scoped Model Demo',
        home: TopScreen(),
      ),
    );
  }
}


