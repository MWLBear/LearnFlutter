import 'package:flutter/material.dart';

import 'package:catefavor/core/model/meal_model.dart';

class LZDetailScreen extends StatelessWidget {
  static const String routeName = "detail";
  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as LZMetalModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title!),
      ),
      body: Center(child: Text(model.title!),),
    );
  }
}
