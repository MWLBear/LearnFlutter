import 'package:catefavor/core/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:catefavor/core/extension/int_extension.dart';
import 'package:catefavor/core/model/category_model.dart';
import 'package:catefavor/ui/pages/meal/meal.dart';

class LZHomeCategoryItem extends StatelessWidget {
  final LZCategoryModel _category;
  LZHomeCategoryItem(this._category);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: _category.cColor,
            borderRadius: BorderRadius.circular(12.px),
            gradient: LinearGradient(
                colors: [
                  _category.cColor.withOpacity(0.5),
                  _category.cColor,
                ]
            )
        ),
        alignment: Alignment.center,
        child: Text(
          _category.title,
          style: Theme.of(context).textTheme.headline3!.copyWith(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed(LZMealScreen.routeName,arguments: _category);
      },
    );
  }
}
