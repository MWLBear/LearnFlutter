import 'package:bibili_flutter/http/core/dio_adapter.dart';
import 'package:bibili_flutter/http/core/hi_error.dart';
import 'package:bibili_flutter/http/core/hi_net_adapter.dart';
import 'package:bibili_flutter/http/request/base_request.dart';

class HiNet {
  HiNet._();
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
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status ?? -1, result.toString(), data: result);
    }
  }

  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('hi_net:' + log.toString());
  }
}
