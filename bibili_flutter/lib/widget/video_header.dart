import 'package:bibili_flutter/model/owner.dart';
import 'package:bibili_flutter/util/color.dart';
import 'package:bibili_flutter/util/format_until.dart';
import 'package:flutter/material.dart';

class VideoHeader extends StatelessWidget {
  final Owner owner;
  const VideoHeader({Key? key, required this.owner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(owner.face, width: 30, height: 30),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    owner.name,
                    style: TextStyle(
                        fontSize: 13,
                        color: primary,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${countFormat(owner.fans)}粉丝",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              print("点击了关注");
            },
            child: Text("+ 关注",
                style: TextStyle(fontSize: 13, color: Colors.white)),
            color: primary,
            minWidth: 50,
            height: 24,
          )
        ],
      ),
    );
  }
}
