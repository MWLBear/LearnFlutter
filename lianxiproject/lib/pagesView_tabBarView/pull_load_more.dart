
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'photo_preview.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with AutomaticKeepAliveClientMixin{

  late ScrollController _scrollController;
  late List<String> images = [];

  @override
  bool get wantKeepAlive => true;

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

  Widget _buildItem(int index){
    InkWell();
    return Container(
      constraints: BoxConstraints.tightFor(height: 150.0),
      child: InkWell(
        onTap: (){
          Navigator.push(context,PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation){
              return FadeTransition(
                opacity: animation as Animation<double>,
                child: PhotoPreview(
                  galleryItems: images,
                  defaultImage: index,
                ),
              );
            }
          ));
        },
        child: Hero(
          child: Image.network(images[index], fit: BoxFit.cover),
          tag: images[index],
        )
      )

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

  ///??????????????????????????????????????????Item
  _getItem(int index) {
    print("length: ${images.length}");
    if(index == images.length  && images.length != 0){
      return _buildProgressIndicator();
    } else if ( images.length == 0) {
      ///?????????0??????????????????
      return _buildEmpty();
    } else {
      ///????????????????????????Item????????????????????????????????????????????????????????????index
      return _buildItem(index);
    }
  }

  ///??????????????????
  _buildProgressIndicator (){

    Widget bottomWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitRotatingCircle(
          color: Color(0xFF24292E),
          size: 50.0,
        ),
        SizedBox(width: 10,),
        Text("?????????...",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
      ],
    );

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
      child: bottomWidget,
      ),
    );
  }

  ///?????????
  Widget _buildEmpty() {
    return Container(
      child: Text("???????????????",style: TextStyle(color: Colors.red),),
    );
  }
}
