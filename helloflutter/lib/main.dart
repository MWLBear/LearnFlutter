import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

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
    return _buildGirdDemo2();
  }
}

Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 150,
      padding: EdgeInsets.all(4),
      mainAxisSpacing: 10,
      crossAxisSpacing: 4,
      children: _buildGridTitleList(30),
);

Widget _buildGridDemo1() => GridView(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.0),
      children:_buildGridTitleList(100) ,
);
Widget _buildGirdDemo2() => GridView(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 150,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    childAspectRatio: 1.0,
  ),
  children: _buildGridTitleList(100),
);

List<Container> _buildGridTitleList(int count) => List.generate(count, (index) =>
    Container(
      alignment: Alignment.center,
      child: Text('$index',style: TextStyle(fontSize: 30)),
      color: Colors.red,)
);


Widget _buileTitleSecsstion() {
  return ListView(
    children: [
      _buildListTile(Icons.people, '联系人', '联系人信息'),
      Divider(),
      _buildListTile(Icons.message, '消息', '消息详情'),
      Divider(),
      _buildListTile(Icons.map, '地址', '地址详细'),
    ],
  );
}

ListTile _buildListTile(IconData icon, String label, String subtitle) {
  return ListTile(
    leading: Icon(icon,size: 30,),
    title: Text(label),
    subtitle: Text(subtitle),
    trailing: Icon(Icons.arrow_forward_ios),
    selectedTileColor: Colors.blueAccent,
  );
}

Widget ListViewBuild = ListView.builder(
  itemCount: 100,
  itemExtent: 80,
  itemBuilder: (BuildContext context, int index){
    return ListTile( title: Text('标题$index'),subtitle: Text('详情内容$index'),);
  },
);

Divider blueColor = Divider(color: Colors.blue);
Divider redColor = Divider(color: Colors.red);

Widget ListViewDemo2 = ListView.separated(
  itemBuilder: (BuildContext context, int index) {
    return ListTile(
      leading: Icon(
        Icons.pets,
        size: 30,
      ),
      title: Text('联系人$index'),
    );
  },
  separatorBuilder: (BuildContext context, int index) {
    return index % 2 == 0 ? blueColor : redColor;
  },
  itemCount: 100,
);


