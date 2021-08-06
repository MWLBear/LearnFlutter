import 'package:flutter/material.dart';
import 'package:catefavor/core/extension/int_extension.dart';
import 'package:catefavor/ui/pages/filter/filter.dart';

class LZHomeDarwer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Drawer(
        child: Column(
          children: [
            getHeadView,
            buildListTile(context, Icon(Icons.restaurant), "进餐", () {
              Navigator.of(context).pop();
            }),
            buildListTile(context, Icon(Icons.settings), "过滤", () {
              Navigator.of(context).pushNamed(LZFilterScreen.routeName);
            }),
          ],
        ),
      ),
    );
  }
  Widget getHeadView = Container(
    alignment: Alignment(0,0.5),
    color: Colors.orange,
    width: double.infinity,
    height: 120.px,
    margin: EdgeInsets.only(bottom: 20.px),
    child: Text("开始动手",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
  );


  Widget buildListTile(BuildContext context, Widget icon, String title, VoidCallback handler) {
    return ListTile(
      trailing: Icon(Icons.arrow_forward_ios),
      leading: icon,
      title: Text(title, style: Theme.of(context).textTheme.headline2,),
      onTap: handler,
    );
  }

}
