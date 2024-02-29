import 'package:devsociety/controllers/PostController.dart';
import 'package:devsociety/models/Post.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {
  dynamic _content;
  List<Post> _listPost = [];
  bool loading = false;
  int offset = 0;
  int length = 5;
  Map<String, String>? driveHeader;
  PostProvider() {
    getPosts();
  }

  List<Post> get listPost => _listPost;
  dynamic get content => _content;

  Future getPosts() async {
    if (length == 5) {
      loading = true;
      notifyListeners();
      Future.delayed(
        Duration(seconds: 2),
        () async {
          _listPost += await PostController().getPosts(offset, 5);
          length = _listPost.length;
        },
      ).then((value) {
        loading = false;
        offset += 5;
        notifyListeners();
      });
    }
  }

  void addPostToList(Post post) {
    _listPost.insert(0, post);
    notifyListeners();
  }

  void removePostFromList(Post post) {
    _listPost.remove(post);
    notifyListeners();
  }

  void updateContent(dynamic content) {
    _content = content;
    notifyListeners();
  }
}
