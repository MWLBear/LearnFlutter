import 'dart:math';

main(List<String> args) {
  print("object");
  var p = Persion('lz', 10);
  print(p);
  var p1 = Persion.forMap({'name': 'zf', 'age': 10});
  print(p1);

  var p3 = Person2.withName("zf");
  var p4 = Person2.withName("zf");
  print(identical(p3, p4));

  final d = Dog("黑色");
  d.setColor = "黄色";
  print(d.getColor);

  final cc = SuperMan1();
  cc.fly();
  cc.run();

  var stu = Student();
  stu.name = "lz";
  stu.sno = 110;
  Student.time = "早上8点";
  stu.study();
  Student.attendClass();

  print(Colors.red.index);
  print(Colors.values);

  Location l = Location<int>(10, 20);
  print(l.x.runtimeType);

  var names = ['why', 'leizi'];
  print(getFirst(names));
}

class Persion {
  String? name;
  int? age;

  Persion(this.name, this.age);
  //重定向构造方法
  Persion.fromName(String name) : this(name, 0);
  Persion.withArgements(String name, int age) {
    this.name = name;
    this.age = age;
  }
  Persion.forMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.age = map['age'];
  }
  @override
  String toString() {
    return 'name: $name, age: $age';
  }
}

//初始化列表
class Point {
  final num x;
  final num y;
  final num distance;
  Point(this.x, this.y) : distance = sqrt(x * x + y * y);
}

//常量构造方法
class Person1 {
  final String name;
  const Person1(this.name);
}

//工厂构造函数
class Person2 {
  String name;
  static final Map<String, Person2> _cache = {};
  factory Person2.withName(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name]!;
    } else {
      final p = Person2(name);
      _cache[name] = p;
      return p;
    }
  }
  Person2(this.name);
}

//setter 和 getter
class Dog {
  String color;
  String get getColor {
    return color;
  }

  set setColor(String color) {
    this.color = color;
  }

  Dog(this.color);
}

//类的继承
class Animal {
  int age;
  run() {
    print("在奔跑ing");
  }

  Animal(this.age);
}

class Person3 extends Animal {
  String name;
  @override
  run() {
    print("$name 在奔跑ing");
  }

  Person3(String name, int age)
      : name = name,
        super(age);
}

//抽象类
//抽象类不能实例化.
//抽象类中的抽象方法必须被子类实现, 抽象类中的已经被实现方法, 可以不被子类重写.

abstract class Shape {
  getArea();
}

class Circle extends Shape {
  double r;
  Circle(this.r);

  @override
  getArea() {
    return r * r * 3.14;
  }
}

class Reactangle extends Shape {
  double w;
  double h;
  Reactangle(this.w, this.h);

  @override
  getArea() {
    return w * h;
  }
}

//隐式接口
abstract class Runner {
  run();
}

abstract class Flyer {
  fly();
}

class SuperMan implements Runner, Flyer {
  @override
  run() {
    print('超人在奔跑');
  }

  @override
  fly() {
    print('超人在飞');
  }
}

//Mixin 混入
mixin Runner1 {
  run() {
    print("在奔跑");
  }
}
mixin Flyer1 {
  fly() {
    print("在飞");
  }
}

class SuperMan1 with Runner1, Flyer1 {}
// 类成员和方法

class Student {
  String? name;
  int? sno;
  static String? time;

  study() {
    print('$name在学习');
  }

  static attendClass() {
    print('去上课');
  }
}

//枚举类型
enum Colors { red, green, blue }

//泛型类
class Location<T extends num> {
  T x;
  T y;
  Location(this.x, this.y);
}

//泛型方法
T getFirst<T>(List<T> ts) {
  return ts[0];
}
