import 'dart:async';
import 'dart:math';

import 'package:bibili_flutter/barrage/barrage_item.dart';
import 'package:bibili_flutter/barrage/hi_socket.dart';
import 'package:bibili_flutter/barrage/ibarrage.dart';
import 'package:bibili_flutter/model/barrage_model.dart';
import 'package:flutter/material.dart';

import 'barrage_view_util.dart';

enum BarrageStatus { play, pause }

///弹幕组件
class HiBarrage extends StatefulWidget {
  final int lineCount;
  final String vid;
  final int speed;
  final double top;
  final bool autoPlay;
  final Map<String, dynamic> headers;
  const HiBarrage(
      {Key? key,
      this.lineCount = 4,
      required this.vid,
      this.speed = 800,
      this.top = 0,
      this.autoPlay = false,
      required this.headers})
      : super(key: key);

  @override
  HiBarrageState createState() => HiBarrageState();
}

class HiBarrageState extends State<HiBarrage> implements IBarrage {
  late HiSocket _hiSocket;
  late double _height;
  late double _width;
  List<BarrageItem> _barrageItemList = []; //弹幕widget集合
  List<BarrageModel> _barrageModelList = []; //弹幕模型
  int _barrageIndex = 0; //第几条弹幕
  Random _random = Random();
  BarrageStatus? _barrageStatus;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _hiSocket = HiSocket(widget.headers);
    _hiSocket.open(widget.vid).listen((value) {
      _handelMessage(value);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _hiSocket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = _width / 16 * 9;
    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [Container()]..addAll(_barrageItemList),
      ),
    );
  }

  @override
  void pause() {
    _barrageStatus = BarrageStatus.pause;
    _barrageItemList.clear();
    setState(() {});
    print("action:pause");
    _timer?.cancel();
  }

  @override
  void play() {
    _barrageStatus = BarrageStatus.play;
    print("action:play");
    if (_timer != null && (_timer?.isActive ?? false)) return;
    _timer = Timer.periodic(Duration(milliseconds: widget.speed), (timer) {
      if (_barrageModelList.isNotEmpty) {
        var temp = _barrageModelList.removeAt(0);
        addBarrage(temp);
        print("start:${temp.content}");
      } else {
        print("all barrage are send");
        _timer?.cancel();
      }
    });
  }

  @override
  void send(String? message) {
    if (message == null) return;
    _hiSocket.send(message);
    _handelMessage([
      BarrageModel(
        content: message,
        vid: "-1",
        priority: 1,
        type: 1,
      )
    ]);
  }

  ///处理消息，instant=true 马上发送
  void _handelMessage(List<BarrageModel> value, {bool instance = false}) {
    if (instance) {
      _barrageModelList.insertAll(0, value);
    } else {
      _barrageModelList.addAll(value);
    }

    //收到新的弹幕后播放
    if (_barrageStatus == BarrageStatus.play) {
      play();
      return;
    }

    //收到新的弹幕后播放
    if (widget.autoPlay && _barrageStatus != BarrageStatus.pause) {
      play();
    }
  }

  ///添加弹幕
  void addBarrage(BarrageModel mo) {
    double perRowHeight = 30;
    var line = _barrageIndex % widget.lineCount;
    _barrageIndex++;
    var top = line * perRowHeight + widget.top;
    String id = '${_random.nextInt(10000)}:${mo.content}';
    var item = BarrageItem(
        id: id,
        top: top,
        child: BarrageViewUtil.barrageView(mo),
        onComplete: _onComplete);
    _barrageItemList.add(item);
    setState(() {});
  }

  void _onComplete(id) {
    print("done:$id");
    _barrageItemList.removeWhere((element) => element.id == id);
  }
}
