import 'package:bibili_flutter/http/core/hi_net.dart';
import 'package:bibili_flutter/http/request/rank_request.dart';
import 'package:bibili_flutter/model/ranking_mo.dart';

class RankingDao {
  //https://api.devio.org/uapi/fa/ranking?sort=like&pageIndex=1&pageSize=40
  static get(String sort, {int pageIndex = 1, pageSize = 10}) async {
    RankRequest request = RankRequest();
    request
        .add("sort", sort)
        .add("pageIndex", pageIndex)
        .add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return RankingMo.fromJson(result["data"]);
  }
}
