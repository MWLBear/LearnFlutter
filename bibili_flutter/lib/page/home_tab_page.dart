import 'package:bibili_flutter/core/hi_base_tab_state.dart';
import 'package:bibili_flutter/http/dao/home_dao.dart';
import 'package:bibili_flutter/model/home_mo.dart';
import 'package:bibili_flutter/model/video_model.dart';
import 'package:bibili_flutter/widget/hi_banner.dart';
import 'package:bibili_flutter/widget/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo>? bannerList;
  const HomeTabPage({Key? key, required this.categoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState
    extends HiBaseTabState<HomeMo, VideoModel, HomeTabPage> {
  @override
  bool get wantKeepAlive => true;

  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: HiBanner(widget.bannerList!));
  }

  @override
  get contentChild => StaggeredGridView.countBuilder(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      itemCount: dataList.length,
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        if (widget.bannerList != null && index == 0) {
          return Padding(padding: EdgeInsets.only(bottom: 8), child: _banner());
        } else {
          return VideoCard(videoModel: dataList[index]);
        }
      },
      staggeredTileBuilder: (index) {
        if (widget.bannerList != null && index == 0) {
          return StaggeredTile.fit(2);
        } else {
          return StaggeredTile.fit(1);
        }
      });

  @override
  Future<HomeMo> getData(int pageIndex) async {
    HomeMo mo = await HomeDao.get(widget.categoryName,
        pageIndex: pageIndex, pageSize: 10);
    return mo;
  }

  @override
  List<VideoModel> parseList(HomeMo result) {
    return result.videoList;
  }
}
