import 'package:devsociety/models/Post.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  String? _content;
  List<Post> _listPost = [
    Post(
        userId: 3,
        title: "Xin chào các bạn",
        topic: "TEXT",
        createdAt: DateTime(2024, 1, 28),
        updatedAt: DateTime.now())
  ];
  PostProvider() {}
  List<Post> get listPost => _listPost;
  String? get content => _content;

  void updateContent(String content) {
    _content = content;
    notifyListeners();
  }
}
