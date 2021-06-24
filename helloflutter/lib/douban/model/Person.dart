class Person {
  String? name;
  String? avatarURL;
  Person.formMap(Map<String,dynamic> json){
    this.name = json['name'];
    this.avatarURL = json['avatars']['medium'];
  }
}
class Actor extends Person {
  Actor.fromMap(Map<String,dynamic> json): super.formMap(json);
}
class Director extends Actor {
  Director.fromMap(Map<String, dynamic> json): super.fromMap(json);
}
