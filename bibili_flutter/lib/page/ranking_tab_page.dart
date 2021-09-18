import 'package:bibili_flutter/core/hi_base_tab_state.dart';
import 'package:bibili_flutter/http/dao/ranking_dao.dart';
import 'package:bibili_flutter/model/ranking_mo.dart';
import 'package:bibili_flutter/model/video_model.dart';
import 'package:bibili_flutter/widget/video_large_card.dart';
import 'package:flutter/material.dart';

class RankingTabPage extends StatefulWidget {
  final String sort;
  const RankingTabPage({Key? key, required this.sort}) : super(key: key);

  @override
  _RankingTabPageState createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends HiBaseTabState<RankingMo, VideoModel, RankingTabPage> {
  @override
  // TODO: implement contentChild
  get contentChild => Container(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 10),
          itemCount: dataList.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            return VideoLargeCard(videoModel: dataList[index]);
          },
        ),
      );

  @override
  Future<RankingMo> getData(int pageIndex) async {
    RankingMo result =
        await RankingDao.get(widget.sort, pageIndex: pageIndex, pageSize: 20);
    return result;
  }

  @override
  List<VideoModel> parseList(RankingMo result) {
    return result.list;
  }
}
