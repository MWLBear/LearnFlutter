import 'package:flutter/material.dart';
import 'package:helloflutter/douban/model/home_model.dart';
import 'movie_listitem.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<MovieItem> movies = [];

  @override
  void initState() {
    super.initState();
    getMovieTopList();
  }

  void getMovieTopList() {
    Director director = Director("弗兰克·德拉邦特", "avatarURL");
    Actor actor = Actor("蒂姆·罗宾斯", "avatarURL");
    Actor actor1 = Actor("摩根·弗里曼", "avatarURL");
    Actor actor2 = Actor("鲍勃·冈顿", "avatarURL");
    Actor actor3 = Actor("威廉姆·赛德勒", "avatarURL");

    setState(() {
      for (int i = 0; i < 10; i++) {
        MovieItem top = MovieItem(
            rank: i,
            imageURL:
                "https://img2.doubanio.com/view/photo/s_ratio_poster/public/p480747492.webp",
            title: "肖申克的救赎",
            playDate: "1994",
            rating: 9.7,
            genres: ["美国", "犯罪", "剧情"],
            casts: [actor, actor1, actor2, actor3],
            director: director,
            originalTitle: "希望让人自由。");
        movies.add(top);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (ctx, index) {
          return MovieListItem(movies[index]);
        });
  }
}
