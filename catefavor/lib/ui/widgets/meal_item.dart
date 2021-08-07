
import 'package:catefavor/core/viewmodel/favor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:catefavor/core/model/meal_model.dart';
import 'package:catefavor/ui/pages/detail/detail.dart';
import 'package:catefavor/core/extension/int_extension.dart';
import 'package:provider/provider.dart';
import 'operation_item.dart';

final cardRadius = 12.px;

class LZMealItem extends StatelessWidget {
  final LZMetalModel _metalModel;
  LZMealItem(this._metalModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(10.px),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardRadius)),
        elevation: 5,
        child: Column(
          children: [
            topWidget(context),
            bottomWidget(),
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed(LZDetailScreen.routeName,arguments: _metalModel);
      },
    );
  }

  Widget topWidget(BuildContext context) => Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(cardRadius),topRight: Radius.circular(cardRadius)),
        child: Image.network(_metalModel.imageUrl!, width: double.infinity, height: 250.px, fit: BoxFit.cover,),
      ),
      Positioned(
          right: 10.px,
          bottom: 10.px,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 5.px),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(6.px)
            ),
            width: 300.px,
            child: Text(_metalModel.title!,style: Theme.of(context).textTheme.headline3!.copyWith(
              color: Colors.white
            ),),
          )
      ),
    ],
  );

  Widget bottomWidget() => Padding(
    padding: EdgeInsets.all(4.px),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LZOperationItem(Icon(Icons.schedule), "${_metalModel.duration!}分钟"),
        LZOperationItem(Icon(Icons.restaurant), "${_metalModel.complexStr}"),
        getFavorItem(),
      ],
    ),
  );

  Widget getFavorItem() => Consumer<LZFavorViewModel>(
    builder: (ctx,mealVM,child){
      final iconData = mealVM.isFavorMeal(_metalModel) ? Icons.favorite: Icons.favorite_border;
      final iconColor = mealVM.isFavorMeal(_metalModel) ? Colors.red: Colors.black;
      final title = mealVM.isFavorMeal(_metalModel)? "收藏":"未收藏";
      return GestureDetector(
          child: LZOperationItem(
              Icon(iconData,color: iconColor,),
              title,titleColor: iconColor,
          ),
        onTap: (){
            print("点击了收藏");
            mealVM.handleMeal(_metalModel);
        },
      );
    },
  );
}
