import 'package:bibili_flutter/http/core/hi_net_adapter.dart';
import 'package:bibili_flutter/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    return Future.delayed(Duration(microseconds: 1000), () {
      return HiNetResponse(
          request: request,
          data: {"code": 0, "message": 'success'} as T,
          statusCode: 200);
    });
  }
}
