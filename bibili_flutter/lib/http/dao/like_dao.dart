import 'package:bibili_flutter/http/core/hi_net.dart';
import 'package:bibili_flutter/http/request/base_request.dart';
import 'package:bibili_flutter/http/request/cancel_like_request.dart';
import 'package:bibili_flutter/http/request/like_request.dart';

class LikeDao {
  static like(String vid, bool isLike) async {
    //https://api.devio.org/uapi/fa/like/BV1A5411L71X
    BaseRequest request = isLike ? LikeRequest() : CancelLikeRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }
}
