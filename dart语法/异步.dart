import 'dart:io';

main(List<String> args) {
  // test();
  delay();
}

delay() {
  print("start");
  Future.delayed(Duration(seconds: 3), () {
    return "3秒后的信息";
  }).then((value) {
    print(value);
  });
  print("end");
}

test() {
  print("start");
  var future = getNetWorkData();
  future.then((value) {
    print(value);
  }).catchError((error) {
    print(error);
  });
  print(future);
  print("end");
}

Future<String> getNetWorkData() {
  return Future<String>(() {
    sleep(Duration(seconds: 3));
    return "network data";
    // throw Exception("网络异常");
  });
}

Future<String> getNetworkData1() async {
  var result = await Future.delayed(Duration(seconds: 3), () {
    return "net data";
  });
  return "请求到的数据: " + result;
}
