import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/http/dao/home_dao.dart';
import 'package:bibili_flutter/model/home_mo.dart';
import 'package:bibili_flutter/model/video_model.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:bibili_flutter/util/toast.dart';
import 'package:bibili_flutter/widget/hi_banner.dart';
import 'package:bibili_flutter/widget/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo>? bannerList;
  const HomeTabPage({Key? key, required this.categoryName,this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> with AutomaticKeepAliveClientMixin{
  List<VideoModel>videoList = [];
  int pageIndex = 1;
  bool _loading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState(){
    print("list:${widget.bannerList}");
    super.initState();
    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
      if(dis < 300 && !_loading){
        _loadData(loadMore:true);
      }
    });
    _loadData();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      color: primary,
      onRefresh: _loadData,
      child: MediaQuery.removePadding(
        removeTop: true,
          context: context,
          child: StaggeredGridView.countBuilder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 10,left: 10,right: 10),
              itemCount: videoList.length,
              crossAxisCount: 2,
              itemBuilder: (context,index){
                if(widget.bannerList != null && index == 0){
                  return Padding(padding: EdgeInsets.only(bottom: 8),child: _banner());
                }else{
                  return VideoCard(videoModel: videoList[index]);
                }
          }, staggeredTileBuilder: (index){
              if(widget.bannerList!= null && index == 0){
                return StaggeredTile.fit(2);
              }else{
                return StaggeredTile.fit(1);
              }
          })
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _loadData({bool loadMore = false}) async{
    _loading = true;
    if(!loadMore){
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore? 1: 0);
    print("loading_currentIndex:$currentIndex");
    try{
      HomeMo result = await HomeDao.get(widget.categoryName,pageIndex: currentIndex,pageSize: 10);
      setState(() {
        if(loadMore){
          if(videoList.isNotEmpty){
            ///合成一个新数组
            videoList = [...videoList,...result.videoList];
            pageIndex++;
          }
        }else{
          videoList = result.videoList;
        }
      });
      Future.delayed(Duration(microseconds: 1000),(){
        _loading = false;
      });
    }on NeedLogin catch(e){
      _loading = false;
      showWarnToast(e.message);
    }on HiNetError catch(e){
      _loading = false;
      showWarnToast(e.message);
    }
  }

  _banner() {
    return Padding(padding: EdgeInsets.only(left: 5,right: 5),child: HiBanner(widget.bannerList!));

  }



}
