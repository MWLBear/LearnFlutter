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
    print("url:${uri.toString()}");
    return uri.toString();
  }

  bool needLogin();
  Map<String, String> params = Map();
  BaseRequest add(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, dynamic> header = {};
  BaseRequest addHeader(String k, Object v) {
    header[k] = v.toString();
    return this;
  }
}
