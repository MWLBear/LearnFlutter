import 'package:bibili_flutter/navigator/bottom_navigator.dart';
import 'package:bibili_flutter/page/dark_mode_page.dart';
import 'package:bibili_flutter/page/login_page.dart';
import 'package:bibili_flutter/page/notice_page.dart';
import 'package:bibili_flutter/page/registration_page.dart';
import 'package:bibili_flutter/page/video_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo? pre);

///创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child), child: child);
}

///获取routeState在页面中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    if (getStatus(pages[i]) == routeStatus) {
      return i;
    }
  }
  return -1;
}

///自定义路由封装 路由状态
enum RouteStatus {
  login,
  registration,
  home,
  detail,
  unknown,
  notice,
  darkMode
}

///获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page is DarkModePage) {
    return RouteStatus.darkMode;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is NoticePage) {
    return RouteStatus.notice;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknown;
  }
}

///路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

///监听路由页面跳转
///感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener {
  static HiNavigator? _instance;

  RouteJumpListener? _routeJump;
  List<RouteChangeListener> _listeners = [];

  ///本地路由信息
  RouteStatusInfo? _current;

  ///首页底部tab
  RouteStatusInfo? _bottomTab;

  HiNavigator._();

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance!;
  }

  RouteStatusInfo? getCurrent() {
    return _current;
  }

  Future<bool> openH5(String url) async {
    var result = await canLaunch(url);
    print("result:$result");
    if (result) {
      return await launch(url);
    } else {
      return Future.value(false);
    }
  }

  ///首页底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  ///注册路由调转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  /// 监听路由页面的跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  /// 移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  //通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      current = _bottomTab!;
    }

    print("hi_navigator: current:${current.page}");
    print("hi_navigator: pre:${_current?.page}");

    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }

  ///通知路由变化
  @override
  void onJump(RouteStatus status, {Map? args}) {
    _routeJump?.onJumpTo(status, args: args);
  }
}

///抽象类拱HiNavigator 实现
abstract class _RouteJumpListener {
  void onJump(RouteStatus status, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

///定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;
  RouteJumpListener({required this.onJumpTo});
}
