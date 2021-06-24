import 'package:flutter/material.dart';
import 'package:helloflutter/douban/pages/home/home.dart';
import 'package:helloflutter/douban/pages/group/Group.dart';
import 'package:helloflutter/douban/pages/mail/Mail.dart';
import 'package:helloflutter/douban/pages/profile/Profile.dart';
import 'package:helloflutter/douban/pages/subject/Subject.dart';

import 'bottom_bar_item.dart';

class LZMainPage extends StatefulWidget {
  const LZMainPage({Key? key}) : super(key: key);

  @override
  _LZMainPageState createState() => _LZMainPageState();
}

class _LZMainPageState extends State<LZMainPage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Home(),
          Subject(),
          Group(),
          Mail(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 15,
        unselectedFontSize: 15,
        type: BottomNavigationBarType.fixed,
        items: [
          LZBottomBarItem("home", "首页"),
          LZBottomBarItem("subject", "书影音"),
          LZBottomBarItem("group", "小组"),
          LZBottomBarItem("mall", "市集"),
          LZBottomBarItem("profile", "我的"),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

