import 'package:bibili_flutter/core/hi_base_tab_state.dart';
import 'package:bibili_flutter/http/dao/notice_dao.dart';
import 'package:bibili_flutter/model/home_mo.dart';
import 'package:bibili_flutter/model/notice_mo.dart';
import 'package:bibili_flutter/widget/notice_card.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends HiBaseTabState<NoticeMo, BannerMo, NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(title: Text("通知")),
          Expanded(child: super.build(context)),
        ],
      ),
    );
  }

  @override
  // TODO: implement contentChild
  get contentChild => ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: 10),
        itemCount: dataList.length,
        controller: scrollController,
        itemBuilder: (ctx, index) {
          return NoticeCard(mo: dataList[index]);
        },
      );

  @override
  Future<NoticeMo> getData(int pageIndex) async {
    NoticeMo result =
        await NoticeDao.noticeList(pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<BannerMo> parseList(NoticeMo result) {
    return result.list;
  }
}
