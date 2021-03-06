import 'package:catefavor/core/viewmodel/favor_view_model.dart';
import 'package:catefavor/ui/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LZFavorContent extends StatelessWidget {
  const LZFavorContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LZFavorViewModel>(
      builder: (ctx,favorVM,child){
        if(favorVM.meals.isEmpty){
          return Center(
            child: Text("ζζ ζΆθ",style: Theme.of(context).textTheme.headline3,),
          );
        }
        return ListView.builder(
          itemCount: favorVM.meals.length,
          itemBuilder: (itemCtx,index){
            return LZMealItem(favorVM.meals[index]);
          },
        );
      },
    );
  }
}
