import 'package:bibili_flutter/model/home_mo.dart';
import 'package:bibili_flutter/model/video_model.dart';
import 'package:bibili_flutter/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;

  const HiBanner(this.bannerList,
      {Key? key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
      itemCount: bannerList.length,
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 8)),
    );
  }

  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
        print(bannerMo.title);
        handelBannerClick(bannerMo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            child: Image.network(bannerMo.cover, fit: BoxFit.cover)),
      ),
    );
  }

  void handelBannerClick(BannerMo mo) {
    if (mo.type == 'video') {
      HiNavigator.getInstance().onJump(RouteStatus.detail,
          args: {"videoMo": VideoModel(vid: mo.url)});
    } else {
      print("type:${mo.type},url:${mo.url}");
    }
  }
}
