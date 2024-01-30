// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    dynamic id;
    dynamic topic;
    dynamic title;
    dynamic content;
    dynamic userId;
    DateTime createdAt;
    DateTime updatedAt;

    Post({
        this.id,
         this.topic,
         this.title,
         this.content,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        topic: json["topic"],
        title: json["title"],
        content: json["content"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "topic": topic,
        "title": title,
        "content": content,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
