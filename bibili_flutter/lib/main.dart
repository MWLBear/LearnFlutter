import 'package:bibili_flutter/db/hi_cache.dart';
import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/http/dao/login_dao.dart';
import 'package:bibili_flutter/model/video_model.dart';
import 'package:bibili_flutter/navigator/hi_navigator.dart';
import 'package:bibili_flutter/page/dark_mode_page.dart';
import 'package:bibili_flutter/page/login_page.dart';
import 'package:bibili_flutter/page/notice_page.dart';
import 'package:bibili_flutter/page/registration_page.dart';
import 'package:bibili_flutter/page/video_detail_page.dart';
import 'package:bibili_flutter/provider/hi_provider.dart';
import 'package:bibili_flutter/provider/them_provider.dart';
import 'package:bibili_flutter/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'http/core/hi_net.dart';
import 'navigator/bottom_navigator.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: _routeDelegate)
            : Scaffold(body: Center(child: CircularProgressIndicator()));
        return MultiProvider(
            providers: topProviders,
            child: Consumer<ThemProvider>(
              builder: (
                BuildContext context,
                ThemProvider themProvider,
                Widget? child,
              ) {
                return MaterialApp(
                  home: widget,
                  theme: themProvider.getTheme(),
                  darkTheme: themProvider.getTheme(isDarkMode: true),
                  themeMode: themProvider.getThemeMode(),
                );
              },
            ));
      },
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  //???Navigator????????????key??????????????????????????????navigatorKey.currentState????????????NavigatorState??????
  final GlobalKey<NavigatorState> navigatorKey;

  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus status, {Map? args}) {
      _routeStatus = status;
      if (routeStatus == RouteStatus.detail) {
        this.videoModel = args!["videoMo"];
      }
      notifyListeners();
    }));

    HiNet.getInstance().setErrorInterceptor((error) {
      if (error is NeedLogin) {
        //???????????????????????????
        HiCache.getInstance().remove(LoginDao.BOARDING_PASS);
        //????????????
        HiNavigator.getInstance().onJump(RouteStatus.login);
      }
    });
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> temPages = pages;
    if (index != -1) {
      //?????????????????????????????????????????????????????????????????????????????????????????????
      temPages = temPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //???????????????????????????????????????????????????????????????????????????
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.darkMode) {
      page = pageWrap(DarkModePage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    } else if (routeStatus == RouteStatus.notice) {
      page = pageWrap(NoticePage());
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel!));
    }
    temPages = [...temPages, page];
    //????????????????????????
    HiNavigator.getInstance().notify(temPages, pages);
    pages = temPages;

    return WillPopScope(
      onWillPop: () async =>
          !(await navigatorKey.currentState?.maybePop() ?? false),
      child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            print("onPopPage: $route,$result");
            if (route.settings is MaterialPage) {
              //??????????????????????????????
              if ((route.settings as MaterialPage).child is LoginPage) {
                if (!hasLogin) {
                  showWarnToast("????????????");
                  return false;
                }
              }
            }
            //??????????????????
            if (!route.didPop(result)) {
              return false;
            }
            var tempPages = [...pages];
            pages.removeLast();

            HiNavigator.getInstance().notify(pages, tempPages);

            //????????????????????????
            return true;
          }),
    );
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;
  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {}
}

///?????????????????? ,path
class BiliRoutePath {
  final String location;
  BiliRoutePath.home() : location = "/";
  BiliRoutePath.detail() : location = "detail";
}
