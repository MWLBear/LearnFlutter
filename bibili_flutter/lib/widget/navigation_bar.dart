import 'package:bibili_flutter/util/view_until.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
    _statusInit();
  }

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: widget.color),
    );
  }

  void _statusInit() {
    changeStatusBar(color: widget.color, statusStyle: widget.statusStyle);
  }
}
