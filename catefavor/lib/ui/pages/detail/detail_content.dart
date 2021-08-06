import 'package:flutter/material.dart';
import 'package:catefavor/core/model/meal_model.dart';
import 'package:catefavor/core/extension/int_extension.dart';

class LZDetailContent extends StatelessWidget {
  final LZMetalModel _model;
  LZDetailContent(this._model);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          topImageView(),
          makeTitle(context, "制作材料"),
          middleMakeMaterial(context),
          makeTitle(context, "制作步骤"),
          bottomMakeSteps(context),
        ],
      ),
    );
  }

  Widget topImageView() =>  Container(
    width: double.infinity,
    child: Image.network(_model.imageUrl!),
  );

  Widget middleMakeMaterial(BuildContext context) {
   return makeContainerView(
       context: context,
       child: ListView.builder(
         shrinkWrap:true,
         physics: NeverScrollableScrollPhysics(),
         padding:EdgeInsets.zero,
         itemCount: _model.ingredients?.length,
         itemBuilder: (ctx,index){
           return Card(
             color: Theme.of(context).accentColor,
             child: Padding(
             padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
             child: Text(_model.ingredients![index])
         ),
       );
     },
   )) ;
  }

  Widget bottomMakeSteps(BuildContext context) {
    return makeContainerView(
        context: context,
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: _model.steps!.length,
          itemBuilder: (ctx,index){
            return ListTile(
              leading: CircleAvatar(
                child: Text("#${index+1}"),
              ),
              title: Text(_model.steps![index]),
            );
          },
          separatorBuilder: (ctx ,index){
            return Divider();
          },
        )
    );
  }


  Widget makeTitle(BuildContext context, String title) => Container(
    padding: EdgeInsets.symmetric(vertical: 6.px),
    child: Text(title,style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight:FontWeight.bold),),
  );

  Widget makeContainerView({required BuildContext context,required Widget child}){
   return Container(
       padding: EdgeInsets.all(8.px),
       decoration: BoxDecoration(
           color: Colors.white,
           border: Border.all(color: Colors.grey),
           borderRadius: BorderRadius.circular(8.px)
       ),
       width: MediaQuery.of(context).size.width - 30.px,
       child:child
   );
  }

}
