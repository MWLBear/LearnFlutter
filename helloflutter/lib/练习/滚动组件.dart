import 'package:flutter/material.dart';

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

Widget _buildGirdDemo3() {
  return Container(
    padding: EdgeInsets.all(8.0),
    child: GridView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://tva1.sinaimg.cn/large/006y8mN6gy1g7aa03bmfpj3069069mx8.jpg',
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "国服打野",
                style: TextStyle(fontSize: 16),
              ),
              Text('手法流操作,今日不上百星,不下播,',
                  maxLines: 1, overflow: TextOverflow.ellipsis)
            ],
          ),
        );
      },
      itemCount: 10,
    ),
  );
}

List<Container> _buildGridTitleList(int count) => List.generate(count, (index) =>
    Container(
      alignment: Alignment.center,
      child: Text('$index',style: TextStyle(fontSize: 30)),
      color: Colors.red,)
);

Widget ListViewDemo() {
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

Widget ListViewDemo1 = ListView.builder(
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

Widget SliversDemo() {
  return CustomScrollView(
    slivers: [
      SliverSafeArea(
        sliver: SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext contex, int index) {
                return Container(
                  alignment: Alignment(0,0),
                  color: Colors.red,
                  child: Text('item$index'),
                );
              },
              childCount: 20,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget SliverDemo2() {
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        expandedHeight: 250,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Lz Demo'),
          titlePadding: EdgeInsets.only(bottom: 20),
          background: Image(
            image: NetworkImage(
              'https://tva1.sinaimg.cn/large/006y8mN6gy1g72j6nk1d4j30u00k0n0j.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SliverGrid(
          delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('gird item $index'),
            );
          }, childCount: 10),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 4.0)),
      SliverFixedExtentList(
          delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.lightBlue[100 * (index % 10)],
              child: Text('list item $index'),
            );
          }, childCount: 20),
          itemExtent: 50.0),
    ],
  );
}
//滚动监听

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late ScrollController _controller;
  bool _isShowTop = false;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    _controller.addListener(() {
      var tempSsShowTop = _controller.offset >= 1000;
      if (tempSsShowTop != _isShowTop){
        setState(() {
          _isShowTop = tempSsShowTop;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment(0.8, 0.8),
        children: [
          ListView.builder(
            controller: this._controller,
            itemCount: 100,
            itemExtent: 50,
            itemBuilder: (BuildContext contex, int index) {
              return ListTile(title: Text("item$index"));
            },
          ),

          FloatingActionButton(
            onPressed: () {
              if (_isShowTop) {
                _controller.animateTo(0,
                    duration: Duration(seconds: 2), curve: Curves.easeIn);
              }
            },
            child: Icon(
              Icons.arrow_upward,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

//监听滚动
class MyHomeNotificationDemo extends StatefulWidget {
  const MyHomeNotificationDemo({Key? key}) : super(key: key);

  @override
  _MyHomeNotificationDemoState createState() => _MyHomeNotificationDemoState();
}

class _MyHomeNotificationDemoState extends State<MyHomeNotificationDemo> {
  int _progress = 0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification:(ScrollNotification notification){
          if (notification is ScrollStartNotification){
            print("开始滚动...");
          }else if (notification is ScrollUpdateNotification){
            final currentPixel = notification.metrics.pixels;
            final totalPixel = notification.metrics.maxScrollExtent;
            double progress = currentPixel / totalPixel;
            setState(() {
              _progress = (progress * 100).toInt();
            });
            print("正在滚动 ${notification.metrics.pixels} - ${notification.metrics.maxScrollExtent}");
          }else if (notification is ScrollEndNotification){
            print('滚动结束');
          }
          return false;
        } ,
        child: Stack (
          alignment: Alignment(0.9,0.9),
          children: [
            ListView.builder(
              itemCount: 100,
              itemExtent: 50,
              itemBuilder: (BuildContext contex, int index) {
                return ListTile(title: Text("item$index"));
              },
            ),
            CircleAvatar(
              radius: 30,
              child: Text('$_progress %'),
              backgroundColor: Colors.black54,
            ),
          ],
        )
    );
  }
}
