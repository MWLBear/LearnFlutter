import 'dart:io';

import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/http/dao/favorite_dao.dart';
import 'package:bibili_flutter/http/dao/like_dao.dart';
import 'package:bibili_flutter/http/dao/video_detail_dao.dart';
import 'package:bibili_flutter/model/video_detail_mo.dart';
import 'package:bibili_flutter/model/video_model.dart';
import 'package:bibili_flutter/util/toast.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:bibili_flutter/widget/appbar.dart';
import 'package:bibili_flutter/widget/expandable_content.dart';
import 'package:bibili_flutter/widget/hi_tab.dart';
import 'package:bibili_flutter/widget/navigation_bar.dart';
import 'package:bibili_flutter/widget/video_header.dart';
import 'package:bibili_flutter/widget/video_large_card.dart';
import 'package:bibili_flutter/widget/video_tool_bar.dart';
import 'package:bibili_flutter/widget/video_view.dart';
import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage(this.videoModel);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  late TabController _controller;
  List tabs = ["简介", "评论999"];
  VideoDetailMo? videoDetailMo;
  VideoModel? videoModel;
  List<VideoModel> videoList = [];

  @override
  void initState() {
    super.initState();
    //黑色状态栏，仅Android
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _controller = TabController(length: tabs.length, vsync: this);
    videoModel = widget.videoModel;
    _loadDetail();
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
          child: videoModel?.url != null
              ? Column(
                  children: [
                    NavigationBar(
                      //ios 黑色状态栏
                      color: Colors.black,
                      statusStyle: StatusStyle.LIGHT_CONTENT,
                      height: Platform.isAndroid ? 0 : 46,
                    ),
                    _buildVideoView(),
                    _buildTabNavigation(),
                    Flexible(
                        child: TabBarView(controller: _controller, children: [
                      _buildDetailList(),
                      Container(
                        child: Text("敬请期待"),
                      )
                    ])),
                  ],
                )
              : Container()),
    );
  }

  _buildVideoView() {
    var model = videoModel;
    return VideoView(
      model!.url!,
      cover: model.cover,
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

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [...buildContents(), ...buildVideoList()],
    );
  }

  buildContents() {
    return [
      VideoHeader(owner: videoModel!.owner),
      ExpandableContent(mo: videoModel!),
      VideoToolBar(
        detailMo: videoDetailMo,
        videoModel: videoModel!,
        onLike: _doLike,
        onUnlike: _doUnLike,
        onFavorite: _doFavorite,
        onShare: _doShare,
      )
    ];
  }

  void _loadDetail() async {
    try {
      VideoDetailMo result = await VideoDetailDao.get(videoModel!.vid);
      print(result);
      setState(() {
        videoDetailMo = result;
        //更新旧的数据
        videoModel = result.videoInfo;
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      print(e.message);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e.message);
    }
  }

  ///点赞
  _doLike() async {
    try {
      var result = await LikeDao.like(videoModel!.vid, !videoDetailMo!.isLike);
      print(result);
      showToast(result['msg']);
      videoDetailMo!.isLike = !videoDetailMo!.isLike;
      if (videoDetailMo!.isLike) {
        videoModel!.like += 1;
      } else {
        videoModel!.like -= 1;
      }
      setState(() {
        videoDetailMo = videoDetailMo;
        videoModel = videoModel;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  ///不喜欢
  _doUnLike() {
    print("不喜欢");
  }

  ///收藏
  _doFavorite() async {
    try {
      var result = await FavoriteDao.favorite(
          videoModel!.vid, !videoDetailMo!.isFavorite);
      print(result);
      showToast(result['msg']);
      videoDetailMo!.isFavorite = !videoDetailMo!.isFavorite;
      if (videoDetailMo!.isFavorite) {
        videoModel!.favorite += 1;
      } else {
        videoModel!.favorite -= 1;
      }
      setState(() {
        videoDetailMo = videoDetailMo;
        videoModel = videoModel;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void _doShare() {
    print("分享");
  }

  buildVideoList() {
    return videoList.map((mo) => VideoLargeCard(videoModel: mo)).toList();
  }
}
