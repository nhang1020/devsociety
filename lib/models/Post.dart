// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';


Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

List<Post> listPostFromJson(String str) {
  return List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));
}

String listPostToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  dynamic id;
  dynamic topic;
  dynamic title;
  dynamic content;
  dynamic author;
  DateTime createdAt;
  DateTime updatedAt;

  Post({
    this.id,
    this.topic,
    this.title,
    this.content,
    required this.author,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        topic: json["topic"],
        title: json["title"],
        content: json["content"],
        author: json["author"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "title": title,
        "content": content,
        "author": author,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
