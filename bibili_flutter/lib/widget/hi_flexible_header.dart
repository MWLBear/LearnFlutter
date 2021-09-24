import 'package:bibili_flutter/util/view_until.dart';
import 'package:flutter/material.dart';

class HiFlexibleHeader extends StatefulWidget {
  final String name;
  final String face;
  final ScrollController controller;

  const HiFlexibleHeader(
      {Key? key,
      required this.name,
      required this.face,
      required this.controller})
      : super(key: key);

  @override
  _HiFlexibleHeaderState createState() => _HiFlexibleHeaderState();
}

class _HiFlexibleHeaderState extends State<HiFlexibleHeader> {
  static const double MAX_BOTTOM = 40;
  static const double MIN_BOTTOM = 10;
  static const MAX_OFFSET = 80;
  double _dyBottom = MAX_BOTTOM;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      var offset = widget.controller.offset;
      print("offset: $offset");

      //算出padding变化系数0-1
      var dyOffset = (MAX_OFFSET - offset) / MAX_OFFSET;
      //根据dyOffset算出具体的变化的padding值
      var dy = dyOffset * (MAX_BOTTOM - MIN_BOTTOM);
      if (dy > (MAX_BOTTOM - MIN_BOTTOM)) {
        dy = MAX_BOTTOM - MIN_BOTTOM;
      } else if (dy < 0) {
        dy = 0;
      }
      setState(() {
        _dyBottom = dy + MIN_BOTTOM;
      });
      print('_dyBottom:$_dyBottom');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.only(bottom: _dyBottom, left: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: cachedImage(widget.face, width: 46, height: 46),
            ),
            hiSpace(width: 8),
            Text(widget.name, style: TextStyle(fontSize: 15))
          ],
        ));
  }
}
