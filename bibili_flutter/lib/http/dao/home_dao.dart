import 'package:bibili_flutter/http/core/hi_net.dart';
import 'package:bibili_flutter/http/request/home_request.dart';
import 'package:bibili_flutter/model/home_mo.dart';

class HomeDao {
  //https://api.devio.org/uapi/fa/home/推荐?pageIndex=1&pageSize=10
  static get(String category, {int pageIndex = 1, int pageSize = 1}) async {
    HomeRequest request = HomeRequest();
    request.pathParams = category;
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return HomeMo.fromJson(result['data']);
  }
}
