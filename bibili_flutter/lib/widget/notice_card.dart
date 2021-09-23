import 'package:bibili_flutter/model/home_mo.dart';
import 'package:bibili_flutter/util/format_until.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:flutter/material.dart';

import 'hi_banner.dart';

class NoticeCard extends StatelessWidget {
  final BannerMo mo;

  const NoticeCard({Key? key, required this.mo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handelBannerClick(mo);
      },
      child: Container(
        decoration: BoxDecoration(border: bordLine(context)),
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_buildIcon(), hiSpace(width: 10), _buildContents()],
        ),
      ),
    );
  }

  _buildIcon() {
    var iconData = mo.type == "video"
        ? Icons.ondemand_video_outlined
        : Icons.card_giftcard;
    return Icon(iconData, size: 30);
  }

  _buildContents() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(mo.title, style: TextStyle(fontSize: 16)),
              Text(dateMonthAndDay(mo.createTime)),
            ],
          ),
          hiSpace(height: 5),
          Text(mo.subtitle, maxLines: 1, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
