import 'package:flutter/cupertino.dart';
import 'bottom_bar_item.dart';
import 'package:helloflutter/douban/pages/home/home.dart';
import 'package:helloflutter/douban/pages/group/group.dart';
import 'package:helloflutter/douban/pages/mail/mail.dart';
import 'package:helloflutter/douban/pages/profile/profile.dart';
import 'package:helloflutter/douban/pages/subject/subject.dart';

List<LZBottomBarItem> items = [
  LZBottomBarItem("home", "首页"),
  LZBottomBarItem("subject", "书影音"),
  LZBottomBarItem("group", "小组"),
  LZBottomBarItem("mall", "市集"),
  LZBottomBarItem("profile", "我的"),
];

List<Widget> pages = [
  Home(),
  Subject(),
  Group(),
  Mail(),
  Profile(),
];