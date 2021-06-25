import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:helloflutter/douban/model/home_model.dart';
import 'package:helloflutter/douban/wigets/LZDashedLine.dart';
import 'package:helloflutter/douban/wigets/LZStartRating.dart';

class MovieListItem extends StatelessWidget {

  final MovieItem movie;
  MovieListItem(this.movie);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 10,color: Color(0xffe2e2e2))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //电影排名
          getMoiveRankWidget(),
          SizedBox(height: 12),
          //具体内容
          getMovieContentWidget(),
          SizedBox(height: 12),
          //电影简介
          SizedBox(height: 12),
          getMovieIntroduceWidget(),
        ],
      ),
    );
  }

  Widget getMoiveRankWidget() {

    return Container(
      padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Color.fromARGB(255, 238, 205, 144)),
      child: Text(
        "NO.${movie.rank}",
        style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 131, 95, 36)),
      ),
    );
  }

  Widget getMovieContentWidget() {
    return Container(
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getContentImage(),
          getContentDesc(),
          getDashLine(),
          getContentWish(),
        ],
      ),
    );
  }

  Widget getContentImage(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(movie.imageURL!),
    );
  }

  Widget getContentDesc(){
    return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTitleWidget(),
              SizedBox(height: 3,),
              getRatingWidget(),
              SizedBox(height: 3,),
              getInfoWidget(),
            ],
          ),
        )
    );
  }

  Widget getDashLine(){
    return Container(
      width: 1,
      height: 100,
      child: LZDashedLine(
        axis: Axis.vertical,
        dashedHeight: 6,
        dashedWidth: 0.5,
        count: 12,
      ),
    );
  }

  Widget getTitleWidget(){
    return Stack(
      children: [
        Icon(Icons.play_circle_outline,color: Colors.redAccent,),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "      " + (movie.title ??= ""),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              ),
              TextSpan(
                text: "(${movie.playDate})",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54
                )
              )
            ],
          ),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget getRatingWidget(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LZStartRating(rating: movie.rating ?? 10,size: 18,),
        SizedBox(width: 5,),
        Text("${movie.rating ?? 10}")
      ],
    );
  }

  Widget getInfoWidget(){
    final genres = movie.genres ?? ["123"].join("000");
    final director = movie.director!.name ;
    var castString = "";
    for(final cast in movie.casts!){
      castString += cast.name! + " ";
    }
    return Text(
        "$genres / $director / $castString",
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 16),
    );
  }

  Widget getContentWish(){
    return Container(
      width: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Image.asset('images/home/wish.png',width: 30,),
          SizedBox(height: 5,),
          Text("想看",
          style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 235, 170 , 60)),)
        ],
      ),
    );
  }

  Widget getMovieIntroduceWidget(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text(movie.originalTitle ?? "",style: TextStyle(fontSize: 18,color: Colors.black54),),
    );
  }
  
}
