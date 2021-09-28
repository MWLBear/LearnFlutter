import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/http/dao/profile_dao.dart';
import 'package:bibili_flutter/model/profile_mo.dart';
import 'package:bibili_flutter/provider/them_provider.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:bibili_flutter/util/toast.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:bibili_flutter/widget/benefit_card.dart';
import 'package:bibili_flutter/widget/course_card.dart';
import 'package:bibili_flutter/widget/dark_model_item.dart';
import 'package:bibili_flutter/widget/hi_banner.dart';
import 'package:bibili_flutter/widget/hi_blur.dart';
import 'package:bibili_flutter/widget/hi_flexible_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  ProfileMo? _profileMo;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [_buildAppBar()];
        },
        body: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [..._buildContentList()],
        ),
      ),
    );
  }

  void _loadData() async {
    try {
      ProfileMo result = await ProfileDao.get();
      print(result);
      setState(() {
        _profileMo = result;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  _buildAppBar() {
    var themeProvider = context.watch<ThemProvider>();
    return SliverAppBar(
      centerTitle: true,
      expandedHeight: 160,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(
                child: cachedImage(
                    "https://www.devio.org/img/beauty_camera/beauty_camera4.jpg")),
            Positioned.fill(
                child: HiBlur(
              color: themeProvider.isDark() ? Colors.black54 : Colors.white10,
              sigma: 20,
            )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildProfileTab(themeProvider),
            )
          ],
        ),
      ),
    );
  }

  _buildContentList() {
    if (_profileMo == null) return [];
    return [
      _buildBanner(),
      CourseCard(courseList: _profileMo!.courseList),
      BenefitCard(benefitList: _profileMo!.benefitList),
      DarkModelItem(),
    ];
  }

  _buildHead() {
    if (_profileMo == null) return Container();
    return HiFlexibleHeader(
      controller: _controller,
      face: _profileMo!.face,
      name: _profileMo!.name,
    );
  }

  _buildProfileTab(ThemProvider themeProvider) {
    if (_profileMo == null) return Container();
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: themeProvider.isDark() ? HiColor.dark_bg : Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText("收藏", _profileMo!.favorite, themeProvider),
          _buildIconText("点赞", _profileMo!.like, themeProvider),
          _buildIconText("浏览", _profileMo!.browsing, themeProvider),
          _buildIconText("金币", _profileMo!.coin, themeProvider),
          _buildIconText("粉丝", _profileMo!.fans, themeProvider),
        ],
      ),
    );
  }

  _buildIconText(String text, int count, ThemProvider themeProvider) {
    return Column(
      children: [
        Text('$count',
            style: TextStyle(
                fontSize: 15,
                color: themeProvider.isDark() ? Colors.white : Colors.black87)),
        Text(text,
            style: TextStyle(
                fontSize: 12,
                color: themeProvider.isDark()
                    ? Colors.white70
                    : Colors.grey[600])),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  _buildBanner() {
    return HiBanner(
      _profileMo!.bannerList,
      bannerHeight: 120,
      padding: EdgeInsets.only(left: 10, right: 10),
    );
  }
}
