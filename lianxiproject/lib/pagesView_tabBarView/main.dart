
import 'package:flutter/material.dart';
import 'pull_load_more.dart';
import 'second_page.dart';
import 'third_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: MyHomePage(title: 'Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  final PageController _pageController = PageController();
  final List<String> tab = ["动态", "趋势", "我的"];

  /// 底部tab是放在了 Scaffold 的 bottomNavigationBar 中。
  /// 顶部tab是放在 AppBar 的 bottom 中，也就是标题栏之下。

  /// 使用 pageView 自定义实现点击 bar_item 切换界面
  _tabViews () {
    List<Widget> list = [];
    for(int i = 0; i<tab.length; i++){
      list.add(
          TextButton(
              onPressed: (){
                /// 如果是使用 TabBarView,可以控制点击界面的变动
                /// _tabController.animateTo(i);
                // _pageController.jumpToPage(i);
                _pageController.jumpTo(MediaQuery.of(context).size.width *i);
              },
              child:Text(
                tab[i],
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              )
          )
      );
    }
    return list;
  }

  _pages(){
    return [
      FirstPage(),
      SecondPage(),
      ThirdPages(),
    ];
  }
  _pages1(){
   return tab.map((e){
      return Container(
        alignment: Alignment.center,
        child: Text(e,textScaleFactor: 5,),
      );
    }).toList();
  }

  /// PageView 实现方式
  /// 页面主体，PageView，用于承载Tab对应的页面
  /// 手动左右滑动 PageView 时，通过 onPageChanged 回调调用 _tabController.animateTo(index); 同步TabBar状态。
  /// _tabItems 中，监听每个 TabBarItem 的点击，通过  _pageController 实现PageView的状态同步。

  _pageView (){
    return PageView(
        ///必须有的控制器，与tabBar的控制器同步
        controller: _pageController,
        children: _pages(),
        ///页面触摸作用滑动回调，用于同步tab选中状态
        onPageChanged:(index){
        _tabController.animateTo(index);
      }
    );
  }

  late TabController _tabController;
  void initState() {
    super.initState();
    _tabController =  TabController(vsync: this,length: tab.length);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text(widget.title),

        bottom: TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          controller: _tabController,
          tabs: _tabViews(),
          //tab.map((e) => Tab(child: Text(e,style: TextStyle(fontSize: 20),),)).toList(),
          indicatorColor: Colors.white,
          automaticIndicatorColorAdjustment: true,
        ),
      ),
      body: _pageView(),

      // TabBarView(
      //   controller: _tabController,
      //   children: _pages()
      // ),

      // bottomNavigationBar: Material(
      //   color: Colors.black45,
      //   child: TabBar(
      // //必须有的控制器，与pageView的控制器同步
      //     controller: _tabController,
      //     tabs: _tabViews(),
      //     indicatorColor: Colors.white,
      //   ),
      // ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("点击 123");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
