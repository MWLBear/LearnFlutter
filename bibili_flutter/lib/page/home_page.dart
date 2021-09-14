import 'package:bibili_flutter/navigator/hi_navigator.dart';
import 'package:bibili_flutter/page/home_tab_page.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  late TabController _controller;
  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片·手书·配音"];

  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('home:current:${current.page}');
      print('home:pre:${pre.page}');
      if (widget == current.page || current.page is HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: _tabBar(),
            ),
            Flexible(
              child: TabBarView(
                controller: _controller,
                children: tabs.map((tab) {
                  return HomeTabPage(name: tab);
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return TabBar(
      isScrollable: true,
      controller: _controller,
      labelColor: Colors.black,
      indicator: UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(width: 3, color: primary),
          insets: EdgeInsets.only(left: 15, right: 15)),
      tabs: tabs.map((tab) {
        return Tab(
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              tab,
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      }).toList(),
    );
  }
}
