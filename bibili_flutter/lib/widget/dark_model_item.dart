import 'package:bibili_flutter/navigator/hi_navigator.dart';
import 'package:bibili_flutter/provider/them_provider.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModelItem extends StatelessWidget {
  const DarkModelItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemProvider>();
    var icon = themeProvider.isDark()
        ? Icons.nightlight_round
        : Icons.wb_sunny_rounded;

    return InkWell(
      onTap: () {
        HiNavigator.getInstance().onJump(RouteStatus.darkMode);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, bottom: 15),
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(border: bordLine(context)),
        child: Row(
          children: [
            Text("夜间模式",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.only(top: 2, left: 5),
              child: Icon(icon),
            )
          ],
        ),
      ),
    );
  }
}
