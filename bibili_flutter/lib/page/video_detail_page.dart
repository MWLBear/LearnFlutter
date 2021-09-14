import 'package:bibili_flutter/model/video_model.dart';
import 'package:flutter/material.dart';

class VideoDetail extends StatefulWidget {
  final VideoModel model;

  const VideoDetail(this.model);

  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: Text("视频详情页,vid: ${widget.model.vid}")),
    );
  }
}
