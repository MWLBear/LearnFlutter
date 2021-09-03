import 'package:bibili_flutter/db/hi_cache.dart';
import 'package:bibili_flutter/http/core/hi_net.dart';
import 'package:bibili_flutter/http/request/base_request.dart';
import 'package:bibili_flutter/http/request/login_request.dart';
import 'package:bibili_flutter/http/request/registration_request.dart';

class LoginDao {
  static const BOARDING_PASS = "boarding-pass";

  ///登陆
  static login(String userName, String password) {
    return send(userName, password);
  }

  ///注册
  static registration(
      String userName, String password, String imoocId, String orderId) {
    return send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  ///发送
  static send(String userName, String password,
      {String? imoocId, String? orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
      request.add('imoocId', imoocId).add('orderId', orderId);
    } else {
      request = LoginRequest();
    }
    request.add("userName", userName).add("password", password);

    var result = await HiNet.getInstance().fire(request);
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      // 保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  /// 获取登录令牌
  static String? getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
