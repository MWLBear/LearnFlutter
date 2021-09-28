import 'package:bibili_flutter/provider/them_provider.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///可自定义样式的沉浸式导航栏

class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  const NavigationBar({
    Key? key,
    this.statusStyle = StatusStyle.DARK_CONTENT,
    this.color = Colors.white,
    this.height = 46,
    this.child,
  }) : super(key: key);
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  var _statusStyle;
  var _color;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemProvider>();
    if (themeProvider.isDark()) {
      _color = HiColor.dark_bg;
      _statusStyle = StatusStyle.LIGHT_CONTENT;
    } else {
      _color = widget.color;
      _statusStyle = widget.statusStyle;
    }
    _statusInit();

    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
    );
  }

  void _statusInit() {
    changeStatusBar(color: _color, statusStyle: _statusStyle);
  }
}
