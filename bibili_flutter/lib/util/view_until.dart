import 'dart:io';

import 'package:bibili_flutter/navigator/hi_navigator.dart';
import 'package:bibili_flutter/page/profile_page.dart';
import 'package:bibili_flutter/page/video_detail_page.dart';
import 'package:bibili_flutter/provider/them_provider.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:bibili_flutter/util/format_until.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

///带缓存的image
Widget cachedImage(String url, {double? width, double? height}) {
  return CachedNetworkImage(
    fit: BoxFit.cover,
    height: height,
    width: width,
    imageUrl: url,
    placeholder: (BuildContext context, String url) =>
        Container(color: Colors.grey[200]),
    errorWidget: (BuildContext context, String url, dynamic error) =>
        Icon(Icons.error),
  );
}

///黑色线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent
      ]);
}

///修改状态栏
void changeStatusBar(
    {color: Colors.white,
    StatusStyle statusStyle: StatusStyle.DARK_CONTENT,
    BuildContext? context}) {
  if (context != null) {
    var themeProvider = Provider.of<ThemProvider>(context, listen: false);
    if (themeProvider.isDark()) {
      statusStyle = StatusStyle.LIGHT_CONTENT;
      color = HiColor.dark_bg;
    }
  }
  var page = HiNavigator.getInstance().getCurrent()?.page;
  //fix Android切换 profile页面状态栏变白问题
  if (page is ProfilePage) {
    color = Colors.transparent;
  } else if (page is VideoDetailPage) {
    color = Colors.black;
    statusStyle = StatusStyle.LIGHT_CONTENT;
  }
  //沉浸式状态栏样式
  var brightness;
  if (Platform.isIOS) {
    brightness = statusStyle == StatusStyle.LIGHT_CONTENT
        ? Brightness.dark
        : Brightness.light;
  } else {
    brightness = statusStyle == StatusStyle.LIGHT_CONTENT
        ? Brightness.light
        : Brightness.dark;
  }
  //ios上 light:黑色图标 dark：白色图标
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness, //ios生效
      statusBarIconBrightness: brightness)); //android生效
}

///带文字的小图标
smallIconText(IconData iconData, var text) {
  var textStyle = TextStyle(fontSize: 12, color: Colors.grey);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(
      iconData,
      color: Colors.grey,
      size: 12,
    ),
    Text(
      '$text',
      style: textStyle,
    )
  ];
}

/// border线
bordLine(BuildContext context, {bottom: true, top: false}) {
  var themeProvider = context.watch<ThemProvider>();

  BorderSide slider = BorderSide(
      width: 0.5,
      color: themeProvider.isDark() ? Colors.grey[800]! : Colors.grey[200]!);
  return Border(
      bottom: bottom ? slider : BorderSide.none,
      top: top ? slider : BorderSide.none);
}

/// 间距
SizedBox hiSpace({double height: 1, double width: 1}) {
  return SizedBox(height: height, width: width);
}

/// 底部阴影
BoxDecoration? bottomBoxShadow(BuildContext context) {
  var themeProvider = context.watch<ThemProvider>();
  //暗黑模式下不要阴影效果
  if (themeProvider.isDark()) {
    return null;
  }
  return BoxDecoration(color: Colors.white, boxShadow: [
    BoxShadow(
        color: Colors.grey[100]!,
        offset: Offset(0, 5),
        blurRadius: 5.0, //阴影模糊程度
        spreadRadius: 1 //阴影的扩散程度
        )
  ]);
}
