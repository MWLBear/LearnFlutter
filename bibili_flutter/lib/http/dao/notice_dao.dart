import 'package:bibili_flutter/http/core/hi_net.dart';
import 'package:bibili_flutter/http/request/notice_request.dart';
import 'package:bibili_flutter/model/notice_mo.dart';

class NoticeDao {
  //https://api.devio.org/uapi/fa/notice?pageIndex=1&pageSize=10
  static noticeList({int pageIndex = 1, int pageSize = 10}) async {
    NoticeRequest request = NoticeRequest();
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print("notice: $result");
    return NoticeMo.fromJson(result['data']);
  }
}
