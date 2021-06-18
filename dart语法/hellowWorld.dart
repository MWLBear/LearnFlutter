import 'dart:io';

main(List<String> args) {
  // String name = "leizi";
  int age = 18;
  double height = 1.88;
  age = 20;
  var name = "liezi";
  name = "kobe";
  final adress = "zhu jiang xin cheng";
  const school = "Jia Da";

  final name1 = getName();
  // const name2 = getName();
  // const在赋值时, 赋值的内容必须是在编译期间就确定下来的
  // final在赋值时, 可以动态获取, 比如赋值一个函数

  final time = DateTime.now();
  print(time);
  sleep(Duration(seconds: 2));
  print(time);

  const a = Person('lz');
  const b = Person('lz');
  print(identical(a, b));

  final m = Person('lz');
  final n = Person('lz');

  print(identical(m, n));

  //数据类型
  int age1 = 18;
  int hexage = 0x12;
  print(hexage);
  var one = int.parse("111");
  var two = double.parse("11.22");

  var num1 = 123;
  var num2 = 123.456;
  var num1str = num1.toString();
  var num2str = num2.toString();
  var num2strD = num2.toStringAsFixed(2);
  print('${num2strD},${num2strD.runtimeType}');

  var istrue = true;
  print('$istrue ${istrue.runtimeType}');

  //字符串类型
  var s1 = 'hello world';
  var s2 = 'hello Dart';
  var s3 = 'hello \'Flutter';
  var s4 = "hello'Flutter'";

//集合类型
//Set和List最大的两个不同就是：Set是无序的，并且元素是不重复的。

  var letters = ['a', 'b', 'c', 'd'];
  print('$letters ${letters.runtimeType}');
  var lettersSet = {'a', 'b', 'c', 'd'};
  print('$lettersSet ${lettersSet.runtimeType}');

  var infoMap1 = {'name': 'lz', 'age': 18, 'height': 1.88};
  print('$infoMap1 ${infoMap1.runtimeType}');

  print(letters.length);
  print(lettersSet.length);
  print(infoMap1.length);

  letters.add('6');
  lettersSet.add('6');
  print('$letters $lettersSet');

  print(letters.contains('a'));
  print(lettersSet.contains('b'));

  letters.remove('a');
  print('$letters');

  print(infoMap1['name']);
  print('${infoMap1.entries} ${infoMap1.entries.runtimeType}');
  print('${infoMap1.keys}');
  print("${infoMap1.values}");

  infoMap1.remove('age');
  print('$infoMap1');

  //函数
  // var bar = foo;
  // print(bar);
  // test(foo);
  // var fuc = getFunc();
  // fuc("kobe");

  //匿名函数
  test(() {
    print('匿名函数被调用');
    return 10;
  });
  test(() => {print('箭头函数被调用')});
  var movies = ['盗梦空间', '星际穿越', '少年派', '西游'];
  printElement(item) {
    print(item);
  }

  movies.forEach(printElement);
  movies.forEach((element) {
    print(element);
  });
  //可选参数
  sayHello('lz', age: 10, heigt: 1.99);

  //词法闭包
  var adder = makeAdder(2);
  print(adder(10));
  print(adder(6));

  var foo = add1();
  print(foo(20, 30));
}

//位置可选参数
sayHello1(String name, [int age = 0, double heigt = 0.0]) {}

//命名可选参数
sayHello(String name, {int age = 0, double heigt = 0.0}) {}
String getName() {
  return "leizi";
}

class Person {
  final String name;
  const Person(this.name);
}

//如果函数中只有一个表达式, 那么可以使用箭头语法(arrow syntax)
sum(num1, num2) => num1 + num2;

//定义一个函数
foo(String name) {
  print('传入的name: $name');
}

//函数作为参数
test(Function fun) {
  // fun('leizi');
}

//函数所为返回值
getFunc() {
  return foo;
}

//词法闭包
makeAdder(num addBy) {
  return (num i) {
    return i + addBy;
  };
}

typedef Calculate = int Function(int num1, int num2);
void test1(Calculate calc) {
  calc(10, 20);
}

Calculate add1() {
  return (num1, num2) {
    return num1 * num2;
  };
}
