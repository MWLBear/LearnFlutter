import 'package:bibili_flutter/http/core/hi_net.dart';
import 'package:bibili_flutter/http/request/video_detail_request.dart';
import 'package:bibili_flutter/model/video_detail_mo.dart';

class VideoDetailDao {
  static get(String vid) async {
    final request = VideoDetailRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    return VideoDetailMo.fromJson(result["data"]);
  }
}
