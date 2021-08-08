
import 'package:catefavor/core/user_default/use_default.dart';
import 'package:catefavor/core/viewmodel/filter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:catefavor/core/extension/int_extension.dart';
import 'package:provider/provider.dart';

class LZFilterContent extends StatefulWidget {
  @override
  _LZFilterContentState createState() => _LZFilterContentState();
}

class _LZFilterContentState extends State<LZFilterContent> {
  bool _isGlutenFree = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          getTitleView(),
          getChoiceView(),
        ],
      )
    );
  }

  Widget getTitleView() => Container(
    padding: EdgeInsets.all(18.px),
    alignment: Alignment.center,
    child: Text("展示你的选择",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
  );

  Widget getChoiceView() => Expanded(
    child: Consumer<LZFilterViewModel>(
      builder: (ctx,filterVM,chile){
        return ListView(
          children: [
            buildListTitle("无谷蛋白", "无谷蛋白", filterVM.isGlutenFree, (value) {
              filterVM.isGlutenFree = value;
            }),
            buildListTitle("不含乳糖", "不含乳糖", filterVM.isLactoseFree, (value) {
              filterVM.isLactoseFree = value;
            }),
            buildListTitle("素食主义", "素食主义", filterVM.isVegetarian, (value) {
              filterVM.isVegetarian = value;
            }),
            buildListTitle("严格素食主义", "严格素食主义", filterVM.isVegan, (value) {
              filterVM.isVegan = value;
            }),
          ],
        );
      },
    ),
  );

  Widget buildListTitle(String title,String subtitle,bool value, Function(bool) change){
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(value: value, onChanged: change),
    );
  }
}
