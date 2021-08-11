import 'dart:async';

void main() async {
  var stream = countStream(10);
  var sun = await sumStream(stream);
  print(sun);

  //getEmoji(10).forEach(print);
  //getEmojiWithTime(10).forEach(print);
  // fetEmoji(1).then(print);
  // fetEmojis(10).listen(print);
  getEmojiWithTime1(10).listen(print);
}

void learStream() {
  //获得 Stream 的方法：
  // Stream.fromFuture:从Future创建新的单订阅流,当future完成时将触发一个data或者error，然后使用Down事件关闭这个流。
  //
  // Stream.fromFutures:从一组Future创建一个单订阅流，每个future都有自己的data或者error事件，当整个Futures完成后，流将会关闭。如果Futures为空，流将会立刻关闭。
  //
  // Stream.fromIterable:创建从一个集合中获取其数据的单订阅流。

  //监听一个流最常见的方法就是listen
  StreamController<int> controller = StreamController();
  controller.stream.listen((event) {
    print(event);
  });
  controller.sink.add(123);
  controller.sink.add(456);
}

Future<int> generateData(int data) async => data;

Stream<int> countStream(int to) async* {
  for (var i = 0; i <= to; i++) {
    yield await generateData(i);
  }
}

//除了通过 listen 使用 await for 处理 Stream
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  //当这个 Stream 完成或关闭的时候。 for循环结束
  await for (var value in stream) {
    sum += value;
  }
  return sum;
}

//一、多元素同步函数生成器
//1. sync* 和 yield
//sync*是一个dart语法关键字。它标注在函数{ 之前，其方法必须返回一个 Iterable<T>对象
Iterable<String> getEmoji(int count) sync* {
  //👿 的码为\u{1f47f}
  Runes runes = Runes('\u{1f47f}');
  for (var i = 0; i < count; i++) {
    yield String.fromCharCodes(runes.map((e) => e + i));
  }
}
//2、sync* 和 yield*
//yield*又是何许人也? 记住一点yield*后面的表达式是一个Iterable<T>对象

Iterable<String> getEmojiWithTime(int count) sync* {
  yield* getEmoji(count)
      .map((e) => '$e -- ${DateTime.now().toIso8601String()}');
}

//二、异步处理: async和await
//async是一个dart语法关键字。它标注在函数{ 之前，其方法必须返回一个 Future<T>对象

Future<String> fetEmoji(int count) async {
  Runes first = Runes('\u{1f47f}');
  await Future.delayed(Duration(seconds: 2));
  print('加载结束--${DateTime.now().toIso8601String()}');
  return String.fromCharCodes(first.map((e) => e + count));
}

//三、多元素异步函数生成器:
// 通过 async* 生成 stream
// 1.async*和yield、await
//async*是一个dart语法关键字。它标注在函数{ 之前，其方法必须返回一个 Stream<T>对象
Stream<String> fetEmojis(int count) async* {
  for (var i = 0; i < count; i++) {
    yield await fetEmoji1(i);
  }
}

Future<String> fetEmoji1(int count) async {
  Runes first = Runes('\u{1f47f}');
  print('加载开始--${DateTime.now().toIso8601String()}');
  await Future.delayed(Duration(seconds: 2)); //模拟耗时
  print('加载结束--${DateTime.now().toIso8601String()}');
  return String.fromCharCodes(first.map((e) => e + count));
}

//2.async*和yield*、await
//和上面的yield*同理，async*方法内使用yield*,其后对象必须是Stream<T>对象
Stream<String> getEmojiWithTime1(int count) async* {
  yield* fetchEmojis(count)
      .map((e) => '$e -- ${DateTime.now().toIso8601String()}');
}

Stream<String> fetchEmojis(int count) async* {
  for (int i = 0; i < count; i++) {
    yield await fetchEmoji(i);
  }
}

Future<String> fetchEmoji(int count) async {
  Runes first = Runes('\u{1f47f}');
  await Future.delayed(Duration(seconds: 2)); //模拟耗时
  return String.fromCharCodes(first.map((e) => e + count));
}

//我认为 yield* 的正确答案是委托给另一个生成器而不是调用函数。
//yield* 简单地委托给另一个生成器，这意味着当前生成器停止，
//另一个生成器接手工作，直到它停止生产。在那个停止产生值之后，
//主生成器恢复产生它自己的值。


/**
 * 
 * 
 * 
 * 
 * 
 * 
 */