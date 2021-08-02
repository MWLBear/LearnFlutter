import 'dart:ffi';

import 'package:flutter/material.dart';
main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      ),

      home: Scaffold(
        appBar: AppBar(
          title: Text("Hero动画"),
        ),
        body: HomeBody(),
      ) ,
    );
  }
}
class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 16/9
      ),
      children: List.generate(20, (index){
        String imageURL = "https://picsum.photos/300/200?random=$index";
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              PageRouteBuilder(pageBuilder: (ctx,animation,animation2){
                return FadeTransition(
                  opacity: animation,
                  child: LZImageDetail(imageURL),
                );
              }),
            );
          },
          child: Hero(
            tag: imageURL,
            child: Image.network(imageURL,fit: BoxFit.cover,)
          ),
        );
      }),
    );
  }
}

class LZImageDetail extends StatelessWidget {

  final String imageUrl;
  LZImageDetail(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Hero(
            tag: imageUrl,
            child: Image.network(
              this.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
