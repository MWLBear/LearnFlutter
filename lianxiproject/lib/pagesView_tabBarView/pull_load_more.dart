
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  late ScrollController _scrollController;
  late List<String> images = [];

  @override
  void initState() {
    super.initState();
    fetchTen();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        fetchTen();
      }
    });
  }

  @override
  void dispose() {
    print("first_dispose");
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("pull_ages_build");
    return RefreshIndicator(
            onRefresh:() async{
              await Future.delayed(const Duration(seconds: 2));
              images.clear();
              fetchTen();
            },
            child: GridView.builder(
                itemCount: _getListCount(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.0
                ),
                controller: _scrollController,
                itemBuilder: (ctx , index){
                  return _getItem(index);
                }
            ),
          );
  }

  Widget _buildItem(String url){
    return Container(
      constraints: BoxConstraints.tightFor(height: 150.0),
      child: Image.network(url, fit: BoxFit.cover,),
    );
  }

  void fetch () async{
    var url = Uri.parse('http://dog.ceo/api/breeds/image/random');
    var response = await http.get(url);
    if (response.statusCode == 200){
      final imageurl =  json.decode(response.body)["message"];
      print("object : $imageurl");
      if (mounted){
        setState(() {
          images.add(json.decode(response.body)["message"]);
        });
      }
    }else {
      throw Exception('Failed to load image');
    }
  }

  fetchTen(){
    for (int i = 0; i < 10; i++) {
      fetch();
    }
  }

  _getListCount(){
    if(images.length == 0){
      return 1;
    }else{
      return images.length + 1;
    }
  }

  ///根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    print("length: ${images.length}");
    if(index == images.length  && images.length != 0){
      return _buildProgressIndicator();
    } else if ( images.length == 0) {
      ///数据为0，渲染空页面
      return _buildEmpty();
    } else {
      ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
      return _buildItem(this.images[index]);
    }
  }

  ///上拉加载更多
  _buildProgressIndicator (){

    Widget bottomWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitRotatingCircle(
          color: Color(0xFF24292E),
          size: 50.0,
        ),
        SizedBox(width: 10,),
        Text("加载中...",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
      ],
    );

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
      child: bottomWidget,
      ),
    );
  }

  ///空页面
  Widget _buildEmpty() {
    return Container(
      child: Text("我是空白页",style: TextStyle(color: Colors.red),),
    );
  }
}
