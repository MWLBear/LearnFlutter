import 'package:bibili_flutter/util/color.dart';
import 'package:bibili_flutter/util/view_until.dart';
import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

import 'hi_video_controls.dart';

///播放器组件
class VideoView extends StatefulWidget {
  final String url;
  final String cover;
  final bool autoPlay;
  final bool loop;
  final double aspectRatio;
  final Widget? overlyUI;
  final Widget? barrageUI;

  const VideoView(
    this.url, {
    Key? key,
    required this.cover,
    this.autoPlay = false,
    this.loop = false,
    this.aspectRatio = 16 / 9,
    this.overlyUI,
    this.barrageUI,
  }) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    //初始化播放器
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        looping: widget.loop,
        autoPlay: widget.autoPlay,
        placeholder: _placeholder(),
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        customControls: MaterialControls(
          showLoadingOnInitialize: false,
          showBigPlayIcon: false,
          bottomGradient: blackLinearGradient(),
          overlayUI: widget.overlyUI,
          barrageUI: widget.barrageUI,
        ),
        materialProgressColors: _progressColors());

    //fix iOS无法正常退出全屏播放问题
    _chewieController.addListener(_fullScreenListener);
  }

  @override
  void dispose() {
    _chewieController.removeListener(_fullScreenListener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double playHeight = width / widget.aspectRatio;
    return Container(
      width: width,
      height: playHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  //封面
  _placeholder() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: cachedImage(widget.cover),
    );
  }

  //进度条颜色
  _progressColors() {
    return ChewieProgressColors(
        playedColor: primary,
        handleColor: primary,
        backgroundColor: Colors.grey,
        bufferedColor: primary[50]!);
  }

  void _fullScreenListener() {
    print("_fullScreenListener");

    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
