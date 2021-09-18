import 'package:bibili_flutter/core/hi_state.dart';
import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:bibili_flutter/util/toast.dart';
import 'package:flutter/material.dart';

///通用底层带分页和刷新的页面框架
///M为Dao返回数据模型，L为列表数据模型，T为具体widget
abstract class HiBaseTabState<M, L, T extends StatefulWidget> extends HiState<T>
    with AutomaticKeepAliveClientMixin {
  List<L> dataList = [];
  int pageIndex = 1;
  bool loading = false;
  ScrollController scrollController = ScrollController();

  get contentChild;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      var dis = scrollController.position.maxScrollExtent -
          scrollController.position.pixels;
      if (dis < 300 &&
          !loading &&
          //fix 当列表高度不满屏幕高度时不执行加载更多
          scrollController.position.maxScrollExtent != 0) {
        loadData(loadMore: true);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: primary,
      onRefresh: loadData,
      child: MediaQuery.removePadding(
          removeTop: true, context: context, child: contentChild),
    );
  }

  ///获取对应页码的数据
  Future<M> getData(int pageIndex);

  ///从MO中解析出list数据
  List<L> parseList(M result);

  Future<void> loadData({bool loadMore = false}) async {
    if (loading) {
      print("上次加载还没完成...");
      return;
    }

    loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    print("loading_currentIndex:$currentIndex");
    try {
      var result = await getData(currentIndex);
      setState(() {
        if (loadMore) {
          dataList = [...dataList, ...parseList(result)];
          if (parseList(result).isNotEmpty) {
            pageIndex++;
          }
        } else {
          dataList = parseList(result);
        }
      });
      Future.delayed(Duration(microseconds: 1000), () {
        loading = false;
      });
    } on NeedLogin catch (e) {
      loading = false;
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      loading = false;
      showWarnToast(e.message);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
