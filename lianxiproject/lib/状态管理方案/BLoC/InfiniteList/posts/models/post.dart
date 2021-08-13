import 'package:equatable/equatable.dart';
import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());

class Post extends Equatable {

  const Post({required this.id, required this.title, required this.body});
  final int id;
  final String title;
  final String body;

  @override
  List<Object?> get props => [id,title,body];

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
  };
}