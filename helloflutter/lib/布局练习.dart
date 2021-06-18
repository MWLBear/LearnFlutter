import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter layout Demo",
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter layout demo"),
        ),
        body: HomeBody(),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Color color = Theme.of(context).primaryColor;

    Widget titleSection = Container(
      padding: EdgeInsets.all(30),
      child: Row(
        children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Oeschinen Lake Campground',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Text(
                    'Kandersteg, Switzerland',
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              )
          ),
          Icon(
            Icons.star,
            color: Colors.orange,),
          Text('42')
        ],
      ),
    );

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, "CALL"),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget TextSection = Container(
      padding: EdgeInsets.all(20),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
    Widget ImageSection = Image.asset(
      "images/lake.jpeg",
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );

    return ListView(
      children: [
        ImageSection,
        titleSection,
        buttonSection,
        TextSection,
      ],
    );
  }
}

Column _buildButtonColumn(Color color ,IconData icon, String label){
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon,color: color,),
      Container(
        margin: EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color
          ),
        ),
      ),
    ],
  );
}

Widget _buildGrid() => GridView.extent(
  maxCrossAxisExtent: 80,
  padding: EdgeInsets.all(4),
  mainAxisSpacing: 10,
  crossAxisSpacing: 4,
  children: _buildGridTitleList(30),
);

List<Container> _buildGridTitleList(int count) => List.generate(count, (index) =>
    Container(
      alignment: Alignment.center,
      child: Text('$index',style: TextStyle(fontSize: 30)),
      color: Colors.red,)
);