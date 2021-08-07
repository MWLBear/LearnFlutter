import 'package:catefavor/core/viewmodel/favor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:catefavor/core/model/meal_model.dart';
import 'package:provider/provider.dart';
import 'detail_content.dart';

class LZDetailScreen extends StatelessWidget {
  static const String routeName = "detail";
  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as LZMetalModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title!),
      ),
      body: LZDetailContent(model),
      floatingActionButton: Consumer<LZFavorViewModel>(
        builder: (ctx,VMMeal,child){
          final iconData = VMMeal.isFavorMeal(model) ? Icons.favorite: Icons.favorite_border;
          final iconColor = VMMeal.isFavorMeal(model) ? Colors.red: Colors.black;
          return FloatingActionButton(
              child: Icon(iconData,color: iconColor,),
              onPressed: (){
                VMMeal.handleMeal(model);
              });
        },
      )
    );
  }
}
