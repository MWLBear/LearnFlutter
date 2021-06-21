import 'package:flutter/material.dart';

Widget getAlignView(){
  return Align(
    child: Icon(Icons.pets,size: 36,color: Colors.red),
    alignment: Alignment.bottomRight,
    widthFactor: 3,
    heightFactor: 3,
  );
}

Widget getCenterView(){
  return Center(
      child: Icon(Icons.pets,size: 36,color: Colors.red,),
      widthFactor: 3,
      heightFactor: 3
  );
}

Widget getPaddingView() {
  return Padding(
    padding: EdgeInsets.all(20),
    child: Text(
      "莫听穿林打叶声，何妨吟啸且徐行。竹杖芒鞋轻胜马，谁怕？一蓑烟雨任平生。",
      style: TextStyle(color: Colors.redAccent, fontSize: 18),
    ),
  );
}

Widget getContainerView() {
  return Center(
    child: Container(
      // color: Colors.blueAccent,
      width: 100,
      height: 100,
      child: Icon(
        Icons.pets,
        size: 32,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(
              color: Colors.redAccent, width: 3, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(offset: Offset(5, 5), color: Colors.purple, blurRadius: 5)
          ],
          gradient: LinearGradient(colors: [Colors.green, Colors.red])),
    ),
  );
}

Widget getCircelContainerView() {
  return Center(
    child: Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(
              "https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg"),
        ),
      ),
    ),
  );
}

Widget getRowView() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(color: Colors.red, width: 60, height: 60),
      Container(color: Colors.blue, width: 80, height: 80),
      Container(color: Colors.green, width: 70, height: 70),
      Container(color: Colors.orange, width: 100, height: 200),
    ],
  );
}

Widget getExpanded() {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Expanded(flex: 1, child: Container(color: Colors.red, height: 60)),
      Container(color: Colors.blue, width: 80, height: 80),
      Container(color: Colors.green, width: 70, height: 70),
      Expanded(flex: 1, child: Container(color: Colors.orange, height: 100)),
    ],
  );
}

Widget getColumnView() {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Expanded(flex: 1, child: Container(color: Colors.red, width: 60)),
      Container(color: Colors.blue, width: 80, height: 80),
      Container(color: Colors.green, width: 70, height: 70),
      Expanded(flex: 1, child: Container(color: Colors.orange, width: 100)),
    ],
  );
}

Widget getStackView() {
  return Stack(
    children: [
      Container(
        color: Colors.purple,
        width: 300,
        height: 300,
      ),
      Positioned(
          left: 20,
          top: 20,
          child: Icon(Icons.favorite, size: 50, color: Colors.orange)),
      Positioned(
          right: 20,
          bottom: 20,
          child:
          Text("天下无敌", style: TextStyle(color: Colors.white, fontSize: 20))),
      Positioned(
          right: 20,
          top: 20,
          child: FadeInImage(
            width: 80,
            height: 80,
            placeholder: AssetImage('images/1.png'),
            image: NetworkImage('https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg'),
          )
      )
    ],
  );
}

Widget _buildStack() => Stack(
  alignment: Alignment(0.5,0.5),
  children: [
    CircleAvatar(
      backgroundImage: NetworkImage("https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg"),
      radius: 100,
    ),
    Container(
      decoration: BoxDecoration(
          color: Colors.black45
      ),
      child: Text(
        '兵长',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
    )
  ],
);


//官方布局综合案例 Container row Column 使用
Widget buildHomePage(){

  final titleText = Container(
    padding: EdgeInsets.all(20),
    child: Text(
      'Strawberry Pavlova',
      style: TextStyle(
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
        fontSize: 30,
      ),
    ),
  );

  final subTitle = Text(
    'Pavlova is a meringue-based dessert named after the Russian ballerina '
        'Anna Pavlova. Pavlova features a crisp crust and soft, light inside, '
        'topped with fruit and whipped cream.',
    textAlign: TextAlign.center,
    style: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 25
    ),
  );

  var starts = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.black),
      Icon(Icons.star, color: Colors.black),
    ],
  );

  final ratings = Container(
    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        starts,
        Text(
          '170 Reviews',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 20),
        )
      ],
    ),
  );

  final descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w800,
      fontFamily: 'Roboto',
      letterSpacing: 0.5,
      fontSize: 18,
      height: 2
  );

  final inconList = DefaultTextStyle.merge(
    style: descTextStyle,
    child: Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Icon(Icons.kitchen,color: Colors.green[500]),
              Text('PREP:'),
              Text('25 min'),
            ],
          ),
          Column(
            children: [
              Icon(Icons.timer,color: Colors.green[500]),
              Text('COOK:'),
              Text('1 hr'),
            ],
          ),
          Column(
            children: [
              Icon(Icons.restaurant,color: Colors.green[500]),
              Text('FEEDS:'),
              Text('4-6'),
            ],
          ),
        ],
      ),
    ),
  );

  final leftColumn = Container(
    padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
    child: Column(
      children: [
        titleText,
        subTitle,
        ratings,
        inconList,
      ],
    ),
  );

  final mainImage = Image.asset(
    'images/1.png',
    fit: BoxFit.cover,
  );

  final Body = Center(
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
      height: 600,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              child: leftColumn,
            ),
            mainImage,
          ],
        ),
      ),
    ),
  );

  return leftColumn;
}






