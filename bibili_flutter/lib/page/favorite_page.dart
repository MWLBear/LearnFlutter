import 'package:bibili_flutter/core/hi_base_tab_state.dart';
import 'package:bibili_flutter/http/dao/favorite_dao.dart';
import 'package:bibili_flutter/model/ranking_mo.dart';
import 'package:bibili_flutter/model/video_model.dart';
import 'package:bibili_flutter/navigator/hi_navigator.dart';
import 'package:bibili_flutter/page/video_detail_page.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:bibili_flutter/widget/navigation_bar.dart';
import 'package:bibili_flutter/widget/video_large_card.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState
    extends HiBaseTabState<RankingMo, VideoModel, FavoritePage> {
  late RouteChangeListener listener;

  @override
  void initState() {
    super.initState();

    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      if (pre?.page is VideoDetailPage && current.page is FavoritePage) {
        loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNavigationBar(),
        Expanded(child: super.build(context)),
      ],
    );
  }

  @override
  get contentChild => ListView.builder(
        padding: EdgeInsets.only(top: 10),
        itemCount: dataList.length,
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (ctx, index) {
          return VideoLargeCard(videoModel: dataList[index]);
        },
      );

  @override
  Future<RankingMo> getData(int pageIndex) async {
    RankingMo result =
        await FavoriteDao.favoriteList(pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(RankingMo result) {
    return result.list;
  }

  _buildNavigationBar() {
    return NavigationBar(
      child: Container(
        decoration: bottomBoxShadow(),
        alignment: Alignment.center,
        child: Text(
          "收藏",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
