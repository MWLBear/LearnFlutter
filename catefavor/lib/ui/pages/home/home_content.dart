import 'package:catefavor/core/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:catefavor/core/services/json_parse.dart';
import 'package:catefavor/core/extension/double_extension.dart';
import 'package:catefavor/core/extension/int_extension.dart';

class LZHomeContent extends StatefulWidget {

  @override
  _LZHomeContentState createState() => _LZHomeContentState();
}

class _LZHomeContentState extends State<LZHomeContent> {

  List<LZCategoryModel> _categories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LZJsonParse.getCategoryData().then((value){
      setState(() {
        _categories = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(20.px),
        itemCount: _categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.px,
            mainAxisSpacing: 20.px,
            childAspectRatio: 1.5
        ),
        itemBuilder: (ctx ,index){
        final cColor = _categories[index].cColor!;
          return Container(
            decoration: BoxDecoration(
              color: cColor,
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  cColor.withOpacity(0.5),
                  cColor,
                ]
              )
            ),
            alignment: Alignment.center,
            child: Text(
              _categories[index].title!,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.bold
              ),
            ),
          );
        },
    );
  }
}
