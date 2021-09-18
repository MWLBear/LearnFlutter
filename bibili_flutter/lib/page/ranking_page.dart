import 'package:bibili_flutter/page/ranking_tab_page.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:bibili_flutter/widget/hi_tab.dart';
import 'package:bibili_flutter/widget/navigation_bar.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  late TabController _controller;
  static const TABS = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"}
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: TABS.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_buildNavigationBar(), _buildContent()],
      ),
    );
  }

  _buildNavigationBar() {
    return NavigationBar(
      child: Container(
        decoration: bottomBoxShadow(),
        alignment: Alignment.center,
        child: _tabBar(),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      TABS.map((e) {
        return Tab(text: e["name"]);
      }).toList(),
      controller: _controller,
      fontSize: 16,
      unselectedLabelColor: Colors.black54,
      borderWidth: 3,
    );
  }

  _buildContent() {
    return Flexible(
      child: TabBarView(
        children: TABS.map((e) {
          return RankingTabPage(sort: e["key"]!);
        }).toList(),
        controller: _controller,
      ),
    );
  }
}
