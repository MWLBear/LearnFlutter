import 'package:bibili_flutter/page/home_page.dart';
import 'package:bibili_flutter/page/login_page.dart';
import 'package:bibili_flutter/page/registration_page.dart';
import 'package:bibili_flutter/page/video_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
enum RouteStatus { login, registration, home, detail, unknown }

///获取page对应的RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is VideoDetail) {
    return RouteStatus.detail;
  } else {
    return RouteStatus.unknown;
  }
}

///路由信息
class RouteStatusInfo {}
