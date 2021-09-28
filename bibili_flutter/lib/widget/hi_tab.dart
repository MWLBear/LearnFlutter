import 'package:bibili_flutter/provider/them_provider.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:underline_indicator/underline_indicator.dart';

///顶部tab切换组件
class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unselectedLabelColor;

  const HiTab(this.tabs,
      {Key? key,
      this.controller,
      this.fontSize = 13,
      this.borderWidth = 3,
      this.insets = 15,
      this.unselectedLabelColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemProvider>();
    var _unselectedLabelColor =
        themeProvider.isDark() ? Colors.white70 : unselectedLabelColor;
    return TabBar(
        isScrollable: true,
        controller: controller,
        labelColor: primary,
        unselectedLabelColor: _unselectedLabelColor,
        labelStyle: TextStyle(fontSize: fontSize),
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.square,
            borderSide: BorderSide(width: borderWidth, color: primary),
            insets: EdgeInsets.only(left: insets, right: insets)),
        tabs: tabs);
    ;
  }
}
