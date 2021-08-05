import 'package:catefavor/core/model/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:catefavor/core/model/category_model.dart';
import 'package:catefavor/core/viewmodel/meal_view_model.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:catefavor/ui/widgets/meal_item.dart';

class LZMealContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as LZCategoryModel;

    return Selector<LZMealViewModel,List<LZMetalModel>>(
      selector: (ctx,melaVM) => melaVM.meals.where((element) => element.categories!.contains(category.id)).toList(),
      shouldRebuild: (pre,next) => !ListEquality().equals(pre, next),
      builder: (ctx,meals,child){
        return ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx,index) {
            return LZMealItem(meals[index]);
          },
        );
      },
    );
  }
}
