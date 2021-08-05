import 'package:dio/dio.dart';
import 'config.dart';
class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(baseUrl: HttpConfig.baseURL,connectTimeout: HttpConfig.timeOut);
  static final Dio dio = Dio(baseOptions);

  static Future<T> request<T> (String url,
      {String method = 'get', Map<String, dynamic>? params,Interceptor? inter}) async{

    //请求的单独配置
    final options = Options(method: method);
    // 添加一个拦截器
    Interceptor dInter = InterceptorsWrapper(
        onRequest: (options,handel){
          print('拦截了请求');
          return handel.next(options);
        },
        onResponse: (response,handel){
          print('拦截了响应');
          return handel.next(response);
        },
        onError: (DioError error,handel){
          return handel.next(error);
        }
    );
    List<Interceptor> inters = [dInter];
    if(inter != null){
      inters.add(dInter);
    }
    dio.interceptors.addAll(inters);
    //发送网络请求
    try {
      Response response = await dio.request(url,queryParameters:params, options: options);
      return response.data;
    }on DioError catch(e){
      return Future.error(e);
    }
  }

}