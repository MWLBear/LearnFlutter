import 'package:helloflutter/douban/model/home_model.dart';
import 'package:helloflutter/service/http_request.dart';
import 'package:flutter/material.dart';

class HomeRequest {
  Future<List<MovieItem>> getMovieTopList(int start, int count) async {
    final url = "https://douban.uieee.com/v2/movie/top250?start=$start&count=$count";
    final result = await HttpRequest.request(url);
    List<MovieItem> movies = [];
    for(var sub in result){
      movies.add(MovieItem.fromMap(sub));
    }
    return movies;
  }
}