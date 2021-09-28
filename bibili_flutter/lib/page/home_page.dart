import 'package:bibili_flutter/core/hi_state.dart';
import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/http/dao/home_dao.dart';
import 'package:bibili_flutter/model/home_mo.dart';
import 'package:bibili_flutter/navigator/hi_navigator.dart';
import 'package:bibili_flutter/page/home_tab_page.dart';
import 'package:bibili_flutter/page/profile_page.dart';
import 'package:bibili_flutter/page/video_detail_page.dart';
import 'package:bibili_flutter/provider/them_provider.dart';
import 'package:bibili_flutter/util/toast.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:bibili_flutter/widget/hi_tab.dart';
import 'package:bibili_flutter/widget/loading_container.dart';
import 'package:bibili_flutter/widget/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  var listener;
  late TabController _controller;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  bool _isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('home:current:${current.page}');
      print('home:pre:${pre.page}');
      if (widget == current.page || current.page is HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
      }

      //当页面返回到首页恢复首页的状态栏样式
      if (pre?.page is VideoDetailPage && !(current.page is ProfilePage)) {
        var statusStyle = StatusStyle.DARK_CONTENT;
        changeStatusBar(color: Colors.white, statusStyle: statusStyle);
      }
    });
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    HiNavigator.getInstance().removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  ///系统Dark Mode发生变化
  @override
  void didChangePlatformBrightness() {
    print("didChangePlatformBrightness");
    context.read<ThemProvider>().darkModeChange();
    super.didChangePlatformBrightness();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('didChangeAppLifecycleState:$state');
    switch (state) {
      case AppLifecycleState.inactive: //处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        //fix Android压后台首页状态栏字体颜色变白，详情页状态栏字体变黑问题
        changeStatusBar(context: context);
        break;
      case AppLifecycleState.paused: //APP进入后台
        break;
      case AppLifecycleState.detached: //App结束
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
          children: [
            NavigationBar(
              height: 50,
              child: _appBar(),
              color: Colors.white,
              statusStyle: StatusStyle.DARK_CONTENT,
            ),
            Container(
              decoration: bottomBoxShadow(context),
              child: _tabBar(),
            ),
            Flexible(
              child: TabBarView(
                controller: _controller,
                children: categoryList.map((categoryMo) {
                  return HomeTabPage(
                    categoryName: categoryMo.name,
                    bannerList: categoryMo.name == '推荐' ? bannerList : null,
                  );
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
    return HiTab(
      categoryList.map((tab) {
        return Tab(
          text: tab.name,
        );
      }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      insets: 13,
    );
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.get('推荐');
      print("loadData(): $result");
      if (result.categoryList != null) {
        _controller =
            TabController(length: result.categoryList!.length, vsync: this);
      }
      setState(() {
        categoryList = result.categoryList ?? [];
        bannerList = result.bannerList ?? [];
        _isLoading = false;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                width: 46,
                height: 46,
                image: AssetImage("lib/images/avatar.png"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(Icons.search, color: Colors.grey),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: context.watch<ThemProvider>().isDark()
                        ? Colors.grey[800]
                        : Colors.grey[100]),
              ),
            ),
          ),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          InkWell(
            onTap: () {
              HiNavigator.getInstance().onJump(RouteStatus.notice);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.mail_outline,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
