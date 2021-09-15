import 'dart:io';

import 'package:bibili_flutter/model/video_model.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:bibili_flutter/widget/appbar.dart';
import 'package:bibili_flutter/widget/hi_tab.dart';
import 'package:bibili_flutter/widget/navigation_bar.dart';
import 'package:bibili_flutter/widget/video_view.dart';
import 'package:flutter/material.dart';

class VideoDetail extends StatefulWidget {
  final VideoModel model;

  const VideoDetail(this.model);

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail>
    with TickerProviderStateMixin {
  late TabController _controller;
  List tabs = ["简介", "评论999"];
  @override
  void initState() {
    super.initState();
    //黑色状态栏，仅Android
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
          removeTop: Platform.isIOS,
          context: context,
          child: Column(
            children: [
              NavigationBar(
                color: Colors.black,
                statusStyle: StatusStyle.LIGHT_CONTENT,
                height: Platform.isAndroid ? 0 : 46,
              ),
              _buildVideoView(),
              _buildTabNavigation(),
            ],
          )),
    );
  }

  _buildVideoView() {
    return VideoView(
      widget.model.url!,
      cover: widget.model.cover,
      overlyUI: videoAppBar(),
    );
  }

  _buildTabNavigation() {
    //使用Material实现阴影效果
    return Material(
      elevation: 10,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map((tab) {
        return Tab(text: tab);
      }).toList(),
      controller: _controller,
    );
  }
}
