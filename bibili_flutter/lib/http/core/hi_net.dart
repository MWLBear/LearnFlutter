import 'package:bibili_flutter/http/core/dio_adapter.dart';
import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/http/core/hi_interceptor.dart';
import 'package:bibili_flutter/http/core/hi_net_adapter.dart';
import 'package:bibili_flutter/http/request/base_request.dart';

class HiNet {
  HiNet._();

  HiErrorInterceptor? _hiErrorInterceptor;

  static HiNet? _instance;
  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }
    if (response == null) {
      printLog(error);
    }
    var result = response?.data;
    printLog(result);
    var status = response?.statusCode;
    var hiError;
    switch (status) {
      case 200:
        printLog("200");
        return result;
      case 401:
        hiError = NeedLogin();
        break;
      case 403:
        hiError = NeedAuth(result.toString(), data: result);
        break;
      default:
        hiError = HiNetError(status ?? -1, result.toString(), data: result);
    }
    if (_hiErrorInterceptor != null) {
      _hiErrorInterceptor!(hiError);
    }
    throw HiNetError;
  }

  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void setErrorInterceptor(HiErrorInterceptor interceptor) {
    this._hiErrorInterceptor = interceptor;
  }

  void printLog(log) {
    print('hi_net:' + log.toString());
  }
}
