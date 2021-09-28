import 'package:bibili_flutter/provider/them_provider.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModePage extends StatefulWidget {
  const DarkModePage({Key? key}) : super(key: key);

  @override
  _DarkModePageState createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  var _currentTheme;

  static const _ITEMS = [
    {"name": '跟随系统', "mode": ThemeMode.system},
    {"name": '开启', "mode": ThemeMode.dark},
    {"name": '关闭', "mode": ThemeMode.light},
  ];
  @override
  void initState() {
    super.initState();
    var themeMode = context.read<ThemProvider>().getThemeMode();
    _ITEMS.forEach((element) {
      if (element["mode"] == themeMode) {
        _currentTheme = element;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("夜间模式"),
      ),
      body: ListView.separated(
          itemBuilder: (ctx, index) {
            return _item(index);
          },
          separatorBuilder: (ctx, index) => Divider(),
          itemCount: _ITEMS.length),
    );
  }

  Widget _item(int index) {
    var theme = _ITEMS[index];
    return InkWell(
      onTap: () {
        _switch(index);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Text(theme['name'] as String),
            ),
            Opacity(
              opacity: _currentTheme == theme ? 1 : 0,
              child: Icon(
                Icons.done,
                color: primary,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _switch(int index) {
    var theme = _ITEMS[index];
    context.read<ThemProvider>().setTheme(theme['mode'] as ThemeMode);
    setState(() {
      _currentTheme = theme;
    });
  }
}
