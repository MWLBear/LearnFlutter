import 'package:bibili_flutter/http/dao/login_dao.dart';
import 'package:bibili_flutter/util/hi_constants.dart';

enum HttpMethod { GET, POST, DELETE }

abstract class BaseRequest {
  var pathParams; //主要作用就是像服务器提供额外的参数，用来表示本次请求的一些特性
  var useHttps = true;
  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().endsWith('/')) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    var boardingPass = LoginDao.getBoardingPass();
    if (needLogin() && boardingPass != null) {
      // 给需要登录的接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, boardingPass);
    }
    print("请求url:${uri.toString()}");
    print('请求头:$header');
    print('请求参:$params');
    return uri.toString();
  }

  bool needLogin();
  Map<String, String> params = Map();
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {
    HiConstants.authTokenK: HiConstants.authTokenV,
    HiConstants.courseFlagK: HiConstants.courseFlagV,
  };
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
