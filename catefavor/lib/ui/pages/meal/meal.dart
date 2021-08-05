import 'package:flutter/material.dart';
import 'package:catefavor/core/model/category_model.dart';
import 'meal_content.dart';
class LZMealScreen extends StatelessWidget {
  static const String routeName = "meal";
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as LZCategoryModel;

    return Scaffold(
      appBar: AppBar(
        title:
        Text(category.title),
      ),
      body: LZMealContent(),
    );
  }
}
