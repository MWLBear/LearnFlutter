class Person {
  String? name;
  String? avatarURL;

  Person(this.name, this.avatarURL);

  Person.formMap(Map<String, dynamic> json) {
    this.name = json['name'];
    this.avatarURL = json['avatars']['medium'];
  }
}

class Actor extends Person {
  Actor(String name, String avatarURL) : super(name, avatarURL);

  Actor.fromMap(Map<String, dynamic> json) : super.formMap(json);
}

class Director extends Actor {
  Director(String name, String avatarURL) : super(name, avatarURL);

  Director.fromMap(Map<String, dynamic> json) : super.fromMap(json);
}

int counter = 1;

class MovieItem {
  int? rank;
  String? imageURL;
  String? title;
  String? playDate;
  double? rating;
  List<String>? genres;
  List<Actor>? casts;
  Director? director;
  String? originalTitle;

  MovieItem(
      {this.rank,
      this.imageURL,
      this.title,
      this.playDate,
      this.rating,
      this.genres,
      this.casts,
      this.director,
      this.originalTitle});

  MovieItem.fromMap(Map<String, dynamic> json) {
    this.rank = counter++;
    this.imageURL = json["images"]["medium"];
    this.title = json["title"];
    this.playDate = json["year"];
    this.rating = json["rating"]["average"];
    this.genres = json["genres"].cast<String>();
    this.casts = (json["casts"] as List<dynamic>).map((item) {
      return Actor.fromMap(item);
    }).toList();
    this.director = Director.fromMap(json["directors"][0]);
    this.originalTitle = json["original_title"];
  }
}
